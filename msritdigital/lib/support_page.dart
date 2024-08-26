import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportPage extends StatefulWidget {
  @override
  _SupportPageState createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  String _inputData = '';

  // Function to handle form submission
  void _submitData() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _inputData = _controller.text;
      });
      _controller.clear();
    }
  }

  // Function to handle data clearing
  void _deleteData() {
    setState(() {
      _inputData = '';
    });
  }

  // Function to launch email client
  Future<void> _sendEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'care@msritidigital.com',
      query: encodeQueryParameters(<String, String>{
        'subject': 'Support Request',
        'body': 'Please provide your issue details here.',
      }),
    );

    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      throw 'Could not launch $emailLaunchUri';
    }
  }

  // Function to encode query parameters for the email URL
  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  // Function to validate form input
  String? _validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MSRIT Digital Support'),
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Raise a Tech issue',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'Enter your issue details',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 5,
                    validator: _validateInput,
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: _submitData,
                        child: Text('Submit'),
                      ),
                      ElevatedButton(
                        onPressed: _deleteData,
                        child: Text('Clear'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Submitted Data:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(_inputData.isNotEmpty ? _inputData : 'No data submitted'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _sendEmail,
              child: Text('Email Support'),
            ),
          ],
        ),
      ),
    );
  }
}
