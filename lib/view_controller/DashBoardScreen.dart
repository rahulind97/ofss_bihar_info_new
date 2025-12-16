import 'package:flutter/material.dart';
import '../constants/Colors.dart';
import 'CollegeInformation.dart';

class DashboardScreen extends StatelessWidget {
  final Map userData;

  DashboardScreen({required this.userData});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true, // <--- important
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: btnColor),
              child: const Text(
                "Menu",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),

            // College Information
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('College Information'),
              onTap: () {
                Navigator.pop(context);
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  builder: (_) => CollegeInfo(),
                );
              },
            ),

            // Profile Screen
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('My Info'),
              onTap: () {
                Navigator.pop(context);
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (_) => ProfileScreen(), // Create this screen
                //   ),
                // );
              },
            ),

            // Settings Screen
            ListTile(
              leading: const Icon(Icons.details),
              title: const Text('Admission Details'),
              onTap: () {
                Navigator.pop(context);
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (_) => SettingsScreen(), // Create this screen
                //   ),
                // );
              },
            ),

            // Help Screen
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Slide Up Selection'),
              onTap: () {
                Navigator.pop(context);
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (_) => HelpScreen(), // Create this screen
                //   ),
                // );
              },
            ),
            ListTile(
              leading: const Icon(Icons.feedback),
              title: const Text('Feed Back'),
              onTap: () {
                Navigator.pop(context);
                // Add your logout logic here
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('App Version'),
              onTap: () {
                Navigator.pop(context);
                // Add your logout logic here
              },
            ),
            // Logout
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pop(context);
                // Add your logout logic here
              },
            ),
          ],
        ),
      ),

      // Transparent AppBar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white, size: 32),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: Colors.black.withOpacity(0.5), // Dark overlay
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 0)
                      .copyWith(top: kToolbarHeight + 20), // offset for AppBar
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
                        userData["Name"] ?? "",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        userData["cafNumber"] ?? "",
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 18),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              // Bottom College Information Button
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    builder: (_) => CollegeInfo(),
                  );
                },
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
      ),
    );
  }
}
