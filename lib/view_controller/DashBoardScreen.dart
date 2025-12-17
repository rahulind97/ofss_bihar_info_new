import 'package:flutter/material.dart';
import 'package:ofss_bihar_info/view_controller/AppVersionScreen.dart';
import 'package:ofss_bihar_info/view_controller/FeedbackScreen.dart';
import '../constants/Colors.dart';
import '../constants/constants.dart';
import '../utils/Utils.dart';
import 'CollegeInformation.dart';
import 'ProfileScreen.dart';

class DashboardScreen extends StatefulWidget {
  final Map userData;

  const DashboardScreen({Key? key, required this.userData}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String applicantId = '';
  String name = '';
  String email = '';
  String username = '';
  String cafNumber = '';
  String? imagePath;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    applicantId =
        await Utils.getStringFromPrefs(constants.APPLICATION_ID) ??
            // widget.userData['applicantId']?.toString() ??
            '';

    name =
        await Utils.getStringFromPrefs(constants.NAME) ??
            // widget.userData['Name']?.toString() ??
            '';

    email =
        await Utils.getStringFromPrefs(constants.EMAIL) ??
            // widget.userData['strEmail']?.toString() ??
            '';

    username =
        await Utils.getStringFromPrefs(constants.USER_NAME) ??
            // widget.userData['username']?.toString() ??
            '';

    imagePath = await Utils.getStringFromPrefs(constants.IMAGE_PATH);

    cafNumber =
        await Utils.getStringFromPrefs(constants.CAF_NUMBER) ??
            // widget.userData['cafNumber']?.toString() ??
            '';

    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    if (isLoading) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      );
    }

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,

      drawer: _buildDrawer(context),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white, size: 32),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
      ),

      body: _buildBody(context),
    );
  }

  // ================= DRAWER =================
  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // DrawerHeader(
          //   decoration: BoxDecoration(color: btnColor),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //
          //       const SizedBox(height: 10),
          //       Text(
          //         name,
          //         style: const TextStyle(color: Colors.white, fontSize: 16),
          //       ),
          //     ],
          //   ),
          // ),
          DrawerHeader(
            decoration: BoxDecoration(color: btnColor),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// Center Image (Logo / Profile)
                Container(
                  height: 90, // outer size (image + border)
                  width: 90,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 2, // border thickness
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(0), // space between border & image
                    child: ClipOval(
                      child: Image.network(
                        imagePath!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/app_logo.png',
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  ),
                ),


                const SizedBox(height: 10),

                /// Name Text
                Text(
                  name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          _drawerItem(
            Icons.info,
            'College Information',
                () => _openCollegeInfo(context),
          ),

          _drawerItem(Icons.person, 'My Info', () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProfileScreen(cafNo: cafNumber,imagePath: imagePath.toString(),),
              ),
            );

          }),

          _drawerItem(Icons.details, 'Admission Details', () {}),

          _drawerItem(Icons.settings, 'Slide Up Selection', () {}),

          _drawerItem(Icons.feedback, 'Feedback', () {

            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => FeedbackScreen()),
            );

          }),

          _drawerItem(Icons.info, 'App Version', () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AppVersionScreen()),
            );
          }),

          const Divider(),

          _drawerItem(Icons.logout, 'Logout', () async {
            await Utils.clearPrefs();
            Navigator.pop(context);
            // Navigate to LoginScreen here
          }),
        ],
      ),
    );
  }

  Widget _drawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
    );
  }

  // ================= BODY =================
  Widget _buildBody(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/bg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        color: Colors.black.withOpacity(0.5),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 0)
                    .copyWith(top: kToolbarHeight + 20),
                child: Column(
                  children: [
                    Center(
                      child: Image.asset(
                        "assets/app_logo.png",
                        height: 150,
                        width: 150,
                      ),
                    ),
                    const SizedBox(height: 25),
                    const Text(
                      "ONLINE FACILITATION SYSTEM\nFOR STUDENTS",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "Bihar School Examination Board, Govt. of Bihar",
                      textAlign: TextAlign.center,
                      style:
                      TextStyle(fontSize: 13, color: Colors.white),
                    ),
                    const SizedBox(height: 60),
                    Text(
                      name,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      cafNumber,
                      style: const TextStyle(
                          color: Colors.white70, fontSize: 18),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // Bottom Button
            InkWell(
              onTap: () => _openCollegeInfo(context),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                width: double.infinity,
                color: btnColor,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.info, color: Colors.white, size: 30),
                    SizedBox(width: 10),
                    Text(
                      "College Information",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openCollegeInfo(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => CollegeInfo(),
    );
  }
}
