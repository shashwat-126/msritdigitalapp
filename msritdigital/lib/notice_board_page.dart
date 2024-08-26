import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(NoticeBoardApp());
}

class NoticeBoardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notice Board App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: NoticeBoardPage(),
    );
  }
}

class Notice {
  final String department;
  final String title;
  final String description;

  Notice({
    required this.department,
    required this.title,
    required this.description,
  });
}

class NoticeCard extends StatelessWidget {
  final Notice notice;

  NoticeCard({required this.notice});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              notice.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Department: ${notice.department}',
              style: TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.italic,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 8.0),
            Linkify(
              onOpen: (link) async {
                if (await canLaunch(link.url)) {
                  await launch(link.url);
                } else {
                  throw 'Could not launch ${link.url}';
                }
              },
              text: notice.description,
              style: TextStyle(fontSize: 16),
              linkStyle: TextStyle(color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}

class NoticeBoardPage extends StatelessWidget {
  final List<Notice> notices = [
    Notice(
      department: 'Registrar Academics Office',
      title: 'Skill Lab Notice',
      description:
          'INT410 is a NCMC course. Kindly contact your offering department for schedule.',
    ),
    Notice(
      department: 'Account Section',
      title: 'Fee Circular for AY-2024-25',
      description:
          'Please ensure to pay the fee within the stipulated time period. Use your USN as the login ID and your date of birth (DOB) as the password.\n'
          'Pay the fee at the following link: http://paypointedu.mygetepay.com/\n'
          'For NRI Students, pay the fee at the following link: https://msrit.edu/#bottom-sidebar',
    ),
    Notice(
      department: 'Exam Section',
      title: 'SEE Result',
      description:
          'Kindly check the result from link: https://exam.msrit.edu/\n'
          'Last Date for Copy Review & Xerox of Answer Sheet is 27th Aug 2024.\n'
          'Instructions for Copy review & Xerox of ANswer Sheet :\n'
          'Kindly deposit the cash fee along with form at Exam Section Counter.\n'
          'Fee of copy review & Xerox of Answer Sheet : 600 per paper',    
    ),
    Notice(
      department: 'Registar Academic Office',
      title: 'Academic Calender',
      description:
          'Kindly check Academic Calender of ODD Sem: https://drive.google.com/file/d/1O-0T7R7W5efjDeyfvK98j4f3eLaxYsKZ/view',     
    ),
    Notice(
      department: 'Chief Proctor Office',
      title: 'Course Registration for ODD Sem',
      description:
          'Kindly Register course with Proctor Book with in Academic Calender Timeline',     
    ),
    // Add more notices as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notice Board'),
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: NoticeSearchDelegate(notices),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView.builder(
          itemCount: notices.length,
          itemBuilder: (context, index) {
            return NoticeCard(notice: notices[index]);
          },
        ),
      ),
    );
  }
}

class NoticeSearchDelegate extends SearchDelegate<Notice> {
  final List<Notice> notices;

  NoticeSearchDelegate(this.notices);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = notices
        .where((notice) =>
            notice.title.toLowerCase().contains(query.toLowerCase()) ||
            notice.department.toLowerCase().contains(query.toLowerCase()) ||
            notice.description.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView(
      children: results.map((notice) => NoticeCard(notice: notice)).toList(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = notices
        .where((notice) =>
            notice.title.toLowerCase().contains(query.toLowerCase()) ||
            notice.department.toLowerCase().contains(query.toLowerCase()) ||
            notice.description.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView(
      children:
          suggestions.map((notice) => NoticeCard(notice: notice)).toList(),
    );
  }
}
