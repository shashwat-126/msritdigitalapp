import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RecorderContentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recorder Content'),
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
      ),
      body: RecorderContentApp(),
    );
  }
}

class RecorderContentApp extends StatefulWidget {
  @override
  _RecorderContentAppState createState() => _RecorderContentAppState();
}

class _RecorderContentAppState extends State<RecorderContentApp> {
  final List<Map<String, dynamic>> _materialList = [
    // Your list items here
    {
      'sNo': 1,
      'description': 'MAC21',
      'subject': 'NUMERICAL TECHNIQUES AND DIFFERENTIAL EQUATIONS',
      'topic': 'NPTEL',
      'url': 'https://nptel.ac.in/courses/111105121',
    },
     {
      'sNo': 2,
      'description': 'CYLC29',
      'subject': 'ENGG CHEMISTRY LAB',
      'topic': 'EXP VIDEOS BY DEPT OF CHEM',
      'url': 'https://msrit.edu/study-material/chemistry.html',
    },
     {
      'sNo': 3,
      'description': 'ETC246',
      'subject': 'CYBER SECURITY',
      'topic': 'INTRODUCTION TO CYBER SECURITY',
      'url': 'https://onlinecourses.swayam2.ac.in/nou19_cs08/preview',
    },
     {
      'sNo': 4,
      'description': 'HSCC25',
      'subject': 'PROFESSIONAL ENGLSIH',
      'topic': 'Technical Reading and Writing Practices',
      'url': 'https://academicguides.waldenu.edu/writingcenter/grammar/',
    },
    // ... (other items)
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assets/images/bg.jpg',
          fit: BoxFit.cover,
        ),
        ListView.builder(
          itemCount: _materialList.length,
          itemBuilder: (context, index) {
            final material = _materialList[index];
            return Card(
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              elevation: 4.0, // Add shadow for better visibility
              child: ListTile(
                contentPadding: EdgeInsets.all(16.0),
                title: Text(
                  material['description'],
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Subject: ${material['subject']}',
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      'Topic: ${material['topic']}',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
                leading: CircleAvatar(
                  backgroundColor: Colors.pinkAccent,
                  child: Text(
                    material['sNo'].toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.open_in_new, color: Colors.pinkAccent),
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not launch $url'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
