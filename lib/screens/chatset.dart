import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/user.dart';

class ChatSettingsPage extends StatefulWidget {
  final UserModel currentUser;

  const ChatSettingsPage({Key? key, required this.currentUser}) : super(key: key);

  @override
  _ChatSettingsPageState createState() => _ChatSettingsPageState();
}

class _ChatSettingsPageState extends State<ChatSettingsPage> {
  late bool _keepChatHistory;

  @override
  void initState() {
    super.initState();
    _keepChatHistory = widget.currentUser.chatHistoryPreference ?? true;
  }

  void _updateChatHistorySetting(bool value) {
    setState(() {
      _keepChatHistory = value;
      widget.currentUser.chatHistoryPreference = value;
      // TODO: Persist this setting in database/storage
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEE0D3),
      appBar: AppBar(
        backgroundColor: const Color(0xFF00307B),
        title: Text(
          'Chat Settings',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: ListTile(
                  title: Text(
                    'Keep Chat History',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF00307B),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    'Retain chat history when connection is removed',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF8C8C8C),
                      fontSize: 12,
                    ),
                  ),
                  trailing: Switch(
                    value: _keepChatHistory,
                    onChanged: _updateChatHistorySetting,
                    activeColor: const Color(0xFF00307B),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'This setting controls whether your chat history is preserved or deleted when a connection is removed.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: const Color(0xFF8C8C8C),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}