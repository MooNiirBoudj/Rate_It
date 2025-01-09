import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isNotificationsEnabled = true;
  String Name = 'Micheal John';
  String userName = 'Micheal_John12754';

  String correctPassword = '123456';
  File? _image;
  final ImagePicker _picker = ImagePicker();

  @override
Widget build(BuildContext context) {
  return Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFFE7BC2F),
          Color.fromARGB(255, 254, 233, 163),
          Color(0xFFFFF6DA),
          Color(0xFFFDF8EA),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    ),
    child: Scaffold(
      backgroundColor: Colors.transparent, // Let the gradient show through
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.black,     fontWeight: FontWeight.bold,
),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildRoundedSection(
                'Your Account',
                [
                  buildListTile(
                    'Change Name',
                    trailing: Text(Name),
                    onTap: () => _showChangeNameDialog(context),
                  ),
                  buildListTile(
                    'Change Profile Picture',
                    leading: const Icon(Icons.person, color: Colors.black),
                    onTap: () => _showChangeProfilePictureDialog(context),
                  ),
                  buildListTile(
                    'User name',
                    leading: const Icon(Icons.key, color: Colors.black),
                    onTap: () => _showChangeUserNameDialog(context),
                  ),
                  buildListTile(
                    'Delete Account',
                    leading: const Icon(Icons.delete, color: Colors.red),
                    textColor: Colors.red,
                    onTap: () => _showDeleteAccountDialog(context),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              buildRoundedSection(
                'Notifications',
                [
                  buildSwitchTile(
                    'Deactivate Notifications',
                    value: isNotificationsEnabled,
                    onChanged: (bool value) {
                      setState(() {
                        isNotificationsEnabled = value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              buildRoundedSection(
                'Content Preferences',
                [
                  buildListTile('Language',
                      trailing: const Text('English'), onTap: () {}),
                ],
              ),
              const SizedBox(height: 16),
              buildRoundedSection(
                'Support',
                [
                  buildListTile(
                    'Contact Us',
                    leading: const Icon(Icons.email, color: Colors.black),
                    onTap: () async {
                      Uri uri = Uri.parse(
                          'mailto:mounir.boudjelal@ensia.edu.dz?subject=RateIt&body=Hi, RateIt Developer');
                      if (await launcher.canLaunchUrl(uri)) {
                        await launcher.launchUrl(uri);
                      } else {
                        debugPrint("Could not launch the uri");
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              buildRoundedSection(
                'Legal & Policy',
                [
                  buildListTile('Terms of Service', onTap: () {}),
                  buildListTile('Privacy Policy', onTap: () {}),
                ],
              ),
              const SizedBox(height: 16),
              buildRoundedSection(
                'Account Actions',
                [
                  buildListTile(
                    'Logout',
                    textColor: Colors.red,
                    leading: const Icon(Icons.exit_to_app, color: Colors.red),
                    onTap: () => _showLogoutConfirmationDialog(context),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

  Widget buildRoundedSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSectionHeader(title),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
        ),
      ),
    );
  }

  Widget buildListTile(
    String title, {
    Widget? leading,
    Widget? trailing,
    VoidCallback? onTap,
    Color textColor = Colors.black,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
      leading: leading,
      title: Text(
        title,
        style: TextStyle(color: textColor),
      ),
      trailing: trailing ?? const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  Widget buildSwitchTile(
    String title, {
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
      title: Text(title),
      value: value,
      onChanged: onChanged,
      activeColor: const Color.fromARGB(231, 231, 188, 47),
      inactiveThumbColor: Colors.grey,
    );
  }

  void _showChangeNameDialog(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Change User Name'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: 'Enter new user name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child:
                  const Text('Cancel', style: TextStyle(color: Colors.black)),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  Name = controller.text;
                });
                Navigator.of(context).pop();
              },
              child: const Text('Save', style: TextStyle(color: Colors.black)),
            ),
          ],
        );
      },
    );
  }

  void _showChangeUserNameDialog(BuildContext context) {
    final TextEditingController controller =
        TextEditingController(text: userName);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Change User Name'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: 'Enter new user name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child:
                  const Text('Cancel', style: TextStyle(color: Colors.black)),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  userName = controller.text;
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text(
                          'Username changed successfully')), // Success message
                );
              },
              child: const Text('Save', style: TextStyle(color: Colors.black)),
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery); // Or ImageSource.camera
    if (image != null) {
      setState(() {
        _image = File(image.path); // Update the profile image
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile picture updated successfully!')),
      );
    }
  }

  void _showDeleteAccountDialog(BuildContext context) {
    final TextEditingController passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Account'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Enter your password to confirm account deletion.'),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(hintText: 'Enter password'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child:
                  const Text('Cancel', style: TextStyle(color: Colors.black)),
            ),
            TextButton(
              onPressed: () {
                if (passwordController.text == correctPassword) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Account deleted successfully')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Incorrect password')),
                  );
                }
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void _showChangeProfilePictureDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          // Use StatefulBuilder to refresh the dialog when image is picked
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Change Profile Picture',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const SizedBox(height: 16),
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: _image == null
                          ? AssetImage('lib/assets/profilejpg.jpg')
                              as ImageProvider
                          : FileImage(_image!), // Update image in the dialog
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () async {
                        await _pickImage(); // Pick new image when the button is pressed
                        setState(
                            () {}); // Update the dialog UI to show the new image
                      },
                      child: const Text('Upload New Photo'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel'),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child:
                  const Text('Cancel', style: TextStyle(color: Colors.black)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Logged out successfully')),
                );
              },
              child: const Text('Logout', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
