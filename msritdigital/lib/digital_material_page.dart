import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DigitalMaterialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Digital Material'),
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
      ),
      body: DigitalMaterialApp(), // Embed the list in the page
    );
  }
}

class DigitalMaterialApp extends StatefulWidget {
  @override
  _DigitalMaterialAppState createState() => _DigitalMaterialAppState();
}

class _DigitalMaterialAppState extends State<DigitalMaterialApp> {
  final List<Map<String, dynamic>> _materialList = [
    {
      'sNo': 1,
      'description': 'MAC21',
      'subject': 'NUMERICAL TECHNIQUES AND DIFFERENTIAL EQUATIONS',
      'topic': 'LAB MANUAL',
      'url': 'https://drive.google.com/file/d/1BSpwFsPtweJEqMwYa0iMg_9w_y05Jz89/view?usp=sharing',
    },
    {
      'sNo': 2,
      'description': 'CYC22',
      'subject': 'Chemistry',
      'topic': 'UNIT-1',
      'url': 'https://drive.google.com/file/d/1HAVhsZX940adX3FNWFdn-VqMZpWK5slt/view?usp=sharing',
    },
    {
      'sNo': 3,
      'description': 'CYC22',
      'subject': 'Chemistry',
      'topic': 'UNIT-2',
      'url': 'https://drive.google.com/file/d/13Yf3GvGunHfcEwYgEYFXRulpK4pKRF8d/view?usp=sharing',
    },
    {
      'sNo': 4,
      'description': 'ESC231',
      'subject': 'Civil Engg',
      'topic': 'UNIT-1',
      'url': 'https://drive.google.com/file/d/1fgcZNZbnbl53xXK67U1FL17AnECY7ZmJ/view?usp=sharing',
    },
    {
      'sNo': 5,
      'description': 'ESC231',
      'subject': 'Civil Engg',
      'topic': 'UNIT-2',
      'url': 'https://drive.google.com/file/d/10mdNRYbpEh2aeCrcNL1NRHbqH9WO7eYE/view?usp=sharing',
    },
    {
      'sNo': 6,
      'description': 'ETC246',
      'subject': 'Cyber Security',
      'topic': 'UNIT -1,2,3,4,5',
      'url': 'https://drive.google.com/drive/folders/1cpM5UUBPXxYcIzOWwaEBXKu6r8dVWHE_?usp=sharing',
    },
    {
      'sNo': 7,
      'description': 'HSCC25',
      'subject': 'Professional English',
      'topic': 'UNIT-1,2,3',
      'url': 'https://drive.google.com/drive/folders/1NtqyzNWs2Ud3fu7ArKv9Q9tXTQh5kL0j?usp=sharing',
    },
    {
      'sNo': 8,
      'description': 'HSCC26',
      'subject': 'Constitution of India',
      'topic': 'UNIT -1,2,3,4,5',
      'url': 'https://drive.google.com/drive/folders/1SqxTz_aNmdV75rkpUQ1NxXVGtPNBoIxZ?usp=sharing',
    },
    {
      'sNo': 9,
      'description': 'AECC27',
      'subject': 'Design Thinking',
      'topic': 'All units PPT',
      'url': 'https://drive.google.com/drive/folders/1SqxTz_aNmdV75rkpUQ1NxXVGtPNBoIxZ?usp=sharing',
    },
    {
      'sNo': 10,
      'description': 'MELC28',
      'subject': 'Cyber Security',
      'topic': 'UNIT -1,2,3,4,5',
      'url': 'https://drive.google.com/file/d/1XaXZVPDtvx6T_lVuBKmfumBFZ71PDeOE/view?usp=sharing',
    },
    // Add more items with URLs as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Background image
        Image.asset(
          'assets/images/bg.jpg', // Ensure this path is correct
          fit: BoxFit.cover, // Cover the entire screen
        ),
        // Content over the background
        ListView.builder(
          itemCount: _materialList.length,
          itemBuilder: (context, index) {
            final material = _materialList[index];
            return Card(
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: ListTile(
                contentPadding: EdgeInsets.all(16.0),
                title: Text(
                  material['description'],
                  style: TextStyle(color: Colors.black), // Text color black
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Subject: ${material['subject']}',
                      style: TextStyle(color: Colors.black), // Text color black
                    ),
                    Text(
                      'Topic: ${material['topic']}',
                      style: TextStyle(color: Colors.black), // Text color black
                    ),
                  ],
                ),
                leading: CircleAvatar(
                  child: Text(material['sNo'].toString(), style: TextStyle(color: Colors.black)), // Text color black
                ),
                trailing: IconButton(
                  icon: Icon(Icons.open_in_new, color: Colors.black), // Icon color black
                  onPressed: () => _launchURL(material['url']),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // Handle the error here
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not launch $url'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
