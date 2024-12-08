import 'package:flutter/material.dart';
import 'work.dart'; 
import 'package:google_fonts/google_fonts.dart';
import 'package:swifey/models/user.dart';

class GraduatedFrom extends StatefulWidget {
  final UserModel user;
  const GraduatedFrom({required this.user, super.key});

  @override
  State<GraduatedFrom> createState() => _GraduatedFromState();
}

class _GraduatedFromState extends State<GraduatedFrom> {
  final TextEditingController institutionController = TextEditingController();
  String errorMessage = '';

void handleNext() {
  widget.user.college = institutionController.text;
  if (institutionController.text.isNotEmpty) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CompanySelector(user: widget.user)),
    );
  } else {
    setState(() {
      errorMessage = "Oops! You forgot to enter your institution. We won't judge... much.";
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEE0D3),
      body: Container(
        margin: const EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0, bottom: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Color(0xFF00307B),
                size: 30.0,
              ),
            ),
            const SizedBox(height: 30.0),
            Text(
              "Where did you graduate from?",
              style: GoogleFonts.poppins(
                color: const Color(0xFF00307B),
                fontSize: 33.0,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: institutionController,
              decoration: InputDecoration(
                hintText: "Enter institution name",
                hintStyle: GoogleFonts.poppins(
                  color: const Color(0xFF00307B),
                  fontSize: 18.0,
                  letterSpacing: -0.5,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              "This will help us customize your experience... so we can make sure you're never stuck with bad Wi-Fi.",
              style: GoogleFonts.poppins(
                color: const Color(0xFF00307B),
                fontSize: 16.0,
                letterSpacing: -0.5,
                height: 1.4,
              ),
            ),
            if (errorMessage.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                errorMessage,
                style: GoogleFonts.poppins(
                  color: Colors.red,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                  height: 1.4,
                ),
              ),
            ),

            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: const Color(0xFF00307B),
                padding: const EdgeInsets.symmetric(vertical: 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              onPressed: handleNext,
              child: Text(
                "Next",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
