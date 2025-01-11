import 'package:flutter/material.dart';
import 'package:rate_it/styles/style.dart';
import 'package:rate_it/screens/mainApp/homeFunctionalities/feed.dart';
import 'package:rate_it/screens/mainApp/homeFunctionalities/createRoom.dart';
import 'package:rate_it/screens/mainApp/rooms.dart';
import 'package:rate_it/widgets/appBar.dart'; // Import the common app bar

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: AppTheme.gradientColors,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const CommonAppBar(), // Use the common app bar
        body: Padding(
          padding: AppSpacing.paddingAll,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Your rooms',
                style: AppTextStyles.heading2,
              ),
              const SizedBox(height: AppSpacing.md),
              InkWell(
                onTap: () {
                  Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FeedScreen()),
            );
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppTheme.textColor, width: 1),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  child: ListTile(
                    contentPadding: AppSpacing.paddingAll,
                    leading: const CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.devices_other, color: Colors.white),
                    ),
                    title: Text(
                      'Mobile',
                      style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(
                      'Room content overview',
                      style: AppTextStyles.caption,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CreateRoomScreen()),
            );
                  },
                  style: AppButtonStyles.primaryButton,
                  child: Text(
                    'Create room',
                    style: AppTextStyles.body,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                 Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RoomsScreen()),
            );
                },
                child: Text(
                  'or join a room',
                  style: AppTextStyles.caption,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
