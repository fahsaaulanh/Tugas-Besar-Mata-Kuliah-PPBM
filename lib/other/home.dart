import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.deepPurple.shade200, Colors.blue.shade50],
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Selamat datang di Aplikasi!',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: Colors.black.withOpacity(0.5),
                    offset: Offset(4.0, 4.0),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            // Menampilkan Riwayat Telepon
            _buildCallHistory(),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk membangun card daftar riwayat telepon
  Widget _buildCallHistory() {
    // Daftar riwayat telepon dummy
    List<Map<String, String>> callHistory = [
      {'name': 'WangWook', 'phone': '08123456789', 'time': '10:15 AM'},
      {'name': 'Lee Min Dik', 'phone': '08234567890', 'time': '09:45 AM'},
      {'name': 'WangSoo', 'phone': '08345678901', 'time': '08:30 AM'},
    ];

    return Column(
      children: [
        Text(
          'Riwayat Telepon',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 20),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: callHistory.length,
          itemBuilder: (context, index) {
            var call = callHistory[index];
            return Card(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: Icon(
                  Icons.call,
                  color: Colors.green,
                  size: 40,
                ),
                title: Text(
                  call['name']!,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  'Telepon ke: ${call['phone']} \nWaktu: ${call['time']}',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}