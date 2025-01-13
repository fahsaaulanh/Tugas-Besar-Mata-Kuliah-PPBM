import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayerPage extends StatefulWidget {
  const YoutubePlayerPage({Key? key}) : super(key: key);

  @override
  State<YoutubePlayerPage> createState() => _YoutubePlayerPageState();
}

class _YoutubePlayerPageState extends State<YoutubePlayerPage> {
  late YoutubePlayerController _controller;

  // Dummy list video
  final List<Map<String, String>> videos = [
    {
      'videoId': 'yvsvkf-RXck',
      'title': 'Cute Rabbit Collection',
      'description': 'Watch a collection of the cutest rabbits in HD.',
      'thumbnail': 'https://img.youtube.com/vi/yvsvkf-RXck/0.jpg',
    },
    {
      'videoId': 'TlBMcexUwjE',
      'title': 'Adorable Rabbits',
      'description': 'Discover adorable rabbits and their playful antics.',
      'thumbnail': 'https://img.youtube.com/vi/TlBMcexUwjE/0.jpg',
    },
    {
      'videoId': '_v94XqFW4Qw',
      'title': 'Rabbit Cuteness Overload',
      'description': 'Experience a rabbit cuteness overload in this video.',
      'thumbnail': 'https://img.youtube.com/vi/_v94XqFW4Qw/0.jpg',
    },
    {
      'videoId': 'QnBsJNo9H2U',
      'title': 'Cute Rabbit Collection',
      'description': 'Ultimate Cute Rabbit Collection in  HD High QualityCute.',
      'thumbnail': 'https://img.youtube.com/vi/QnBsJNo9H2U/0.jpg',
    },
    {
      'videoId': 'yvsvkf-RXck',
      'title': 'Cute Rabbit Collection',
      'description': 'Ultimate Cute Rabbit Collection in  HD High QualityCute.',
      'thumbnail': 'https://img.youtube.com/vi/yvsvkf-RXck/0.jpg',
    },
  ];

  @override
  void initState() {
    super.initState();
    // Initialize player with the first video
    _controller = YoutubePlayerController(
      initialVideoId: videos[0]['videoId']!,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        forceHD: true,
        controlsVisibleAtStart: true,
        loop: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressColors: const ProgressBarColors(
          playedColor: Colors.blue,
          handleColor: Colors.blueAccent,
        ),
      ),
      builder: (context, player) {
        return Scaffold(
          backgroundColor: const Color(0xFF7893FF),
          appBar: _buildAppBar(),
          body: _buildBody(player),
        );
      },
    );
  }

  // Custom AppBar
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFF7893FF),
      elevation: 0,
      centerTitle: true,
      title: const Text(
        'Youtube Player',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  // Custom Body
  Widget _buildBody(Widget player) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFE9E6F7),
            Color(0xFFE9E6F7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          player,
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: videos.length,
              itemBuilder: (context, index) {
                final video = videos[index];
                return _buildVideoTile(
                  videoId: video['videoId']!,
                  title: video['title']!,
                  description: video['description']!,
                  thumbnailUrl: video['thumbnail']!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Video Tile Widget
  Widget _buildVideoTile({
    required String videoId,
    required String title,
    required String description,
    required String thumbnailUrl,
  }) {
    return GestureDetector(
      onTap: () {
        _controller.load(videoId);
        _controller.play();
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Image.network(
                thumbnailUrl,
                width: 120,
                height: 80,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
