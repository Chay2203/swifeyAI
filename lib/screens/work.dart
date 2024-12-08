import 'package:flutter/material.dart';
import 'verification.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swifey/models/user.dart';
class CompanySelector extends StatefulWidget {
  final UserModel user;
  const CompanySelector({required this.user, super.key});

  @override
  State<CompanySelector> createState() => _CompanySelectorState();
}

class _CompanySelectorState extends State<CompanySelector> {
  final TextEditingController companyController = TextEditingController();
  String errorMessage = '';

  void handleNext() {
    widget.user.company = companyController.text;
    if (companyController.text.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfileVerificationPage(user: widget.user)),
      );
    } else {
      setState(() {
        errorMessage = "Whoa! You forgot to drop your company's name. Don't worry, we won't tell HR.";
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
              "Where do you work at?",
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
              controller: companyController,
              decoration: InputDecoration(
                hintText: "Enter your company's name",
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
              "This will help us customize your experience... so we can ensure you never have to endure Wi-Fi slower than your last relationship.",
              style: GoogleFonts.poppins(
                color: const Color(0xFF00307B),
                fontSize: 16.0,
                letterSpacing: -0.5,
                height: 1.4,
              ),
            ),
            if (errorMessage.isNotEmpty) 
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  errorMessage,
                  style: GoogleFonts.poppins(
                    color: Colors.red,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
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
