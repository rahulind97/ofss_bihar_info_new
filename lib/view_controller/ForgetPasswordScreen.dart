import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ofss_bihar_info/constants/Colors.dart';
import 'package:ofss_bihar_info/constants/constants.dart';
import 'package:ofss_bihar_info/utils/ApiInterceptor.dart';
import 'package:ofss_bihar_info/view_controller/VerifyOtpScreen.dart';

import '../utils/Utils.dart';


class Forgetpasswordscreen extends StatefulWidget {
  const Forgetpasswordscreen({super.key});

  @override
  State<Forgetpasswordscreen> createState() => _ForgetpasswordscreenState();
}

class _ForgetpasswordscreenState extends State<Forgetpasswordscreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController mobileController = TextEditingController();

  bool showPassword = false;
  Future<void> forgotPasswordApi(BuildContext context) async {
    try {
      Utils.progressbar(context);
      Dio dio = ApiInterceptor.createDio();

      final response = await dio.post(
        constants.BASE_URL+constants.FORGOT_PASSWORD,
        options: Options(headers: {
          "Content-Type": "application/json",
        }),
        data: {
          "strCafNo": mobileController.text.trim(),
          "strType": "2",
        },
      );
      if (response.statusCode == 200 && response.data != null) {
        final data = response.data;
        Navigator.pop(context); // CLOSE LOADER FIRST
        if (data[0]["status"] == "200") {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(data[0]["msg"] ?? "OTP sent successfully")),
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => OtpScreen(mobileNumber: mobileController.text.trim(),),
            ),
          );


        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(data[0]["msg"] ?? "Something went wrong")),
          );
        }
      } else {
        Navigator.pop(context); // CLOSE LOADER
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Server error")),
        );
      }
    } on DioException catch (e) {
      Navigator.pop(context); // CLOSE LOADER


      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? "Network error")),
      );
    } catch (e) {
      Navigator.pop(context); // CLOSE LOADER

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Unexpected error")),
      );
    }
  }

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
              Padding(
                padding: const EdgeInsets.only(left: 6),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(
                        Icons.arrow_back,
                        color: btnColor,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ),

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
                        "Forgot Password",
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
                              forgotPasswordApi(context);
                            }
                          },
                          child: const Text(
                            "Submit",
                            style: TextStyle(fontSize: 15.5, color: Colors.white),
                          ),
                        ),
                      ),

                      const SizedBox(height: 15),

                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context); // Back to Login
                        },
                        child: const Text(
                          "Back To Login",
                          style: TextStyle(
                            color: appBarColor,
                            fontSize: 13.5,
                            fontWeight: FontWeight.w500,
                          ),
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

}
