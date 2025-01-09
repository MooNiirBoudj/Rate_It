import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'screens/preApp/splashScreen.dart';
import 'screens/preApp/login.dart';
import 'screens/preApp/welcome.dart';
import 'screens/preApp/signup.dart';
import 'screens/mainApp/home.dart';
import 'screens/mainApp/rooms.dart';
import 'screens/mainApp/create.dart';
import 'screens/mainApp/notifications.dart';
import 'widgets/navBar.dart';
import 'styles/style.dart';

void main() {
  runApp(const MainApp());
  debugPaintSizeEnabled=false;
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RateIt',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.themeData,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/welcome': (context) => Welcome(),
        '/login': (context) => Login(),
        '/signup': (context) => Signup(),
        '/main': (context) => const NavigationWrapper(),
      },
    );
  }
}

class NavigationWrapper extends StatefulWidget {
  const NavigationWrapper({super.key});

  @override
  State<NavigationWrapper> createState() => _NavigationWrapperState();
}

class _NavigationWrapperState extends State<NavigationWrapper> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const RoomsScreen(),
    const CreateScreen(),
    const NotificationsScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Handle back button press
        if (_currentIndex != 0) {
          setState(() {
            _currentIndex = 0;
          });
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: _pages,
        ),
        bottomNavigationBar: CustomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}