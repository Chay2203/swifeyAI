import 'package:flutter/material.dart';
import 'package:swifey/screens/college.dart';
import 'package:swifey/models/user.dart';
import 'package:google_fonts/google_fonts.dart';

class GenderSelector extends StatefulWidget {
  final UserModel user; 
  const GenderSelector({required this.user, Key? key}) : super(key: key);

  @override
  State<GenderSelector> createState() => _GenderSelectorState();
}

class _GenderSelectorState extends State<GenderSelector> {
String? selectedGender;
String errorMessage = '';

void handleNext() {
  widget.user.gender = selectedGender;
  if (selectedGender == null) {
    setState(() {
      errorMessage = "Come on, pick a gender! We promise it won't be awkward.";
    });
  } else {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GraduatedFrom(user: widget.user)),
    );
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
            "What's your gender?",
            style: GoogleFonts.poppins(
              color: const Color(0xFF00307B),
              fontSize: 33.0,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 20.0),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Radio<String>(
                    value: 'Male',
                    groupValue: selectedGender,
                    onChanged: (String? value) {
                      setState(() {
                        selectedGender = value;
                        errorMessage = ''; 
                      });
                    },
                  ),
                  Text(
                    'Male',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF00307B),
                      fontSize: 18.0,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 20),
              Row(
                children: [
                  Radio<String>(
                    value: 'Female',
                    groupValue: selectedGender,
                    onChanged: (String? value) {
                      setState(() {
                        selectedGender = value;
                        errorMessage = ''; 
                      });
                    },
                  ),
                  Text(
                    'Female',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF00307B),
                      fontSize: 18.0,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 20),
            ],
          ),
          const SizedBox(height: 20.0),
          Text(
            "Please select your gender",
            style: GoogleFonts.poppins(
              color: const Color(0xFF00307B),
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
              height: 1.4,
            ),
          ),
          Text(
            "You can't change this at least later.",
            style: GoogleFonts.poppins(
              color: const Color(0xFF00307B),
              fontSize: 16.0,
              letterSpacing: -0.5,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 10.0),
          Text(
            "If you turn Gay, then let us know.",
            style: GoogleFonts.poppins(
              color: const Color(0xFF00307B),
              fontSize: 12.0,
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
