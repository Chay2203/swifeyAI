import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swifey/models/user.dart';

class StakingConnectionPage extends StatefulWidget {
  final UserModel user;
  const StakingConnectionPage({required this.user, super.key});

  @override
  State<StakingConnectionPage> createState() => _StakingConnectionPageState();
}

class _StakingConnectionPageState extends State<StakingConnectionPage> {
  bool userHasStaked = false;
  bool connectionEstablished = false;
  String errorMessage = '';

  // This function is just a placeholder for the staking process
  // In a real scenario, you would integrate with a blockchain to perform the staking.
  void _stakeAmount() {
    // Simulate staking process
    setState(() {
      userHasStaked = true;
      errorMessage = '';
    });
  }

  // This function will check if both users have staked 0.2 SOL
  void _checkConnectionStatus() {
    if (userHasStaked) {
      setState(() {
        connectionEstablished = true;
      });
    } else {
      setState(() {
        errorMessage = 'You need to stake 0.2 SOL to establish a connection!';
      });
    }
  }

  void _withdrawStake() {
    setState(() {
      userHasStaked = false;
      connectionEstablished = false;
      errorMessage = '';
    });
  }

  void _disconnect() {
    setState(() {
      connectionEstablished = false;
      errorMessage = '';
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
              "Staking-Based Connection",
              style: GoogleFonts.poppins(
                color: const Color(0xFF00307B),
                fontSize: 33.0,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              "Stake 0.2 SOL to connect with another user",
              style: GoogleFonts.poppins(
                color: const Color(0xFF00307B),
                fontSize: 18.0,
              ),
            ),
            const SizedBox(height: 20.0),
            if (!userHasStaked) ...[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: const Color(0xFF00307B),
                  padding: const EdgeInsets.symmetric(vertical: 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                onPressed: _stakeAmount,
                child: Text(
                  "Stake 0.2 SOL",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
            ],
            const SizedBox(height: 20.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: userHasStaked ? const Color(0xFF00307B) : Colors.grey,
                padding: const EdgeInsets.symmetric(vertical: 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              onPressed: userHasStaked ? _checkConnectionStatus : null,
              child: Text(
                "Check Connection Status",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
            ),
            if (connectionEstablished) ...[
              const SizedBox(height: 20.0),
              Text(
                "Connection Established!",
                style: GoogleFonts.poppins(
                  color: Colors.green,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                onPressed: _disconnect,
                child: Text(
                  "Disconnect",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
            ],
            if (errorMessage.isNotEmpty) ...[
              const SizedBox(height: 20.0),
              Text(
                errorMessage,
                style: GoogleFonts.poppins(
                  color: Colors.red,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
