import 'package:flutter/material.dart';
import 'package:rate_it/styles/style.dart';
import 'package:rate_it/widgets/appBar.dart';

class RoomsScreen extends StatefulWidget {
  const RoomsScreen({super.key});

  @override
  State<RoomsScreen> createState() => _RoomsScreenState();
}

class _RoomsScreenState extends State<RoomsScreen> {
  String selectedCategory = 'All';

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
        appBar: const CommonAppBar(),
        body: Column(
          children: [
            Padding(
              padding: AppSpacing.paddingAll,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search user, topic...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: AppSpacing.paddingHorizontal,
              child: Row(
                children: [
                  _buildCategoryChip('All'),
                  _buildCategoryChip('Fashion'),
                  _buildCategoryChip('Football'),
                  _buildCategoryChip('Food'),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: AppSpacing.paddingAll,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return _buildRoomCard();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String label) {
    final bool isSelected = selectedCategory == label;

    return Padding(
      padding: const EdgeInsets.only(right: AppSpacing.sm),
      child: InkWell(
        onTap: () {
          setState(() {
            selectedCategory = label;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: isSelected ? AppTheme.primaryColor : Colors.white,
            border: Border.all(color: AppTheme.textColor),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            label,
            style: AppTextStyles.body.copyWith(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoomCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.textColor, width: 1),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: ListTile(
        contentPadding: AppSpacing.paddingAll,
        leading: const CircleAvatar(
          backgroundColor: Colors.grey,
          child: Icon(Icons.photo, color: Colors.white),
        ),
        title: Text(
          'Room Name',
          style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
          '12 member',
          style: AppTextStyles.caption,
        ),
        trailing: ElevatedButton(
          onPressed: () {},
          style: AppButtonStyles.primaryButton,
          child: const Text('Join'),
        ),
      ),
    );
  }
}
