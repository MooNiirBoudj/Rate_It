import 'package:flutter/material.dart';
import 'package:rate_it/widgets/appBar.dart';
import 'package:rate_it/styles/style.dart'; // Import your style file

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: AppTheme.gradientColors,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent, // Set to transparent for gradient to show
        appBar: const CommonAppBar(),
        body: ListView(
          padding: AppSpacing.paddingAll,
          children: [
            buildPost(
              userName: "Osimen Zabata",
              timeAgo: "23 min",
              caption: "Nice car innit LOL",
              imageUrl: "https://via.placeholder.com/300x200", // Replace with actual image URL
              rating: 3.7,
              feedbackCount: 3,
            ),
            const SizedBox(height: AppSpacing.md),
            buildPost(
              userName: "Rose",
              timeAgo: "23 min",
              caption: "I took this picture with my phone",
              imageUrl: "https://via.placeholder.com/300x200", // Replace with actual image URL
              rating: null, // No rating for this post
              feedbackCount: 0,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPost({
    required String userName,
    required String timeAgo,
    required String caption,
    required String imageUrl,
    double? rating,
    int? feedbackCount,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: AppSpacing.paddingAll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User information
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: const NetworkImage(
                    "https://via.placeholder.com/150", // Replace with user's avatar URL
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: AppTextStyles.heading2,
                    ),
                    Text(
                      timeAgo,
                      style: AppTextStyles.caption,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),

            // Caption
            Text(
              caption,
              style: AppTextStyles.body,
            ),
            const SizedBox(height: AppSpacing.md),

            // Post image
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200,
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            // Rating and Feedback
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (rating != null)
                  Row(
                    children: [
                      Text(
                        "$rating",
                        style: AppTextStyles.body,
                      ),
                      const Icon(Icons.star, color: AppTheme.primaryColor, size: 16),
                    ],
                  ),
                if (feedbackCount != null)
                  Text(
                    "$feedbackCount feedbacks",
                    style: AppTextStyles.body,
                  ),
              ],
            ),
            const Divider(),

            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildActionItem(Icons.star, "Rate"),
                buildActionItem(Icons.feedback, "Feedback"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildActionItem(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, size: 20, color: AppTheme.textColor),
        const SizedBox(height: AppSpacing.xs),
        Text(
          label,
          style: AppTextStyles.caption,
        ),
      ],
    );
  }
}
