import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final String userId; // Add this to accept the user ID

  const ProfilePage({Key? key, required this.userId}) : super(key: key); // Constructor to receive the user ID

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _addressController = TextEditingController(text: 'RIT ');
  final TextEditingController _phoneController = TextEditingController(text: '+91 9999999999');
  final TextEditingController _emailController = TextEditingController(text: 'demo@msrit.edu');

  bool _isEditing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.pinkAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); // Navigate back to the previous screen
            },
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            'assets/images/bg.jpg', // Path to your background image
            fit: BoxFit.cover,
          ),
          // Foreground Content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildProfileHeader(),
                const SizedBox(height: 20),
                _buildProfileInfo(),
                const SizedBox(height: 20),
                if (_isEditing) _buildEditFields(),
                const SizedBox(height: 20),
                _buildActionButtons(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 80,
            backgroundImage: AssetImage('assets/images/male.jpg'),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: IconButton(
              icon: const Icon(Icons.camera_alt, color: Colors.blue, size: 30),
              onPressed: () {
                // Implement change profile picture functionality here
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileInfo() {
    return Column(
      children: [
        Text(
          widget.userId, // Display user ID
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black, // Text color set to black
          ),
        ),
        const SizedBox(height: 8),
       
        const SizedBox(height: 10),
        _buildInfoRow('Branch:', 'CSE'),
        _buildInfoRow('Semester:', '2nd'),
        _buildInfoRow('Year:', '2023-27'),
        if (!_isEditing) _buildInfoRow('Phone Number:', _phoneController.text),
        _buildInfoRow('Date of Birth:', 'MONTH DD YYYY'),
        if (!_isEditing) _buildInfoRow('Address:', _addressController.text),
        if (_isEditing) _buildInfoRow('Personal Email:', _emailController.text),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black, // Text color set to black
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87, // Text color set to black
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditFields() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _addressController,
            decoration: InputDecoration(labelText: 'Address'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an address';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _phoneController,
            decoration: InputDecoration(labelText: 'Phone Number'),
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a phone number';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(labelText: 'Personal Email'),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an email';
              } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        if (!_isEditing) ...[
          ElevatedButton(
            onPressed: () {
              setState(() {
                _isEditing = true;
              });
            },
            child: const Text('Edit Profile'),
          ),
          const SizedBox(height: 10),
        ],
        if (_isEditing) ...[
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                // Save changes here
                setState(() {
                  _isEditing = false;
                });
              }
            },
            child: const Text('Save Changes'),
          ),
          const SizedBox(height: 10),
        ],
      ],
    );
  }
}
