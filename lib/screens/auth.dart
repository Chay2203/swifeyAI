import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; 
import 'package:swifey/screens/name.dart';
import 'package:swifey/models/user.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;
  final TextEditingController emailController = TextEditingController();

void handleNext() {
  if (emailController.text.isNotEmpty) {
    final user = UserModel(email: emailController.text);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Name(user: user)),
    );
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEE0D3),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo Section
                Column(
                  children: [
                    const CircleAvatar(
                      radius: 75,
                      backgroundImage: AssetImage('assets/logo.jpg'),
                      backgroundColor: Colors.transparent,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      isLogin ? "Welcome Back" : "Create Your Account",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF00307B),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),

                // Form Section
                Column(
                  children: [
                    // Email Input
                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Email Address",
                        hintStyle: GoogleFonts.poppins(
                          color: const Color(0xFF00307B),
                        ),
                        filled: true,
                        fillColor: const Color(0xFFEEE0D3),
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: const BorderSide(color: Color(0xFF00307B), width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: const BorderSide(color: Color(0xFF00307B), width: 2),
                        ),
                      ),
                      style: GoogleFonts.poppins(fontSize: 16, color: Colors.black),
                    ),
                    const SizedBox(height: 20),

                    // Button
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
                        isLogin ? "Log In" : "Sign Up",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Switch Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isLogin
                          ? "Don't have an account? "
                          : "Already have an account? ",
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF8C8C8C),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isLogin = !isLogin;
                        });
                      },
                      child: Text(
                        isLogin ? "Sign Up" : "Log In",
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF00307B),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
