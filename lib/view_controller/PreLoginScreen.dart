import 'package:flutter/material.dart';
import 'CollegeInformation.dart';

class PreLoginScreen extends StatefulWidget {
  const PreLoginScreen({super.key});

  @override
  State<PreLoginScreen> createState() => _PreLoginScreenState();
}

class _PreLoginScreenState extends State<PreLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              "assets/bg.png",
              fit: BoxFit.cover,
            ),
          ),

          // Main UI
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 140),

                // Logo
                Center(
                  child: Image.asset(
                    "assets/logo.png",
                    height: 170,
                    width: 170,
                  ),
                ),

                const SizedBox(height: 30),

                const Text(
                  "ONLINE FACILITATION SYSTEM\nFOR STUDENTS",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.3,
                  ),
                ),

                const SizedBox(height: 15),

                const Text(
                  "Bihar School Examination Board, Govt. of Bihar",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 60),

                const Text(
                  "Not Login Yet ?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                const Text(
                  "Login New with Registration No.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),

                const SizedBox(height: 35),

                SizedBox(
                  width: 180,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 160),
              ],
            ),
          ),

          // Bottom Bar - College Information
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      )),
                  builder: (_) => Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: CollegeInfo(),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                color: Colors.red.shade900,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.account_balance, color: Colors.white, size: 30),
                    SizedBox(width: 12),
                    Text(
                      "College Information",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// ------------------------------------------------------------------------------------------
// CUSTOM WIDGETS
// ------------------------------------------------------------------------------------------

// Dropdown UI
Widget _dropdownField({required String label}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      const SizedBox(height: 8),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.white60, width: 1.4),
          ),
        ),
        child: Row(
          children: const [
            Expanded(
              child: Text(
                "",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            Icon(Icons.keyboard_arrow_down, color: Colors.white),
          ],
        ),
      ),
    ],
  );
}

// Search textfield
Widget _searchField() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        "Type College Name",
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
      const SizedBox(height: 8),
      Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.white60, width: 1.4),
          ),
        ),
        padding: const EdgeInsets.only(bottom: 5),
        child: Row(
          children: const [
            Expanded(
              child: TextField(
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
            Icon(Icons.search, color: Colors.white, size: 26),
          ],
        ),
      ),
    ],
  );
}
