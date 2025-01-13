import 'package:flutter/material.dart';

import '../other/calculator.dart';
import '../other/home.dart';
import '../other/telfon.dart';
import '../other/youtube.dart';
import 'HomePageChat.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return HomePageChat(); // Halaman utama
      case 1:
        return ContactsPage(); // Halaman daftar telepon
      case 2:
        return CalculatorPage(); // Halaman kalkulator
      case 3:
        return YoutubePage(); // Halaman
      default:
        return HomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getPage(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.shifting,
        selectedItemColor: const Color(0xFFF84669), // Warna ikon saat selected
        unselectedItemColor: Colors.grey[500], // Warna ikon saat tidak selected
        selectedFontSize: 14, // Ukuran teks saat selected
        unselectedFontSize: 12, // Ukuran teks saat tidak selected
        elevation: 10,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.chat_outlined),
            activeIcon: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF7893FF), Color(0xFF7893FF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(6.0),
              child: const Icon(Icons.chat, color: Colors.white),
            ),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.contacts_outlined),
            activeIcon: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF7893FF), Color(0xFF7893FF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(6.0),
              child: const Icon(Icons.contacts, color: Colors.white),
            ),
            label: 'Contacts',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.calculate_outlined),
            activeIcon: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF7893FF), Color(0xFF7893FF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(6.0),
              child: const Icon(Icons.calculate, color: Colors.white),
            ),
            label: 'Calculator',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.video_library_outlined),
            activeIcon: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF7893FF), Color(0xFF7893FF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(6.0),
              child: const Icon(Icons.video_library, color: Colors.white),
            ),
            label: 'YouTube',
          ),
        ],
      ),
    );
  }
}
