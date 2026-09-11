import 'package:dio/dio.dart' show Dio, Options, ResponseType;
import 'package:flutter/material.dart';
import 'package:ofss_bihar_info/utils/ApiInterceptor.dart';
import 'package:ofss_bihar_info/utils/Utils.dart';
import 'package:ofss_bihar_info/view_controller/ForgetPasswordScreen.dart';

import '../constants/constants.dart';
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
  // API Method
  Future<void> loginApi() async {
    print("LoginId: ${mobileController.text}");
    print("Password: ${passwordController.text}");

    Utils.progressbar(context);
    Dio dio = ApiInterceptor.createDio();
    final url = URL + 'auth/login';

    Map<String, dynamic> data = {
      "LoginId": mobileController.text.trim(),
      "Password": passwordController.text.trim(),

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
      print("RAW RESPONSE: 2 ${response.statusCode}");

      if (response.data.isNotEmpty) {
        //final item = response.data[0];
        print("trace1");



        if (response.data["success"] == true && response.statusCode == 200) {
          print("trace2");
           Utils.saveStringToPrefs(constants.TOKEN, response.data['token'].toString());
           Utils.saveStringToPrefs(constants.REFRANCENO, response.data['applicantDetails'][constants.REFRANCENO].toString());
           Utils.saveStringToPrefs(constants.IMAGE_PATH, response.data['applicantDetails'][constants.IMAGE_PATH].toString());
           Utils.saveStringToPrefs(constants.APPLICATION_ID, response.data['applicantDetails'][constants.APPLICATION_ID].toString());
           Utils.saveStringToPrefs(constants.MOBILE_NO, response.data['applicantDetails'][constants.MOBILE_NO].toString());
           Utils.saveStringToPrefs(constants.EMAIL_ID, response.data['applicantDetails'][constants.EMAIL_ID].toString());
           Utils.saveStringToPrefs(constants.BOARD_NAME, response.data['applicantDetails'][constants.BOARD_NAME].toString());
           Utils.saveStringToPrefs(constants.YEAR_OF_PASSING, response.data['applicantDetails'][constants.YEAR_OF_PASSING].toString());
           Utils.saveStringToPrefs(constants.EXAM_TYPE, response.data['applicantDetails'][constants.EXAM_TYPE].toString());
           Utils.saveStringToPrefs(constants.DOB, response.data['applicantDetails'][constants.DOB].toString());
           Utils.saveStringToPrefs(constants.ROLL_NO, response.data['applicantDetails'][constants.ROLL_NO].toString());
           Utils.saveStringToPrefs(constants.ROLL_CODE, response.data['applicantDetails'][constants.ROLL_CODE].toString());
           Utils.saveStringToPrefs(constants.NAME, response.data['applicantDetails'][constants.NAME].toString());
           Utils.saveStringToPrefs(constants.FATHER_NAME, response.data['applicantDetails'][constants.FATHER_NAME].toString());
           Utils.saveStringToPrefs(constants.MOTHER_NAME, response.data['applicantDetails'][constants.MOTHER_NAME].toString());
           Utils.saveStringToPrefs(constants.GENDER, response.data['applicantDetails'][constants.GENDER].toString());
           Utils.saveStringToPrefs(constants.MT_NAME, response.data['applicantDetails'][constants.MT_NAME].toString());
           Utils.saveStringToPrefs(constants.NATIONALITY, response.data['applicantDetails'][constants.NATIONALITY].toString());
           Utils.saveStringToPrefs(constants.BG_NAME, response.data['applicantDetails'][constants.BG_NAME].toString());
           Utils.saveStringToPrefs(constants.ADHAAAR_NO, response.data['applicantDetails'][constants.ADHAAAR_NO].toString());



          // Utils.saveBoolToPrefs('isLogin', true);
          Navigator.pop(context); // CLOSE LOADER FIRST

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Login Successful")),
          );
          //
          // NAVIGATE TO DASHBOARD
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DashboardScreen(),
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

                      // GestureDetector(
                      //   onTap: () {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (_) => Forgetpasswordscreen(),
                      //       ),
                      //     );
                      //   },
                      //   child: const Text(
                      //     "Forgot Password ?",
                      //     style: TextStyle(
                      //       color: Colors.black87,
                      //       fontSize: 13.5,
                      //       fontWeight: FontWeight.w500,
                      //     ),
                      //   ),
                      // ),

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
