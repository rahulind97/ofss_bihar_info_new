import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:ofss_bihar_info/utils/ApiInterceptor.dart';

import '../constants/constants.dart';
import '../utils/Utils.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController feedbackController = TextEditingController();

  bool isLoading = false;

   Dio dio = ApiInterceptor.createDio();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  /// 🔹 Load saved user data from SharedPreferences
  Future<void> _loadUserData() async {
    nameController.text = await Utils.getStringFromPrefs(constants.CAF_NUMBER) ?? '';
    mobileController.text = await Utils.getStringFromPrefs(constants.USER_NAME) ?? '';
    emailController.text = await Utils.getStringFromPrefs(constants.EMAIL) ?? '';
  }

  /// 🔹 Submit Feedback API
  Future<void> submitFeedback() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      await dio.post(
        '${constants.BASE_URL}${constants.FEEDBACK}',
        options: Options(
          headers: {'content-type': 'application/json'},
        ),
        data: {
          "user_name": nameController.text.trim(),
          "user_mobile": mobileController.text.trim(),
          "user_email": emailController.text.trim(),
          "description": feedbackController.text.trim(),
        },
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Feedback submitted successfully')),
        );
      }

      feedbackController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to submit feedback')),
      );
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          /// 🔹 Background Image (FULL SCREEN)
          Positioned.fill(
            child: Image.asset(
              'assets/bg.png',
              fit: BoxFit.cover, // ✅ correct for full screen
            ),
          ),

          /// 🔹 Dark Overlay
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.55),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              child: SizedBox(
                height: screenHeight, // ✅ forces full screen height
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),

                      /// 🔹 App Logo
                      Container(
                        height: 100,
                        width: 100,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Image.asset('assets/app_logo.png'),
                      ),

                      const SizedBox(height: 10),

                      const Text(
                        'Feedback',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 25),

                      /// 🔹 Glass Card Form
                      ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.3),
                              ),
                            ),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  _inputField(
                                    controller: nameController,
                                    label: 'CAF No',
                                    icon: Icons.person,
                                    readOnly: true,
                                  ),
                                  _inputField(
                                    controller: mobileController,
                                    label: 'Mobile Number',
                                    icon: Icons.phone,
                                    readOnly: true,
                                    keyboardType: TextInputType.phone,
                                  ),
                                  _inputField(
                                    controller: emailController,
                                    label: 'Email',
                                    icon: Icons.email,
                                    readOnly: true,
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                  _inputField(
                                    controller: feedbackController,
                                    label: 'Your Feedback',
                                    icon: Icons.feedback,
                                    maxLines: 3,
                                  ),

                                  const SizedBox(height: 14),

                                  SizedBox(
                                    width: double.infinity,
                                    height: 44,
                                    child: ElevatedButton(
                                      onPressed:
                                      isLoading ? null : submitFeedback,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        foregroundColor: Colors.black,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: isLoading
                                          ? const SizedBox(
                                        height: 18,
                                        width: 18,
                                        child:
                                        CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      )
                                          : const Text(
                                        'Submit Feedback',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      const Spacer(), // ✅ pushes content nicely on tall screens
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 Compact Input Field
  Widget _inputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool readOnly = false,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        readOnly: readOnly,
        maxLines: maxLines,
        keyboardType: keyboardType,
        validator: (v) => v!.isEmpty ? 'Required' : null,
        style: const TextStyle(color: Colors.white, fontSize: 13),
        decoration: InputDecoration(
          contentPadding:
          const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          labelText: label,
          labelStyle:
          const TextStyle(color: Colors.white70, fontSize: 12),
          prefixIcon: Icon(icon, color: Colors.white, size: 20),
          filled: true,
          fillColor: Colors.white.withOpacity(0.12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
