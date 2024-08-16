import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final bool isLoading; // New property to control loading state

  const CommonButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.isLoading = false, // Default value is false
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0F5749), // Background color
          foregroundColor: Colors.white, // Text color
          padding: const EdgeInsets.symmetric(horizontal: 20), // Adjust padding
          fixedSize: const Size.fromHeight(65), // Set the height
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Customize the border radius
          ),
        ),
        onPressed: isLoading ? null : onPressed, // Disable button when loading
        child: isLoading
            ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
            : Text(title),
      ),
    );
  }
}
