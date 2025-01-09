import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rate_it/styles/style.dart'; // Import your style file
import 'package:rate_it/widgets/appBar.dart'; // Import your custom AppBar
import 'package:image_picker/image_picker.dart'; // Import for image picking

class CreateRoomScreen extends StatefulWidget {
  const CreateRoomScreen({super.key});

  @override
  _CreateRoomScreenState createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  XFile? selectedFile; // Holds the selected image or video

  Future<void> pickFile() async {
    final ImagePicker picker = ImagePicker();
    final XFile? file = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      selectedFile = file;
    });
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
        backgroundColor: Colors.transparent, // Set to transparent to show gradient
        resizeToAvoidBottomInset: true, // Prevents bottom overflow
        appBar: const CommonAppBar(),
        body: SingleChildScrollView(
          padding: AppSpacing.paddingAll,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Create your room",
                style: AppTextStyles.heading1,
              ),
              const SizedBox(height: AppSpacing.lg),

              // Room Name Field
              Text(
                "What would you call your room?",
                style: AppTextStyles.heading2,
              ),
              const SizedBox(height: AppSpacing.sm),
              TextField(
                decoration: InputDecoration(
                  hintText: "Room name",
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // Upload Section
              Text(
                "Select a picture representing your room",
                style: AppTextStyles.heading2,
              ),
              const SizedBox(height: AppSpacing.sm),
              GestureDetector(
                onTap: pickFile,
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                    image: selectedFile != null
                        ? DecorationImage(
                            image: FileImage(File(selectedFile!.path)),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: selectedFile == null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.upload_file, size: 40, color: Colors.grey),
                            const SizedBox(height: AppSpacing.sm),
                            Text(
                              "Upload an image or a video",
                              style: AppTextStyles.caption,
                            ),
                            Text(
                              "Click on the upload icon or drag the picture/video here.",
                              style: AppTextStyles.caption,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )
                      : null,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // Category Selection
              Text(
                "Select corresponding category",
                style: AppTextStyles.heading2,
              ),
              const SizedBox(height: AppSpacing.sm),
              Wrap(
                spacing: AppSpacing.sm,
                children: [
                  _buildCategoryChip("Fashion"),
                  _buildCategoryChip("Food"),
                  _buildCategoryChip("Sports"),
                  _buildCategoryChip("Tech"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String label) {
    return Chip(
      label: Text(
        label,
        style: AppTextStyles.body,
      ),
      backgroundColor: AppTheme.primaryColor,
      labelStyle: AppTextStyles.body.copyWith(color: Colors.white),
    );
  }
}
