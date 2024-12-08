import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/user.dart';
import 'chat.dart';

class ChatConnectionsPage extends StatefulWidget {
  final UserModel currentUser;

  const ChatConnectionsPage({
    Key? key, 
    required this.currentUser
  }) : super(key: key);

  @override
  _ChatConnectionsPageState createState() => _ChatConnectionsPageState();
}

class _ChatConnectionsPageState extends State<ChatConnectionsPage> {
  List<UserModel> _getSwipedUsers() {
    return [
    UserModel(
      userId: '20',
      name: 'Naga Chaitanya',
      email: 'naga@example.com',
      dateOfBirth: DateTime(1995, 5, 12),
      gender: 'Male',
      college: 'Scaler School of Technology',
      company: 'Tech Inc.',
      stakingStatus: true,
      ),
    ];
  }

  Future<void> _handleDisconnect(UserModel user) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFEEE0D3),
          title: Text(
            'Disconnect from ${user.name}?',
            style: GoogleFonts.poppins(
              color: const Color(0xFF00307B),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Your staked amount (0.2 SOL) will be refunded to your wallet.',
            style: GoogleFonts.poppins(
              color: const Color(0xFF00307B),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF00307B),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  // TODO: Implement actual stake refund logic here
                  
                  // Update user connection status
                  setState(() {
                    user.stakingStatus = false;
                    // Remove from connected users list if needed
                  });

                  Navigator.pop(context); // Close dialog
                  
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Successfully disconnected. 0.2 SOL has been refunded.',
                        style: GoogleFonts.poppins(),
                      ),
                      backgroundColor: Colors.green,
                    ),
                  );
                } catch (e) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Error disconnecting: $e',
                        style: GoogleFonts.poppins(),
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: Text(
                'Disconnect',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _handleConnect(UserModel user) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatPage(
          currentUser: widget.currentUser,
          targetUser: user,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final swipedUsers = _getSwipedUsers();

    return Scaffold(
      backgroundColor: const Color(0xFFEEE0D3),
      appBar: AppBar(
        backgroundColor: const Color(0xFF00307B),
        title: Text(
          'Discover Connections',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
      ),
      body: swipedUsers.isEmpty
        ? _buildEmptyState()
        : _buildSwipedUsersList(swipedUsers),
    );
  }

  Widget _buildSwipedUsersList(List<UserModel> users) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: const Color(0xFF00307B),
                child: Text(
                  (user.name ?? 'U')[0].toUpperCase(),
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text(
                user.name ?? 'Anonymous User',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF00307B),
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (user.college != null)
                    Text(
                      'Graduated from ${user.college}',
                      style: GoogleFonts.poppins(fontSize: 12),
                    ),
                  if (user.company != null)
                    Text(
                      'Works at ${user.company}',
                      style: GoogleFonts.poppins(fontSize: 12),
                    ),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (user.stakingStatus ?? false)
                    IconButton(
                      icon: const Icon(
                        Icons.link_off,
                        color: Colors.red,
                      ),
                      onPressed: () => _handleDisconnect(user),
                    ),
                  ElevatedButton(
                    onPressed: () {
                      if (user.stakingStatus ?? false) {
                        _handleConnect(user);
                      } else {
                        // Navigate to staking page
                        // TODO: Implement staking navigation
                        setState(() {
                          user.stakingStatus = true; // Temporary for testing
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00307B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      user.stakingStatus ?? false ? 'Chat' : 'Connect',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.people_outline,
            size: 100,
            color: const Color(0xFF00307B).withOpacity(0.5),
          ),
          const SizedBox(height: 20),
          Text(
            'No matches yet',
            style: GoogleFonts.poppins(
              color: const Color(0xFF00307B),
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Start swiping to find your matches!',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: const Color(0xFF8C8C8C),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}