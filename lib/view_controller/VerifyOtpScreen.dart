import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ofss_bihar_info/constants/Colors.dart';
import 'package:ofss_bihar_info/utils/Utils.dart';
import 'package:ofss_bihar_info/view_controller/ChangePasswordScreen.dart';

import '../constants/constants.dart';
import '../utils/ApiInterceptor.dart';

class OtpScreen extends StatefulWidget {
  final String mobileNumber;
  const OtpScreen({super.key, required this.mobileNumber});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> _controllers =
  List.generate(6, (_) => TextEditingController());

  final List<FocusNode> _focusNodes =
  List.generate(6, (_) => FocusNode());

  @override
  void dispose() {
    for (var c in _controllers) {
      c.dispose();
    }
    for (var f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _onOtpChanged(String value, int index) {
    if (value.length == 1 && index < 5) {
      _focusNodes[index + 1].requestFocus();
    }
    if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }
  Future<void> verifyChangePasswordOtp(BuildContext context) async {
    String otp = _controllers.map((e) => e.text).join();
    print("object"+otp);
    if (otp.isEmpty || otp.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter valid 6-digit OTP")),
      );
      return;
    }

    try {
      Utils.progressbar(context);
      Dio dio = ApiInterceptor.createDio();

      final response = await dio.post(
        constants.BASE_URL + constants.VERIFY_OTP,
        options: Options(headers: {
          "Content-Type": "application/json",
        }),
        data: {
          "strOtp": otp,
          "strOtpType": "vp",
          "strCAfNo": widget.mobileNumber, // mobile / CAF
          "type": "2",
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data;
        Navigator.pop(context); // CLOSE LOADER
        if (data[0]["status"] == "200") {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("OTP Verified")),
          );

          // ✅ NAVIGATE TO CHANGE PASSWORD
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => ChangePasswordScreen(
                mobileNumber: widget.mobileNumber,
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(data[0]["msg"] ?? "Invalid OTP"),
            ),
          );
        }
      } else {
        Navigator.pop(context); // CLOSE LOADER
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Server error")),
        );
      }
    } on DioException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? "Network error")),
      );
    } catch (e) {
      Navigator.pop(context); // CLOSE LOADER
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Something went wrong")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1E3E4),
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
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

              /// Logo
              Container(
                height: 130,
                width: 130,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                  image: const DecorationImage(
                    image: AssetImage("assets/app_logo.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// Title
              const Text(
                "ONLINE FACILITATION SYSTEM\nFOR STUDENTS",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: appBarColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 8),
              const Text(
                "Bihar School Examination Board",
                style: TextStyle(
                  color: appBarColor,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 20),

              /// OTP Card
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  children: [
                    const Text(
                      "Sit back & relax! while we verify your\nmobile number",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: appBarColor,
                      ),
                    ),

                    const SizedBox(height: 25),

                    /// OTP Boxes
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(6, (index) {
                        return _otpBox(index);
                      }),
                    ),

                    const SizedBox(height: 30),

                    /// Verify Button
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF8B0000),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          elevation: 0,
                        ),
                        onPressed: () {
                          String otp = _controllers
                              .map((e) => e.text)
                              .join();
                          debugPrint("OTP: $otp");
                          verifyChangePasswordOtp(context);
                        },
                        child: const Text(
                          "Verify OTP",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// Resend OTP
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        "Resend OTP ?",
                        style: TextStyle(
                          fontSize: 14,
                          color: appBarColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Single OTP Box
  Widget _otpBox(int index) {
    return SizedBox(
      width: 40,
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        onChanged: (value) => _onOtpChanged(value, index),
        decoration: InputDecoration(
          counterText: "",
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade400,
              width: 1.5,
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFFB11226),
              width: 2,
            ),
          ),
        ),
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
