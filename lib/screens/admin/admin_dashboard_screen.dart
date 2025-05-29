import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart'; 

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            const CircleAvatar(
              backgroundColor: Colors.orange,
              child: Icon(Icons.home, color: Colors.white),
            ),
            const SizedBox(width: 8),
            const Text(
              'IQFace',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const Spacer(),
            const Text(
              'Admin',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Kotak Jam Kerja
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.amber[700],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Jam Kerja", style: TextStyle(fontSize: 16, color: Colors.white)),
                      Text("Sen, 11 Januari 2024", style: TextStyle(fontSize: 14, color: Colors.white)),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    "08.00 - 16.00",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Selamat beraktivitas",
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Menu Grid
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1,
                children: [
                  _DashboardMenuItem(
                    icon: LucideIcons.fileClock,
                    title: "Kelola Izin",
                    color: Colors.amber[700]!,
                    onTap: () {},
                  ),
                  _DashboardMenuItem(
                    icon: LucideIcons.mapPin,
                    title: "Kelola Lokasi",
                    color: Colors.amber[700]!,
                    onTap: () {},
                  ),
                  _DashboardMenuItem(
                    icon: LucideIcons.clock4,
                    title: "Riwayat",
                    color: Colors.amber[700]!,
                    onTap: () {},
                  ),
                  _DashboardMenuItem(
                    icon: LucideIcons.calendarClock,
                    title: "Kelola Lembur",
                    color: Colors.amber[700]!,
                    showNotification: true,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.amber[700],
        unselectedItemColor: Colors.grey,
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Beranda",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profil",
          ),
        ],
      ),
    );
  }
}

class _DashboardMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onTap;
  final bool showNotification;

  const _DashboardMenuItem({
    required this.icon,
    required this.title,
    required this.color,
    required this.onTap,
    this.showNotification = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, size: 36, color: Colors.white),
                  const SizedBox(height: 8),
                  Text(title, style: const TextStyle(color: Colors.white)),
                ],
              ),
            ),
            if (showNotification)
              Positioned(
                top: 8,
                right: 12,
                child: CircleAvatar(
                  radius: 8,
                  backgroundColor: Colors.red,
                  child: const Text("!", style: TextStyle(fontSize: 12, color: Colors.white)),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
