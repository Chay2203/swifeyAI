import 'package:flutter/material.dart';
import '../models/user.dart';
import 'stake.dart';
import 'profile.dart';
import 'chatall.dart';

class SwipePage extends StatefulWidget {
  final UserModel currentUser;

  const SwipePage({
    required this.currentUser,
    Key? key
  }) : super(key: key);

  @override
  _SwipePageState createState() => _SwipePageState();
}

class _SwipePageState extends State<SwipePage> {
  final List<UserModel> users = [
    UserModel(
      userId: '20',
      name: 'Naga Chaitanya',
      email: 'naga@example.com',
      dateOfBirth: DateTime(1995, 5, 12),
      gender: 'Male',
      college: 'Scaler School of Technology',
      company: 'Tech Inc.',

    ),
    UserModel(
      userId: '21',
      name: 'Jane Smith',
      email: 'jane@example.com',
      dateOfBirth: DateTime(1993, 8, 19),
      gender: 'Female',
      college: 'MIT',
      company: 'Innovate Corp.',
    ),
    UserModel(
      userId: '22',
      name: 'Alice Brown',
      email: 'alice@example.com',
      dateOfBirth: DateTime(1990, 3, 23),
      gender: 'Female',
      college: 'Stanford University',
      company: 'Creative Solutions',
    ),
  ];

  int _currentIndex = 0;
  double _cardOffset = 0.0;
  bool _isSwiping = false;


  void _onHorizontalDragStart(DragStartDetails details) {
    setState(() {
      _isSwiping = true;
    });
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    setState(() {
      _cardOffset += details.primaryDelta!;
    });
  }

    void _onHorizontalDragEnd(DragEndDetails details) {
        if (_cardOffset.abs() > MediaQuery.of(context).size.width * 0.5) {
            UserModel targetUser = users[_currentIndex]; 
            _onSwipeRight(targetUser); 
            setState(() {
                _currentIndex = (_currentIndex + 1) % users.length;
                _cardOffset = 0.0;
            });
        } else {
            setState(() {
                _cardOffset = 0.0;
            });
        }
        setState(() {
            _isSwiping = false;
        });
    }

  void _onHorizontalDragCancel() {
    setState(() {
      _cardOffset = 0.0;
      _isSwiping = false;
    });
  }

  void _onSwipeRight(UserModel targetUser) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StakingPage(
          currentUser: widget.currentUser,
          targetUser: targetUser
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Swipe Connections', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.person, color: Colors.grey),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage(user: widget.currentUser)),
              );
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.chat, color: Colors.grey),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatConnectionsPage(currentUser: widget.currentUser)),
                );
              },
            ),
          ],
        ),
        body: GestureDetector(
          onHorizontalDragStart: _onHorizontalDragStart,
          onHorizontalDragUpdate: _onHorizontalDragUpdate,
          onHorizontalDragEnd: _onHorizontalDragEnd,
          onHorizontalDragCancel: _onHorizontalDragCancel,
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                _buildUserCard(users[(_currentIndex + 1) % users.length], scale: 0.9, opacity: 0.8),
                Transform.translate(
                  offset: Offset(_cardOffset, 0),
                  child: Transform.rotate(
                    angle: _cardOffset / MediaQuery.of(context).size.width * 0.2,
                    child: _buildUserCard(users[_currentIndex]),
                  ),
                ),
                if (_isSwiping)
                  Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (_cardOffset < 0) 
                          _buildActionButton(
                            icon: Icons.close,
                            color: Colors.red,
                            opacity: (_cardOffset.abs() / (MediaQuery.of(context).size.width * 0.5)).clamp(0.0, 1.0),
                          ),
                        if (_cardOffset > 0) 
                          _buildActionButton(
                            icon: Icons.favorite,
                            color: Colors.green,
                            opacity: (_cardOffset.abs() / (MediaQuery.of(context).size.width * 0.5)).clamp(0.0, 1.0),
                          ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserCard(UserModel user, {double scale = 1.0, double opacity = 1.0}) {
    return GestureDetector(
      onDoubleTap: () => _onSwipeRight(user),
      child: Transform.scale(
        scale: scale,
        child: Opacity(
          opacity: opacity,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.85,
            height: MediaQuery.of(context).size.height * 0.7,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                const BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.8),
                          ],
                        ),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${user.name}, ${_calculateAge(user.dateOfBirth)}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '${user.college} • ${user.company}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    double opacity = 1.0,
  }) {
    return Opacity(
      opacity: opacity,
      child: Container(
        width: 70,
        height: 70,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Icon(icon, color: color, size: 35),
      ),
    );
  }

  int _calculateAge(DateTime? birthDate) {
    if (birthDate == null) return 0;
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    if (currentDate.month < birthDate.month || (currentDate.month == birthDate.month && currentDate.day < birthDate.day)) {
      age--;
    }
    return age;
  }
}

void main() => runApp(MaterialApp(home: SwipePage(currentUser: UserModel(userId: '1', name: 'John Doe', email: 'john@example.com'))));