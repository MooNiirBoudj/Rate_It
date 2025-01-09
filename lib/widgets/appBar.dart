import 'package:flutter/material.dart';
import 'package:rate_it/styles/style.dart';
import 'package:rate_it/screens/mainApp/settings.dart'; // Import the Settings screen

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false, // Disables the back arrow
      title: Row(
        children: [
          Image.asset(
            'assets/logo/logo-horizental-removebg-preview.png',
            height: 140,
            width: 140,
          ),
          const SizedBox(width: AppSpacing.sm),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsScreen()),
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
