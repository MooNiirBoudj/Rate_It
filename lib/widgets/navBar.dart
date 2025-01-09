import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  // Define icon paths
  static const _iconPaths = {
    'home': {
      'default': 'assets/icons/navBarIcons/home.png',
      'active': 'assets/icons/navBarIcons/homeActive.png',
    },
    'rooms': {
      'default': 'assets/icons/navBarIcons/rooms.png',
      'active': 'assets/icons/navBarIcons/roomsActive.png',
    },
    'create': {
      'default': 'assets/icons/navBarIcons/create.png',
      'active': 'assets/icons/navBarIcons/createActive.png',
    },
    'notifications': {
      'default': 'assets/icons/navBarIcons/notifications.png',
      'active': 'assets/icons/navBarIcons/notificationsActive.png',
    },
  };

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    
    return Container(
      color:  Color(0xFFFDF8EA),
      child: SizedBox(
        height: 80 + bottomPadding,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 65 + bottomPadding,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 12,
                      spreadRadius: 2,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildNavItem(0, 'home', 'Home', context),
                        _buildNavItem(1, 'rooms', 'Rooms', context),
                        _buildNavItem(2, 'create', 'Create', context),
                        _buildNavItem(3, 'notifications', 'Notifications', context),
                      ],
                    ),
                    SizedBox(height: bottomPadding),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: _calculateIndicatorPosition(context),
              child: _buildIndicator(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, String iconKey, String label, BuildContext context) {
    final isSelected = currentIndex == index;
    final itemWidth = MediaQuery.of(context).size.width / 4;
    
    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: itemWidth,
        height: 65,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: isSelected ? 20 : 0),
            AnimatedScale(
              duration: const Duration(milliseconds: 200),
              scale: isSelected ? 0.0 : 1.0,
              child: Image.asset(
                _iconPaths[iconKey]!['default']!,
                width: 24,
                height: 24,
                color: isSelected ? Colors.transparent : Colors.grey,
              ),
            ),
            if (!isSelected) const SizedBox(height: 4),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: isSelected ? 0.0 : 1.0,
              child: Text(
                label,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIndicator() {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFFFFC107),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFFC107).withOpacity(0.3),
            blurRadius: 8,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return ScaleTransition(
            scale: animation,
            child: child,
          );
        },
        child: Image.asset(
          _getActiveIconPath(),
          key: ValueKey<int>(currentIndex),
          width: 30,
          height: 30,
          color: Colors.white,
        ),
      ),
    );
  }

  String _getActiveIconPath() {
    switch (currentIndex) {
      case 0:
        return _iconPaths['home']!['active']!;
      case 1:
        return _iconPaths['rooms']!['active']!;
      case 2:
        return _iconPaths['create']!['active']!;
      case 3:
        return _iconPaths['notifications']!['active']!;
      default:
        return _iconPaths['home']!['active']!;
    }
  }

  double _calculateIndicatorPosition(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = screenWidth / 4;
    final indicatorWidth = 60.0;
    return (itemWidth * currentIndex) + (itemWidth - indicatorWidth) / 2;
  }
}