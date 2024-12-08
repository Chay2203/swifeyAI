import 'package:flutter/material.dart';
import '../models/user.dart';
import 'chatall.dart';

class StakingPage extends StatefulWidget {
  final UserModel currentUser;
  final UserModel targetUser;

  const StakingPage({
    Key? key,
    required this.currentUser,
    required this.targetUser,
  }) : super(key: key);

  @override
  _StakingPageState createState() => _StakingPageState();
}

class _StakingPageState extends State<StakingPage> {
  final double stakingAmount = 0.2;
  bool _isStaking = false;

  Future<void> _performStaking() async {
    try {
      setState(() {
        _isStaking = true;
      });
      widget.currentUser.stakingStatus = true;
      widget.targetUser.stakingStatus = true;
      if ((widget.currentUser.stakingStatus ?? false) &&
          (widget.targetUser.stakingStatus ?? false)) {
        _navigateToChatPage();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Staking failed: $e')),
      );
    } finally {
      setState(() {
        _isStaking = false;
      });
    }
  }

  void _navigateToChatPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatConnectionsPage(
          currentUser: widget.currentUser,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFEEE0D3),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Stake ${stakingAmount} SOL to Connect',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _isStaking ? null : _performStaking,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: _isStaking
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Stake and Connect',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold, 
                            fontFamily: 'Poppins',
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
