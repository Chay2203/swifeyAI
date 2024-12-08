import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:reclaim_sdk/reclaim.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swifey/models/user.dart';
import 'package:swifey/services/mongo.dart';
import 'stake.dart';

class ProfileVerificationPage extends StatefulWidget {
  final UserModel user;
  const ProfileVerificationPage({required this.user, super.key});

  @override
  _ProfileVerificationPageState createState() => _ProfileVerificationPageState();
}

class _ProfileVerificationPageState extends State<ProfileVerificationPage> {
  bool _isSaving = false;

  Future<void> _saveUserData() async {
    setState(() => _isSaving = true);
    try {
      await MongoDBService.insertUser(widget.user);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile saved successfully!'))
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving profile: $e'))
      );
    } finally {
      setState(() => _isSaving = false);
    }
  }

  void handleNext() {
  if (widget.user.email != null) {
    Navigator.push(
      context,
        MaterialPageRoute(builder: (context) => StakingConnectionPage(user: widget.user)),
    );
  }
}

  // Verification status and data
  String _verificationStatus = 'Not Verified';
  Map<String, dynamic> _verifiedData = {};

  // List of verifiable fields
  final List<String> _verifiableFields = [
    'Name',
    'Date of Birth',
    'Gender',
    'Graduated From',
    'Currently Working'
  ];

  List<String> _selectedFields = [];

  final Map<String, String> _providerIDs = {
    'LinkedIn': 'a9f1063c-06b7-476a-8410-9ff6e427e637',
    'X (Twitter)': 'e6fe962d-8b4e-4ce5-abcc-3d21c88bd64a' 
  };

  final List<String> _providers = ['LinkedIn', 'X (Twitter)'];

  String _selectedProvider = 'LinkedIn';

  void _toggleFieldSelection(String field) {
    setState(() {
      if (_selectedFields.contains(field)) {
        _selectedFields.remove(field);
      } else {
        if (_selectedFields.length < 2) {
          _selectedFields.add(field);
        } else {
          _selectedFields.removeAt(0);
          _selectedFields.add(field);
        }
      }
    });
  }

Future<void> _startReclaimVerification() async {
  try {
    String providerID = _providerIDs[_selectedProvider]!; 
    final reclaimProofRequest = await ReclaimProofRequest.init(
      "0xE98e43CEA4bb942f7bBdd4495455D9957DD10995", 
      "0x69689b3a067930070fca53c91ec1f1ff226ea3ab1436599674aa503a1d4427c8", 
      providerID, 
    );

    final requestUrl = await reclaimProofRequest.getRequestUrl();

    if (await canLaunchUrl(Uri.parse(requestUrl))) {
      await launchUrl(
        Uri.parse(requestUrl),
        mode: LaunchMode.externalApplication,
      );
      await reclaimProofRequest.startSession(
        onSuccess: _handleVerificationSuccess,
        onError: _handleVerificationError,
      );
    } else {
      throw 'Could not launch the URL';
    }
  } catch (error) {
    _handleVerificationError(error);
  }
}

  void _handleVerificationSuccess(dynamic proof) {
    setState(() {
      _verificationStatus = 'Verified Successfully';      
      if (proof is! String) {
        _verifiedData = {
          'provider': _selectedProvider,
          'verifiedFields': _selectedFields,
          'proofDetails': proof.toString()
        };
      }
    });
    print('Verification Proof: $proof');
  }

  void _handleVerificationError(dynamic error) {
    setState(() {
      _verificationStatus = 'Verification Failed';
      _verifiedData.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Verification Error: $error'),
        backgroundColor: Colors.red,
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEE0D3),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0, bottom: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Color(0xFF00307B),
                  size: 30.0,
                ),
              ),
              const SizedBox(height: 30.0),
              Text(
                "Verify Your Profile",
                style: GoogleFonts.poppins(
                  color: const Color(0xFF00307B),
                  fontSize: 33.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 20.0),
              Text(
                "Select two fields to verify",
                style: GoogleFonts.poppins(
                  color: const Color(0xFF00307B),
                  fontSize: 18.0,
                ),
              ),
              const SizedBox(height: 10.0),
              DropdownButton<String>(
                value: _selectedProvider,
                isExpanded: true,
                items: _providers.map((provider) {
                  return DropdownMenuItem(
                    value: provider,
                    child: Text(provider),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedProvider = value!;
                  });
                },
              ),
              const SizedBox(height: 20.0),
              // Verifiable Fields
              Wrap(
                spacing: 10.0,
                children: _verifiableFields.map((field) {
                  return ChoiceChip(
                    label: Text(field),
                    selected: _selectedFields.contains(field),
                    onSelected: (_) => _toggleFieldSelection(field),
                    selectedColor: const Color(0xFF00307B).withOpacity(0.2),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20.0),
              Text(
                'Status: $_verificationStatus',
                style: GoogleFonts.poppins(
                  color: _verificationStatus == 'Verified Successfully' 
                    ? Colors.green 
                    : const Color(0xFF00307B),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const ui.Size(double.infinity, 50),
                  backgroundColor: _selectedFields.length == 2 
                    ? const Color(0xFF00307B) 
                    : Colors.grey,
                  padding: const EdgeInsets.symmetric(vertical: 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                onPressed: _selectedFields.length == 2 
                  ? _startReclaimVerification 
                  : null,
                child: Text(
                  "Verify Profile",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
              // Display verified data if available
              if (_verifiedData.isNotEmpty) ...[
                const SizedBox(height: 20.0),
                Text(
                  'Verified Data:',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF00307B),
                  ),
                ),
                ...(_verifiedData['verifiedFields'] as List).map((field) => 
                  Text(
                    field,
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF00307B),
                    ),
                  )
                ),
              ],
              const SizedBox(height: 20),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Email: ${widget.user.email}'),
                      Text('Name: ${widget.user.name}'),
                      Text('Date of Birth: ${widget.user.dateOfBirth?.toString().split(' ')[0]}'),
                      Text('Gender: ${widget.user.gender}'),
                      Text('College: ${widget.user.college}'),
                      Text('Company: ${widget.user.company}'),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
              
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const ui.Size(double.infinity, 50),
                  backgroundColor: const Color(0xFF00307B),
                ),
                onPressed: _isSaving 
                  ? null 
                  : () async {
                      // Save user profile
                      await _saveUserData();

                      // After saving, navigate to StakingConnectionPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StakingConnectionPage(user: widget.user),
                        ),
                      );
                    },
                child: const Text(
                  "Save Profile",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Poppins', fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}