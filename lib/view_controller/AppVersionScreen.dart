import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppVersionScreen extends StatefulWidget {
  const AppVersionScreen({super.key});

  @override
  State<AppVersionScreen> createState() => _AppVersionScreenState();
}

class _AppVersionScreenState extends State<AppVersionScreen> {
  String appVersion = '';
  String buildNumber = '';

  @override
  void initState() {
    super.initState();
    _loadVersion();
  }

  Future<void> _loadVersion() async {
    try {
      final info = await PackageInfo.fromPlatform();
      if (!mounted) return;
      setState(() {
        appVersion = info.version;
        buildNumber = info.buildNumber;
      });
    } catch (e) {
      // Fallback (prevents crash)
      setState(() {
        appVersion = 'N/A';
        buildNumber = 'N/A';
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   leading: IconButton(
      //     icon: const Icon(Icons.back_hand, color: Colors.white, size: 32),
      //     onPressed: () => {},
      //   ),
      // ),

      body: Stack(
        children: [
          /// 🔹 Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/bg.png',
              fit: BoxFit.cover,
            ),
          ),

          /// 🔹 Dark Overlay
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.55),
            ),
          ),

          /// 🔹 Content
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 30),

                /// App Logo
                Container(
                  height: 150,
                  width: 150,
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(90),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 12,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Image.asset(
                    'assets/app_logo.png',
                  ),
                ),

                const SizedBox(height: 16),

                /// App Name
                const Text(
                  'Bihar School Examination Board',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 6),

                const Text(
                  'Official Student Services App',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),

                const SizedBox(height: 40),

                /// Glass Card
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _infoRow(
                              Icons.verified,
                              'Board',
                              'BSEB, Patna',
                            ),
                            const Divider(color: Colors.white30),

                            _infoRow(
                              Icons.apps,
                              'Application Version',
                              appVersion.isEmpty
                                  ? 'Loading...'
                                  : '$appVersion (Build $buildNumber)',
                            ),
                            const Divider(color: Colors.white30),

                            _infoRow(
                              Icons.school,
                              'Purpose',
                              'Student Result & Services',
                            ),
                            const Divider(color: Colors.white30),

                            _infoRow(
                              Icons.security,
                              'Data Policy',
                              'Secure & Verified',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const Spacer(),

                /// Footer
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    children: const [
                      Text(
                        '© Bihar School Examination Board',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'All Rights Reserved',
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
