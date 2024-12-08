import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swifey/screens/gender.dart';
import 'package:swifey/models/user.dart';

class DateSelector extends StatefulWidget {
  final UserModel user;
  const DateSelector({required this.user, super.key});

  @override
  State<DateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  DateTime selectedDate = DateTime.now();
  String errorMessage = '';

  void handleNext() {
    // Calculate age
    var age = DateTime.now().year - selectedDate.year;
    if (selectedDate.month > DateTime.now().month || (selectedDate.month == DateTime.now().month && selectedDate.day > DateTime.now().day)) {
      age--;  
    }

    if (age >= 18) {
      widget.user.dateOfBirth = selectedDate;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GenderSelector(user: widget.user),
        ),
      );
    } else {
      setState(() {
        errorMessage = "Oops, you must be 18 or older. You’re still too young to time travel!";
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    )) ?? selectedDate;

    setState(() {
      selectedDate = picked;
    });
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
              "What's your birth date?",
              style: GoogleFonts.poppins(
                color: const Color(0xFF00307B),
                fontSize: 33.0,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5,
              height: 1.2, 
              ),
            ),
            const SizedBox(height: 20.0),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: AbsorbPointer(
                child: TextField(
                  controller: TextEditingController(text: "${selectedDate.toLocal()}".split(' ')[0]), // Display selected date
                  decoration: InputDecoration(
                    hintText: "Select date",
                    hintStyle: GoogleFonts.poppins(
                      color: const Color(0xFF00307B),
                      fontSize: 18.0,
                      letterSpacing: -0.5, 
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(color: const Color(0xFF00307B)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(color: const Color(0xFF00307B)),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              "This is how your birth date will appear... unless you time-travel and change it, which we totally don't recommend.",
              style: GoogleFonts.poppins(
                color: const Color(0xFF00307B),
                fontSize: 16.0,
                letterSpacing: -0.5, 
                height: 1.4,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              "You can change it later... but remember, no one believes you when you say you're 'eternally 21'.",
              style: GoogleFonts.poppins(
                color: const Color(0xFF00307B),
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 10),
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
