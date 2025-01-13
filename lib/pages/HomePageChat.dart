import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/pages/ChatPage.dart';
import 'package:chat_app/service/auth/auth_service.dart';
import 'package:chat_app/service/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePageChat extends StatefulWidget {
  const HomePageChat({super.key});

  @override
  State<HomePageChat> createState() => _HomePageChatState();
}

class _HomePageChatState extends State<HomePageChat> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void signOut() {
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF7893FF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Chat, ${_auth.currentUser?.email ?? "User"}',
          style: const TextStyle(color: Colors.white),
        ),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFA4B4F6),
                    Color(0xFFA4B4F6),
                    Color(0xFFF7DAFF),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                      'https://www.creativefabrica.com/wp-content/uploads/2019/01/Avatar-by-Iconika-580x437.jpg',
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _auth.currentUser?.email ?? "User Name",
                    style:
                        const TextStyle(color: Color(0xFF060088), fontSize: 20),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.edit, color: Color(0xFFF84669)),
              title: const Text(
                'Edit Profile',
                style: TextStyle(color: Color(0xFF8A8A8A)),
              ),
              trailing: const Icon(Icons.arrow_forward_ios,
                  color: Color(0xFFC9C7FF), size: 16),
              onTap: () {
                // Navigasi ke halaman Edit Profile
              },
            ),
            ListTile(
              leading:
                  const Icon(Icons.notifications, color: Color(0xFFF84669)),
              title: const Text(
                'Notifications',
                style: TextStyle(color: Color(0xFF8A8A8A)),
              ),
              trailing: const Icon(Icons.arrow_forward_ios,
                  color: Color(0xFFC9C7FF), size: 16),
              onTap: () {
                // Navigasi ke halaman Notifications
              },
            ),
            ListTile(
              leading: const Icon(Icons.lock, color: Color(0xFFF84669)),
              title: const Text(
                'Change Password',
                style: TextStyle(color: Color(0xFF8A8A8A)),
              ),
              trailing: const Icon(Icons.arrow_forward_ios,
                  color: Color(0xFFC9C7FF), size: 16),
              onTap: () {
                // Navigasi ke halaman Change Password
              },
            ),
            ListTile(
              leading: const Icon(Icons.language, color: Color(0xFFF84669)),
              title: const Text(
                'Language',
                style: TextStyle(color: Color(0xFF8A8A8A)),
              ),
              trailing: const Icon(Icons.arrow_forward_ios,
                  color: Color(0xFFC9C7FF), size: 16),
              onTap: () {
                // Navigasi ke halaman Language
              },
            ),
            ListTile(
              leading: const Icon(Icons.help, color: Color(0xFFF84669)),
              title: const Text(
                'Help & Support',
                style: TextStyle(color: Color(0xFF8A8A8A)),
              ),
              trailing: const Icon(Icons.arrow_forward_ios,
                  color: Color(0xFFC9C7FF), size: 16),
              onTap: () {
                // Navigasi ke halaman Help & Support
              },
            ),
            const Divider(
              height: 0.2,
              thickness: 0.2,
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: MyButton(
                onTap: signOut, // Fungsi untuk logout
                text: 'Logout',
                icon: Icons
                    .logout, // Gunakan IconData langsung, seperti Icons.logou
              ),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFFE9E6F7),
              Color(0xFFE9E6F7),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: _buildUserList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Logika untuk tombol tambah
          // Contoh: navigasi ke halaman untuk menambahkan teman
        },
        backgroundColor: const Color(0xFF7893FF), // Warna tombol
        child: const Icon(Icons.add, color: Colors.white), // Ikon tambah
      ),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading users'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No users found'));
          }

          return ListView(
            children:
                snapshot.data!.docs.map((doc) => _buildUserItem(doc)).toList(),
          );
        });
  }

  Widget _buildUserItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    if (_auth.currentUser?.email != data['email']) {
      String receiverID = data['uid'];
      String receiverEmail = data['email'];
      String currentUserID = _auth.currentUser!.uid;

      return StreamBuilder<QuerySnapshot>(
        stream: ChatService().getMessages(currentUserID, receiverID),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Get messages and unread count
          final messages = snapshot.data!.docs;
          final unreadCount = messages.where((message) {
            final data = message.data() as Map<String, dynamic>;
            return data['receiverID'] == currentUserID &&
                !(data['isRead'] ?? false);
          }).length;

          // Get last message
          final lastMessage = messages.isNotEmpty
              ? (messages.last.data() as Map<String, dynamic>)['message']
              : 'No messages yet';

          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatPage(
                    receiverEmail: receiverEmail,
                    receiverID: receiverID,
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: const Color(0xFFF84669),
                        backgroundImage: NetworkImage(
                          data['avatar'] ??
                              'https://www.creativefabrica.com/wp-content/uploads/2019/01/Avatar-by-Iconika-580x437.jpg',
                        ),
                        radius: 30,
                      ),
                      title: Text(
                        receiverEmail,
                        style: const TextStyle(
                          color: Color(0xFF060088),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        lastMessage,
                        style: const TextStyle(color: Colors.grey),
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: unreadCount > 0
                          ? Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF84669),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                unreadCount.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          : null,
                    ),
                  ),
                  const Divider(
                    color: Color.fromARGB(255, 200, 200, 200),
                  ),
                ],
              ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
