import 'package:flutter/material.dart';
import 'package:rate_it/styles/style.dart';
import 'package:rate_it/widgets/appBar.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: AppTheme.gradientColors,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const CommonAppBar(),
        body: Container(
          margin: EdgeInsets.only(top: AppSpacing.md),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppSpacing.lg),
              topRight: Radius.circular(AppSpacing.lg),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppSpacing.lg),
              topRight: Radius.circular(AppSpacing.lg),
            ),
            child: ListView(
              children: [
                _buildSection('Today', [
                  _buildNotification(
                    'Louis just rated your recent post.',
                    '23min ago',
                  ),
                  _buildNotification(
                    'Ahmed posted a video.',
                    '1h ago',
                  ),
                  _buildNotification(
                    'Louis posted a new picture, be the first to react!',
                    '6h ago',
                  ),
                ]),
                _buildSection('Yesterday', [
                  _buildNotification(
                    'Ahmed started following you.',
                    '1d ago',
                  ),
                  _buildNotification(
                    'Louis commented on your post.',
                    '1d ago',
                  ),
                  _buildNotification(
                    'Lisa posted a new picture.',
                    '1d ago',
                  ),
                  _buildNotification(
                    'Lisa commented on your post.',
                    '1d ago',
                  ),
                ]),
                _buildSection('A Long Time Ago', []),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> notifications) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: AppSpacing.md,
            right: AppSpacing.md,
            top: AppSpacing.md,
            bottom: notifications.isEmpty ? AppSpacing.md : AppSpacing.sm,
          ),
          child: Text(
            title,
            style: AppTextStyles.heading2,
          ),
        ),
        if (notifications.isEmpty)
          Center(
            child: Padding(
              padding: AppSpacing.paddingAll,
              child: Text(
                'No notifications',
                style: AppTextStyles.caption,
              ),
            ),
          )
        else
          ...notifications,
      ],
    );
  }

  Widget _buildNotification(String message, String time) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: AppTheme.primaryColor,
          child: Icon(Icons.person, color: AppTheme.textColor),
        ),
        title: Text(
          message,
          style: AppTextStyles.body,
        ),
        subtitle: Text(
          time,
          style: AppTextStyles.caption,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
      ),
    );
  }
}