import 'dart:async';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:ofss_bihar_info/constants/Colors.dart';
import 'package:ofss_bihar_info/constants/constants.dart';
import 'package:ofss_bihar_info/utils/ApiInterceptor.dart';
import 'package:ofss_bihar_info/utils/Utils.dart';
import 'package:intl/intl.dart';
class ProfileScreen extends StatefulWidget {
  final String cafNo;

  final String imagePath; // CAF No from login

  const ProfileScreen({super.key, required this.cafNo, required this.imagePath});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static const Color red = textColor;

  Map<String, dynamic> profileData = {};
  bool loading = false;

  String  IMAGE_PATH= '';
  String  APPLICATION_ID= '';
  String  MOBILE_NO= '';
  String  EMAIL_ID= '';
  String  BOARD_NAME= '';
  String  YEAR_OF_PASSING= '';
  String  EXAM_TYPE= '';
  String  ROLL_NO= '';
  String  DOB= '';
  String  ROLL_CODE= '';
  String  NAME= '';
  String  FATHER_NAME= '';
  String  MOTHER_NAME= '';
  String  GENDER= '';
  String  MT_NAME= '';
  String  NATIONALITY= '';
  String  BG_NAME= '';
  String  ADHAAAR_NO= '';



  @override
  void initState() {
    super.initState();
    loadData();
  }

   void loadData() async {

     IMAGE_PATH = (await Utils.getStringFromPrefs(constants.IMAGE_PATH))!;
     MOBILE_NO = (await Utils.getStringFromPrefs(constants.MOBILE_NO))!;
     EMAIL_ID = (await Utils.getStringFromPrefs(constants.EMAIL_ID))!;
     BOARD_NAME = (await Utils.getStringFromPrefs(constants.BOARD_NAME))!;
     YEAR_OF_PASSING = (await Utils.getStringFromPrefs(constants.YEAR_OF_PASSING))!;
     ROLL_NO = (await Utils.getStringFromPrefs(constants.ROLL_NO))!;
     DOB = (await Utils.getStringFromPrefs(constants.DOB))!;
     ROLL_CODE = (await Utils.getStringFromPrefs(constants.ROLL_CODE))!;
     NAME = (await Utils.getStringFromPrefs(constants.NAME))!;
     FATHER_NAME = (await Utils.getStringFromPrefs(constants.FATHER_NAME))!;
     MOTHER_NAME = (await Utils.getStringFromPrefs(constants.MOTHER_NAME))!;
     GENDER = (await Utils.getStringFromPrefs(constants.GENDER))!;
     NATIONALITY = (await Utils.getStringFromPrefs(constants.NATIONALITY))!;
     ADHAAAR_NO = (await Utils.getStringFromPrefs(constants.ADHAAAR_NO))!;
     setState(() {

     });
   }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Column(
          children: [
            _header(profileData),
            const SizedBox(height: 14),
          //  _marksCard(profileData),
            const SizedBox(height: 14),
            _personalInfoCard(profileData),
            const SizedBox(height: 14),
            //_paymentStatusCard(profileData),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // ================= HEADER =================
  Widget _header(Map<String, dynamic> data) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 45, bottom: 25),
      decoration: const BoxDecoration(
        color: btnColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 14),
          CircleAvatar(
            radius: 38,
            backgroundImage: NetworkImage(
              IMAGE_PATH ?? "https://i.pravatar.cc/150?img=47",
            ),
          ),
          const SizedBox(height: 10),
          Text(
            NAME ?? "",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            MOBILE_NO ?? "",
            style: const TextStyle(color: Colors.white70, fontSize: 13),
          ),
          const SizedBox(height: 2),
          Text(
            EMAIL_ID ?? "",
            style: const TextStyle(color: Colors.white70, fontSize: 13),
          ),
        ],
      ),
    );
  }

  // ================= MARKS =================
  // Widget _marksCard(Map<String, dynamic> data) {
  //   return _card(
  //     title: "Marks",
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceAround,
  //       children: [
  //         _markItem("Full Marks", data['markDetail']['fullMark']?.toString() ?? ""),
  //         _markItem("Obtained Marks", data['markDetail']['obtainedMark']?.toString() ?? ""),
  //       ],
  //     ),
  //   );
  // }

  // Widget _markItem(String label, String value) {
  //   return Column(
  //     children: [
  //       Text(label, style: const TextStyle(fontSize: 13)),
  //       const SizedBox(height: 6),
  //       Text(
  //         value,
  //         style: const TextStyle(
  //           color: red,
  //           fontSize: 22,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // ================= PERSONAL INFO =================
  Widget _personalInfoCard(Map<String, dynamic> data) {
    return _card(
      title: "Personal Information",
      child: Column(
        children: [
          // _row(
            _infoBox(Icons.person, "Father Name", FATHER_NAME ?? ""),
          const SizedBox(height: 14),
          _infoBox(Icons.person, "Mother Name", MOTHER_NAME ?? ""),
          const SizedBox(height: 14),

          // ),
          _row(
            _infoBox(Icons.numbers, "CAF No",widget.cafNo.toString() ?? ""),
            _infoBox(Icons.calendar_today, "Date of Birth",    DateFormat('dd/MM/yyyy').format(DateTime.parse(DOB)).toString() ?? ""),
          ),
          _rowSingle(
            _infoBox(Icons.people, "Gender", GENDER.toString() ?? ""),
        //    _infoBox(Icons.group, "Cast", data['personalInformation']['cast_name'].toString() ?? ""),
          ),
          _row(
            _infoBox(Icons.school, "Board", BOARD_NAME.toString() ?? ""),
            _infoBox(Icons.confirmation_number, "Roll No", ROLL_NO.toString() ?? ""),
          ),
          _rowSingle(
            _infoBox(Icons.history, "Year of Passing", YEAR_OF_PASSING.toString() ?? ""),
          //  _infoBox(Icons.calendar_month, "Applied Date", data['personalInformation']['strAppliedDate'].toString() ?? ""),
          ),
        ],
      ),
    );
  }

  // ================= PAYMENT STATUS =================
  Widget _paymentStatusCard(Map<String, dynamic> data) {
    return _card(
      title: "Payment Status",
      child: Column(
        children: [
          _row(
            _infoBox(Icons.calendar_today, "Transaction Date", data['paymentInformation']['transactionDate'] ?? ""),
            _infoBox(Icons.check_circle, "Payment Status", data['paymentInformation']['paymentStatus'] ?? "", success: true),
          ),
             _infoBox(Icons.receipt_long, "Transaction Number", data['paymentInformation']['transactionNumber'] ?? ""),
          const SizedBox(height: 14),
          _row(
            _infoBox(Icons.account_balance, "Payment Gateway Name", data['paymentInformation']['paymentGateWayName'] ?? ""),

            _infoBox(Icons.currency_rupee, "Application Fee", data['paymentInformation']['applicationFee'] ?? ""),

          ),
        ],
      ),
    );
  }

  // ================= COMMON CARD =================
  Widget _card({required String title, required Widget child}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: red,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Container(height: 2, width: 36, color: red),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }

  Widget _row(Widget left, Widget right) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(child: left),
          const SizedBox(width: 12),
          Expanded(child: right),
        ],
      ),
    );
  }

  Widget _rowSingle(Widget left) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(child: left),
        //  const SizedBox(width: 12),

        ],
      ),
    );
  }


  Widget _infoBox(IconData icon, String label, String value, {bool success = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.black54),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.circular(6),
            color: Colors.white,
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 14,
                backgroundColor: red,
                child: Icon(icon, color: Colors.white, size: 14),
              ),
              const SizedBox(width: 8),
              if (success)
                const Icon(Icons.check_circle, size: 16, color: Colors.green),
              if (success) const SizedBox(width: 4),
              Expanded(
                child: Text(
                  value,
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
