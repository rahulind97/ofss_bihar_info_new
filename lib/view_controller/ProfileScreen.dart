import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:ofss_bihar_info/constants/Colors.dart';
import 'package:ofss_bihar_info/constants/constants.dart';
import 'package:ofss_bihar_info/utils/ApiInterceptor.dart';

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
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    try {
      Dio dio = ApiInterceptor.createDio();
      final response = await dio.post(
        '${constants.BASE_URL}${constants.GET_PROFILE}',
        options: Options(headers: {'Content-Type': 'application/json'}),
        data: {
          "strCafNo": widget.cafNo,
          "type": "2"
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          profileData = response.data ?? {};
          loading = false;
        });
        print("Profile Data: $profileData");
      } else {
        setState(() => loading = false);
        _showError("Failed: ${response.statusCode}");
      }
    } catch (e) {
      setState(() => loading = false);
      _showError(e.toString());
    }
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
            _marksCard(profileData),
            const SizedBox(height: 14),
            _personalInfoCard(profileData),
            const SizedBox(height: 14),
            _paymentStatusCard(profileData),
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
              widget.imagePath ?? "https://i.pravatar.cc/150?img=47",
            ),
          ),
          const SizedBox(height: 10),
          Text(
            data['personalInformation']['name'] ?? "",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            data['personalInformation']['mob'] ?? "",
            style: const TextStyle(color: Colors.white70, fontSize: 13),
          ),
          const SizedBox(height: 2),
          Text(
            data['personalInformation']['email'] ?? "",
            style: const TextStyle(color: Colors.white70, fontSize: 13),
          ),
        ],
      ),
    );
  }

  // ================= MARKS =================
  Widget _marksCard(Map<String, dynamic> data) {
    return _card(
      title: "Marks",
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _markItem("Full Marks", data['markDetail']['fullMark']?.toString() ?? ""),
          _markItem("Obtained Marks", data['markDetail']['obtainedMark']?.toString() ?? ""),
        ],
      ),
    );
  }

  Widget _markItem(String label, String value) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 13)),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(
            color: red,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  // ================= PERSONAL INFO =================
  Widget _personalInfoCard(Map<String, dynamic> data) {
    return _card(
      title: "Personal Information",
      child: Column(
        children: [
          // _row(
            _infoBox(Icons.person, "Father Name", data['personalInformation']['fatherName'] ?? ""),
          const SizedBox(height: 14),
          _infoBox(Icons.person, "Mother Name", data['personalInformation']['motherName'] ?? ""),
          const SizedBox(height: 14),

          // ),
          _row(
            _infoBox(Icons.numbers, "CAF No",widget.cafNo.toString() ?? ""),
            _infoBox(Icons.calendar_today, "Date of Birth", data['personalInformation']['dob'].toString() ?? ""),
          ),
          _row(
            _infoBox(Icons.people, "Gender", data['personalInformation']['gender'].toString() ?? ""),
            _infoBox(Icons.group, "Cast", data['personalInformation']['cast_name'].toString() ?? ""),
          ),
          _row(
            _infoBox(Icons.school, "Board", data['personalInformation']['board'].toString() ?? ""),
            _infoBox(Icons.confirmation_number, "Roll No", data['personalInformation']['rollno'].toString() ?? ""),
          ),
          _row(
            _infoBox(Icons.history, "Year of Passing", data['personalInformation']['yop'].toString() ?? ""),
            _infoBox(Icons.calendar_month, "Applied Date", data['personalInformation']['strAppliedDate'].toString() ?? ""),
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
