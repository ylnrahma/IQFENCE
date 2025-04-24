import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:iqfence/screens/aboutPage.dart';
import 'dart:io';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();
  String _attendanceStatus = 'Belum melakukan absensi';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Dashboard Absensi'),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Status Absensi:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  _attendanceStatus,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 24),
              Center(
                child: ElevatedButton.icon(
                  onPressed: _startFaceRecognition,
                  icon: Icon(Icons.camera_alt),
                  label: Text('Scan Wajah'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 50),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info_outline),
              label: 'Info',
            ),
          ],
          onTap: (index) {
            if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutPage()),
              );
            }
          },
        ),
      ),
    );
  }

  void _startFaceRecognition() async {
    // Simulasi proses face recognition
    setState(() {
      _attendanceStatus = 'Memproses wajah...';
    });

    await Future.delayed(Duration(seconds: 2));

    // Simulasi hasil sukses
    setState(() {
      _attendanceStatus = 'Absensi berhasil! Wajah dikenali';
    });

    // Simpan ke Firebase Realtime Database (opsional)
    final timestamp = DateTime.now().toIso8601String();
    final userId = 'user123'; // Ganti dengan user ID sebenarnya dari FirebaseAuth

    await _databaseReference.child('absensi/$userId').push().set({
      'status': 'Hadir',
      'timestamp': timestamp,
    });
  }
}
