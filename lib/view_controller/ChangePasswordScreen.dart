import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/Colors.dart';

class ChangePasswordScreen extends StatefulWidget {
  final String mobileNumber;

  const ChangePasswordScreen({super.key, required this.mobileNumber});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Password"),
        backgroundColor: appBarColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: newPassword,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "New Password",
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: confirmPassword,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Confirm Password",
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // CALL CHANGE PASSWORD API
              },
              child: const Text("Update Password"),
            )
          ],
        ),
      ),
    );
  }
}
