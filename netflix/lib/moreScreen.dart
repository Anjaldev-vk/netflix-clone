import 'package:flutter/material.dart';


class NetflixMoreApp extends StatelessWidget {
  const NetflixMoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          elevation: 0,
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white, fontFamily: 'Helvetica'),
        ),
      ),
      home: const MoreScreen(),
    );
  }
}

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      title: Row(
        children: [
          Image.asset(
            'assets/netflix_logo.png', // Replace with the correct path to your logo asset
            height: 24,
          ),
          const SizedBox(width: 8),
          
        ],
      ),
        
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.grey[800],
                    child: const Icon(Icons.person, color: Colors.white, size: 28),
                  ),
                  const SizedBox(width: 12),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'User Name',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Manage Profiles',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.grey, thickness: 0.5),
            // Menu Items
            _buildMenuItem(
              icon: Icons.person_outline,
              title: 'Account',
              onTap: () {
                // Navigate to Account screen
              },
            ),
            _buildMenuItem(
              icon: Icons.settings_outlined,
              title: 'App Settings',
              onTap: () {
                // Navigate to Settings screen
              },
            ),
            _buildMenuItem(
              icon: Icons.download_outlined,
              title: 'Downloads',
              onTap: () {
                // Navigate to Downloads screen
              },
            ),
            _buildMenuItem(
              icon: Icons.help_outline,
              title: 'Help Center',
              onTap: () {
                // Navigate to Help Center
              },
            ),
            _buildMenuItem(
              icon: Icons.privacy_tip_outlined,
              title: 'Privacy',
              onTap: () {
                // Navigate to Privacy screen
              },
            ),
            _buildMenuItem(
              icon: Icons.info_outline,
              title: 'Legal Notices',
              onTap: () {
                // Navigate to Legal Notices
              },
            ),
            const Divider(color: Colors.grey, thickness: 0.5),
            // Sign Out Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Center(
                child: TextButton(
                  onPressed: () {
                    // Handle sign out
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Signed out')),
                    );
                  },
                  child: const Text(
                    'Sign Out',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Netflix Logo
           
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.chevron_right,
              color: Colors.grey,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}