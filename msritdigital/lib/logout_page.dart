import 'package:flutter/material.dart';
import 'login_page.dart'; // Ensure you have this import for the LoginPage

class LogoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand, // Ensure the Stack takes up the full screen
        children: [
          // Background image
          Image.asset(
            'assets/images/bg.jpg', // Ensure this path is correct
            fit: BoxFit.cover, // Cover the entire screen
          ),
          // Content over the background
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min, // This ensures the Column takes only as much space as needed
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Are you sure you want to logout?',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Ensure text is visible over the background
                    ),
                    textAlign: TextAlign.center, // Center text horizontally
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _logout(context);
                    },
                    child: Text('Logout'),
                  ),
                  SizedBox(height: 10),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _logout(BuildContext context) {
    // Clear user session data here if necessary.
    // Example using shared_preferences:
    // final prefs = await SharedPreferences.getInstance();
    // prefs.remove('user_token');

    // Navigate to the Login Page and clear the navigation stack
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
      (Route<dynamic> route) => false, // Remove all previous routes
    );
  }
}
