import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:ofss_bihar_info/utils/ApiInterceptor.dart';

import '../model/AdmissiondetailModel.dart';
import '../model/applyForSlideUpModel.dart';
import '../model/changePasswordModel.dart';
import '../model/collegeInfoModel.dart';
import '../model/feedbackModel.dart';
import '../model/forgotModel.dart';
import '../model/getOtpModel.dart';
import '../model/loginModel.dart';
import '../model/otpModel.dart';
import '../model/resendOtpModel.dart';
import '../model/slideUpStatusModel.dart';
import '../model/user_info_model.dart';


String URL = 'http://mobileapp.ofssbihar.net/OFSS_Service/OFSS_MobilityService.svc/'; // new live Url 2025

/*
    ****** This  function is used for Login Data  ******
*/

Dio _dio =ApiInterceptor.createDio();
Future<Response> login(Login login) async {
  try {
    final response = await _dio.post(
      URL+"login",      // endpoint only (BaseURL in dio_client)
      data: login.toJson(),
    );

    return response;
  } catch (e) {
    throw Exception("Login API failed: $e");
  }
}

/*
    ****** This  function is used for MyInfo Data  ******
*/

Future<http.Response> getuserInfo(Userinfo post) async {
  final response = await http.post(Uri.parse(URL + 'getProfileData'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: userinfotoJson(post));
  print(URL + 'getProfileData');
  return response;
}

/*
    ****** This  function is used for Feedback Result  ******
*/

Future<http.Response> feedbackServ(feedbackModel post) async {
  print(feedbackModelToJson(post));

  final response = await http.post(Uri.parse(URL + 'feedback'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: feedbackModelToJson(post));
  print(URL + 'feedback');
  return response;
}

/*
    ****** This  function is used for College information  ******
*/

Future<http.Response> collegeInfoServ(CollegeInfoModel post) async {
//  print(ToJson(post));

  final response = await http.post(Uri.parse(URL + 'Get_College_Info'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: CollegeInfoModelToJson(post));
  print(URL + 'Get_College_Info');
  return response;
}

/*
    ****** This  function is used for Otp Result  ******
*/

Future<http.Response> OtpServ(OtpPageModel post) async {
//  print(ToJson(post));

  final response = await http.post(Uri.parse(URL + 'VerifyChangePasswordOTP'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: OtpPageModelToJson(post));
  print(URL + 'VerifyChangePasswordOTP');
  return response;
}

/*
    ****** This  function is used for Block Data  ******
*/
Future<http.Response> getBlockData() async {
  final response = await http.get(
    Uri.parse(URL + ''),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    },
  );
  return response;
}

/*
    ****** This  function is used for SeatStrength Data  ******
*/

Future<http.Response> seatStrengthData(type, collegeid, year) async {
  final response = await http.get(
    Uri.parse(URL +
        "get_College_SubjectDetails" +
        "/" +
        type +
        "/" +
        collegeid +
        "/" +
        year),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
  );
  print(URL +
      "get_College_SubjectDetails" +
      "/" +
      type +
      "/" +
      collegeid +
      "/" +
      year);
  return response;
}

/*
    ****** This  function is used for District Data  ******
*/

Future<http.Response> getDistData() async {
  final response = await http.get(
    Uri.parse(URL + 'get_dist'),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    },
  );
  print(URL + 'get_dist');
  return response;
}
/*
    ****** This  function is used for ForgotPassword Data  ******
*/

Future<http.Response> forgotPasswordServ(ForgotPwd post) async {
  final response = await http.post(Uri.parse(URL + 'forgotPassword'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: forgotToJson(post));
  print(URL + 'forgotPassword');
  return response;
}

/*
    ****** This  function is used for AppVersion Data  ******
*/

Future<http.Response> appVersionServ() async {
  final response = await http.post(
    Uri.parse(URL + 'GetVersion'),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    },
  );
  print(URL + 'GetVersion');
  return response;
}




/*
    ****** This  function is used for admission Data  ******
*/

Future<http.Response> getAdmissionData(Admissiondetail post) async {
  print(admissiondetailtoJson(post));
  final response = await http.post(Uri.parse(URL + "get_Adm_SlideUp_Status"),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: admissiondetailtoJson(post));
  print(URL + "get_Adm_SlideUp_Status");
  return response;
}

Future<http.Response> getChangePassword(
    ChangePasswordResponseModel chngPswd) async {
  final response = await http.post(Uri.parse(URL + "changePassword"),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: chngPswdtoJson(chngPswd));
  print(URL + "changePassword");
  return response;
}

Future<http.Response> getSlideUpStatus(SlideUpModel slideUp) async {
  final response = await http.post(Uri.parse(URL + "get_Adm_SlideUp_Status"),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: slideUptoJson(slideUp));
  print(URL + "get_Adm_SlideUp_Status");
  return response;
}

Future<http.Response> getOtp(GetOtpPageModel getOtpObj) async {
  final response = await http.post(Uri.parse(URL + "get_OTP"),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: GetOtpModelToJson(getOtpObj));
  print(URL + "get_OTP");
  return response;
}

Future<http.Response> applyForSlideup(
    ApplyForSlideUpReqModel applySlideUp) async {
  final response = await http.post(Uri.parse(URL + "applyForSlideup"),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: applyForSlideUptoJson(applySlideUp));

  print(URL + "applyForSlideup");
  return response;
}

Future<http.Response> getResendOtp(ResendOtpPageModel resendOtpObj) async {
  final response = await http.post(Uri.parse(URL + "Resend_OTP"),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: ResendOtpPageModelToJson(resendOtpObj));
  print(URL + "Resend_OTP");
  return response;
}








