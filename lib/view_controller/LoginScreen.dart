import 'package:dio/dio.dart' show Dio, Options, ResponseType;
import 'package:flutter/material.dart';
import 'package:ofss_bihar_info/utils/ApiInterceptor.dart';
import 'package:ofss_bihar_info/utils/Utils.dart';

import '../model/loginModel.dart';
import '../services/services.dart';
import '../services/services.dart' as _service;
import 'DashBoardScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1E3E4),
      resizeToAvoidBottomInset: true,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 30),
          child: Column(
            children: [
              const SizedBox(height: 20),

              // Logo
              Container(
                height: 130,
                width: 130,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage("assets/app_logo.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                "ONLINE FACILITATION SYSTEM\nFOR STUDENTS",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF8B0000),
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),

              const Text(
                "Bihar School Examination Board",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 15),

              // ⭐ SMALLER CARD ⭐
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 18),
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Text(
                        "INTERMEDIATE",
                        style: TextStyle(
                          color: Color(0xFF8B0000),
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      const SizedBox(height: 4),

                      const Divider(
                        color: Colors.grey,
                        thickness: 1,
                        indent: 40,
                        endIndent: 40,
                      ),

                      const SizedBox(height: 10),

                      const Text(
                        "INTERMEDIATE STUDENT’S LOGIN",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      const SizedBox(height: 15),

                      // Hindi note
                      const Text(
                        "अपना मोबाइल नंबर नीचे भरें जिसके माध्यम से आपने APPLICATION FORM भरा है",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 11.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Mobile
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFF8B0000), width: 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          controller: mobileController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            hintText: "Enter Mobile Number",
                            hintStyle: TextStyle(color: Colors.grey[600]),
                            border: InputBorder.none,
                            suffixIcon: Icon(Icons.phone, color: Colors.grey[700]),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter mobile number";
                            }
                            if (value.length != 10) {
                              return "Enter valid 10-digit number";
                            }
                            return null;
                          },
                        ),
                      ),

                      const SizedBox(height: 14),

                      // Password Hindi label
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "पासवर्ड यहाँ नीचे भरें",
                          style: TextStyle(
                            color: Color(0xFF8B0000),
                            fontSize: 13.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      const SizedBox(height: 6),

                      // Password field
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFF8B0000), width: 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: !showPassword,
                          decoration: InputDecoration(
                            hintText: "Password",
                            hintStyle: TextStyle(color: Colors.grey[600]),
                            border: InputBorder.none,
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() => showPassword = !showPassword);
                              },
                              child: Icon(
                                showPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter password";
                            }
                            return null;
                          },
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Submit Button
                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF8B0000),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              loginApi();
                            }
                          },
                          child: const Text(
                            "Submit",
                            style: TextStyle(fontSize: 15.5, color: Colors.white),
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),

                      const Text(
                        "Forgot Password ?",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 13.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const SizedBox(height: 5),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // API Method
  Future<void> loginApi() async {
    print("Mobile: ${mobileController.text}");
    print("Password: ${passwordController.text}");

    Utils.progressbar(context);
    Dio dio = ApiInterceptor.createDio();
    final url = URL + 'login';

    Map<String, dynamic> data = {
      "mobileNumber": mobileController.text.trim(),
      "password": passwordController.text.trim(),
      "type": "2"
    };

    try {
      final response = await dio.post(
        url,
        data: data,
        options: Options(
          headers: {"Content-Type": "application/json"},
          responseType: ResponseType.json,
        ),
      );

      print("RAW RESPONSE: ${response.data}");

      if (response.data is List && response.data.isNotEmpty) {
        final item = response.data[0];

        if (item["status"] == '200' && item["msg"] == "Success") {
          final user = item["lstUser"][0];

          Navigator.pop(context); // CLOSE LOADER FIRST

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Login Successful")),
          );

          // NAVIGATE TO DASHBOARD
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DashboardScreen(userData: user),
            ),
          );

          return;
        }
      }

      Navigator.pop(context); // CLOSE LOADER

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invalid login. Please try again.")),
      );

    } catch (e) {
      print("ERROR: $e");

      Navigator.pop(context); // CLOSE LOADER ON ERROR

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Something went wrong!")),
      );
    }
  }
}
