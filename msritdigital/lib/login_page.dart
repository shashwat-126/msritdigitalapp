import 'dart:io';
import 'package:flutter/material.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _errorMessage = '';

  Future<String> _getIpAddress() async {
    try {
      final interfaces = await NetworkInterface.list();
      for (var interface in interfaces) {
        for (var address in interface.addresses) {
          if (address.type == InternetAddressType.IPv4 && !address.address.startsWith('127.')) {
            return address.address;
          }
        }
      }
      return 'Unknown';
    } catch (e) {
      return 'Unknown';
    }
  }

  void _login() {
    if (_formKey.currentState?.validate() ?? false) {
      final email = _usernameController.text;

      // Validate email domain
      if (email.endsWith('@msrit.edu')) {
        // Extract the user ID from the email
        final userId = email.split('@')[0]; // Assumes user ID is part before '@'

        // Navigate to the HomePage with user ID
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(userId: userId),
          ),
        );
      } else {
        setState(() {
          _errorMessage = 'Only Student of MSRIT can access. If you are an MSRIT student, kindly contact your department office for access to MSRIT Digital.';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MSRIT Digital Login'),
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            'assets/images/bg.jpg',
            fit: BoxFit.cover,
          ),
          Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/college_logo.jpg', // Ensure path is correct
                      width: 100, // Adjust size as needed
                      height: 100, // Adjust size as needed
                    ),
                    Text(
                      'Ramaiah Institute of Technology',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextFormField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            labelText: 'Username (Email)',
                            errorText: _errorMessage.isEmpty ? null : _errorMessage,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter an email address';
                            }
                            if (!value.contains('@')) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(labelText: 'Password'),
                          obscureText: true,
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _login,
                          child: Text('Login'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              FutureBuilder<String>(
                future: _getIpAddress(),
                builder: (context, snapshot) {
                  String ipAddress = snapshot.data ?? 'Unknown';
                  return Container(
                    padding: EdgeInsets.all(16.0),
                    color: Colors.grey[200],
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('App Version: 1.0.0'), // Update as necessary
                        SizedBox(height: 8),
                        Text('IP Address: $ipAddress'),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
