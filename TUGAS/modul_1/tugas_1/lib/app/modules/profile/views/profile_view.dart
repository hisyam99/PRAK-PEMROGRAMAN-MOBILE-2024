// File 2: /lib/app/modules/profile/views/profile_view.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reparin_mobile/app/modules/navbar/views/navbar_view.dart';
import '../controllers/profile_controller.dart';

class ProfileViews extends GetView<ProfileController> {
  const ProfileViews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back(); // Navigate back
          },
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),

          // Profile Picture with Image Picker functionality
          GestureDetector(
            onTap: () {
              controller.pickImage(); // Panggil method untuk memilih gambar
            },
            child: Obx(() {
              return CircleAvatar(
                radius: 50,
                backgroundImage: controller.imagePath.value.isNotEmpty
                    ? FileImage(File(controller.imagePath.value))
                    : const AssetImage('assets/default_avatar.png')
                        as ImageProvider,
              );
            }),
          ),
          const SizedBox(height: 10),

          // User Name
          const Text(
            'Dave',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),

          // Profile Options List
          Expanded(
            child: ListView(
              children: [
                _buildProfileOption(
                  context,
                  title: 'Your Profile',
                  icon: Icons.person,
                  onTap: () {
                    // Navigate to profile details
                    Get.toNamed('/profile/edit');
                  },
                ),
                _buildProfileOption(
                  context,
                  title: 'Manage Address',
                  icon: Icons.location_on,
                  onTap: () {
                    // Navigate to manage address
                  },
                ),
                _buildProfileOption(
                  context,
                  title: 'Payment Methods',
                  icon: Icons.payment,
                  onTap: () {
                    // Navigate to payment methods
                  },
                ),
                _buildProfileOption(
                  context,
                  title: 'My Bookings',
                  icon: Icons.calendar_today,
                  onTap: () {
                    // Navigate to bookings
                  },
                ),
                _buildProfileOption(
                  context,
                  title: 'My Wallet',
                  icon: Icons.account_balance_wallet,
                  onTap: () {
                    // Navigate to wallet
                  },
                ),
                _buildProfileOption(
                  context,
                  title: 'Settings',
                  icon: Icons.settings,
                  onTap: () {
                    // Navigate to settings
                  },
                ),
                _buildProfileOption(
                  context,
                  title: 'Help Center',
                  icon: Icons.help_outline,
                  onTap: () {
                    // Navigate to help center
                  },
                ),
                _buildProfileOption(
                  context,
                  title: 'Privacy Policy',
                  icon: Icons.privacy_tip,
                  onTap: () {
                    // Navigate to privacy policy
                  },
                ),
                _buildProfileOption(
                  context,
                  title: 'Sign Out',
                  icon: Icons.logout,
                  onTap: () {
                    controller.signOut(); // Panggil metode sign out
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar:
          const CustomBottomNavigationBar(), // Use Custom BottomNavigationBar here
    );
  }

  // Helper function to build profile options
  Widget _buildProfileOption(BuildContext context,
      {required String title,
      required IconData icon,
      required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }
}
