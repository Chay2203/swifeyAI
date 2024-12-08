import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swifey/models/user.dart';

class ProfilePage extends StatefulWidget {
  final UserModel user;
  const ProfilePage({required this.user, Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEE0D3),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEEE0D3),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF00307B)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'My Profile',
          style: GoogleFonts.poppins(
            color: const Color(0xFF00307B),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: const Color(0xFF00307B).withOpacity(0.1),
                    child: Icon(
                      Icons.person,
                      size: 80,
                      color: const Color(0xFF00307B),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.user.name ?? 'User Profile',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF00307B),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            _buildVerificationStatusCard(),
            const SizedBox(height: 20),
            _buildPersonalInfoCard(),
            const SizedBox(height: 20),
            _buildProfessionalInfoCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildVerificationStatusCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.verified, color: Colors.green),
                const SizedBox(width: 10),
                Text(
                  'Verification Status',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF00307B),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Verified Fields:',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                color: const Color(0xFF00307B),
              ),
            ),
            _buildVerifiedFieldsList(),
            const SizedBox(height: 10),
            Text(
              'Verification Provider: LinkedIn',
              style: GoogleFonts.poppins(
                color: const Color(0xFF00307B),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVerifiedFieldsList() {
    List<String> verifiedFields = [
      'Name',
      'Date of Birth',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: verifiedFields.map((field) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 16),
              const SizedBox(width: 8),
              Text(
                field,
                style: GoogleFonts.poppins(
                  color: const Color(0xFF00307B),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPersonalInfoCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Personal Information',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF00307B),
              ),
            ),
            const SizedBox(height: 10),
            _buildInfoRow(Icons.person, 'Name', widget.user.name),
            _buildInfoRow(Icons.email, 'Email', widget.user.email),
            _buildInfoRow(Icons.cake, 'Date of Birth', 
              widget.user.dateOfBirth?.toString().split(' ')[0] ?? 'Not Provided'),
            _buildInfoRow(Icons.transgender, 'Gender', widget.user.gender),
          ],
        ),
      ),
    );
  }

  Widget _buildProfessionalInfoCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Professional Information',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF00307B),
              ),
            ),
            const SizedBox(height: 10),
            _buildInfoRow(Icons.school, 'College', widget.user.college),
            _buildInfoRow(Icons.work, 'Company', widget.user.company),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF00307B), size: 20),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF00307B),
                ),
              ),
              Text(
                value ?? 'Not Provided',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF00307B),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}