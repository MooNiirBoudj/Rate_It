import 'package:flutter/material.dart';
import 'package:rate_it/widgets/appBar.dart';
import 'package:rate_it/styles/style.dart';
import 'package:rate_it/screens/mainApp/homeFunctionalities/comments.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  bool showRatingStars = false;
  double? selectedRating;
  final double starSize = 30.0;
  final GlobalKey rateButtonKey = GlobalKey();
  OverlayEntry? _overlayEntry;

  @override
  void dispose() {
    _overlayEntry?.remove();
    super.dispose();
  }

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
        backgroundColor: Colors.transparent,
        appBar: const CommonAppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: AppSpacing.md,
                top: AppSpacing.sm,
                bottom: AppSpacing.md,
              ),
              child: Text(
                'Mobile Room',
                style: AppTextStyles.heading2,
              ),
            ),
            Expanded(
              child: ListView(
                padding: AppSpacing.paddingAll,
                children: [
                  buildPost(
                    context: context,
                    userName: "Osimen Zabata",
                    timeAgo: "23 min",
                    caption: "Nice car innit LOL",
                    rating: selectedRating ?? 3.7,
                    feedbackCount: 3,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showStarRating() {
    final RenderBox? rateButtonBox =
        rateButtonKey.currentContext?.findRenderObject() as RenderBox?;
    final RenderBox? overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox?;

    if (rateButtonBox == null || overlay == null) return;

    final buttonPosition = rateButtonBox.localToGlobal(Offset.zero);
    final overlayPosition = overlay.localToGlobal(Offset.zero);

    final relativePosition = Offset(
      buttonPosition.dx - overlayPosition.dx,
      buttonPosition.dy - overlayPosition.dy,
    );

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: relativePosition.dy - 60, // Adjust this value to position above button
        left: 0,
        right: 0,
        child: Material(
          color: Colors.transparent,
          child: GestureDetector(
            onTapDown: handleStarRating,
            onTapUp: (_) => hideStarRating(),
            child: Container(
              color: Colors.transparent,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(5, (index) {
                      final bool isFilled = (selectedRating ?? 0) > index;
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.xs,
                        ),
                        child: Image.asset(
                          isFilled
                              ? 'assets/icons/postsIcons/fullSar.png'
                              : 'assets/icons/postsIcons/emptyStar.png',
                          width: starSize,
                          height: starSize,
                          color: isFilled ? AppTheme.primaryColor : Colors.grey,
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void hideStarRating() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() {
      showRatingStars = false;
    });
  }

  void handleStarRating(TapDownDetails details) {
    final RenderBox? overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox?;
    if (overlay == null) return;

    final localPosition = overlay.globalToLocal(details.globalPosition);
    final double screenWidth = overlay.size.width;
    final double totalStarsWidth = (starSize + AppSpacing.xs * 2) * 5;
    final double startX = (screenWidth - totalStarsWidth) / 2;

    final double relativeX = localPosition.dx - startX;
    final int starIndex = (relativeX / (starSize + AppSpacing.xs * 2)).floor();

    if (starIndex >= 0 && starIndex < 5) {
      setState(() {
        selectedRating = (starIndex + 1).toDouble();
      });
      hideStarRating();
    }
  }

  Widget buildPost({
    required BuildContext context,
    required String userName,
    required String timeAgo,
    required String caption,
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
            InkWell(
              onTap: () {
                // Handle user profile tap
              },
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: const AssetImage('assets/images/1.png'),
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
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              caption,
              style: AppTextStyles.body,
            ),
            const SizedBox(height: AppSpacing.md),
            InkWell(
              onTap: () {
                // Handle image tap
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/images/1.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (rating != null)
                  Row(
                    children: [
                      Text(
                        rating.toStringAsFixed(1),
                        style: AppTextStyles.body,
                      ),
                      Image.asset(
                        'assets/icons/postsIcons/rate.png',
                        width: 16,
                        height: 16,
                      ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildActionButton(
                  key: rateButtonKey,
                  icon: 'assets/icons/postsIcons/rate.png',
                  label: "Rate",
                  onTap: () {
                    showStarRating();
                  },
                ),
                buildActionButton(
                  icon: 'assets/icons/postsIcons/thinking.png',
                  label: "Feedback",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CommentsScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildActionButton({
    Key? key,
    required String icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      key: key,
      onTap: onTap,
      child: Column(
        children: [
          Image.asset(
            icon,
            width: 20,
            height: 20,
            color: AppTheme.textColor,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            label,
            style: AppTextStyles.caption,
          ),
        ],
      ),
    );
  }
}