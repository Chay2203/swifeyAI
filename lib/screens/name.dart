import 'package:flutter/material.dart';
import 'date.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swifey/models/user.dart';

class Name extends StatefulWidget {
  final UserModel user;
  const Name({required this.user, super.key});
  @override
  State<Name> createState() => _NameState();
}

class _NameState extends State<Name> {
  final TextEditingController nameController = TextEditingController();
  String errorMessage = '';

  void handleNext() {
    if (nameController.text.isNotEmpty) {
      widget.user.name = nameController.text;
      Navigator.push(
        context, 
        MaterialPageRoute(builder: (context) => DateSelector(user: widget.user))
      );
    } else {
      setState(() {
        errorMessage = "Did you forget your name? Don't worry, we all have those days!";
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
              "What's your name?",
              style: GoogleFonts.poppins(
                color: const Color(0xFF00307B),
                fontSize: 33.0,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5, // Adjust text spacing
                height: 1.2, // Adjust line height
              ),
            ),
            const SizedBox(height: 20.0),

            // Name Input Field
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: "Enter name",
                hintStyle: GoogleFonts.poppins(
                  color: const Color(0xFF00307B),
                  fontSize: 18.0,
                  letterSpacing: -0.5, // Adjust text spacing
                ),
              ),
            ),
            const SizedBox(height: 20.0),
              Text(
                "This is how it'll appear on your profile... unless you change it later, because let's be honest, who doesn't?",
                style: GoogleFonts.poppins(
                  color: const Color(0xFF00307B),
                  fontSize: 16.0,
                  letterSpacing: -0.5, 
                  height: 1.4, 
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                "But hey, no pressure, you can change it later... probably. \nOr not. Your call.",
                style: GoogleFonts.poppins(
                  color: const Color(0xFF00307B),
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5, 
                  height: 1.4, 
                ),
              ),
            const SizedBox(height: 20.0),
            if (errorMessage.isNotEmpty)
              Text(
                errorMessage,
                style: GoogleFonts.poppins(
                  color: Colors.red,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                  height: 1.4,
                ),
              ),
            const Spacer(),

            // Next Button
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
                  letterSpacing: -0.5, // Adjust text spacing
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
