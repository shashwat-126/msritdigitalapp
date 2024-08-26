import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Broadcast'),
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content on top of the background image
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      BroadcastCard(
                        title: 'Our Syllabus is Completed from tom u have no further cls, if u have doubt come at maths dept AB 705',
                        by: 'Dr Arun A S',
                        date: '10 July 2024',
                        url: 'https://msritdigitalapp.web.app/',
                      ),
                      BroadcastCard(
                        title: 'Our Syllabus is Completed from tom u have no further cls, if u have doubt come at chem dept ESB 401',
                        by: 'Dr M Challa',
                        date: '01 July 2024',
                        url: 'https://msritdigitalapp.web.app/',
                      ),
                      BroadcastCard(
                        title: 'Our Syllabus is Completed from tom u have no further cls, if u have doubt come at mech dept ESB 101',
                        by: 'Dr CSR',
                        date: '23 June 2024',
                        url: 'https://msritdigitalapp.web.app/',
                      ),
                      BroadcastCard(
                        title: 'Mobile App Dev Lab Test for INT410 conducted will be 13th Aug 2024 at Central Computing Facility',
                        by: 'Lab Instructor CCF',
                        date: '11 Aug 2024',
                        url: 'https://msritdigitalapp.web.app/',
                      ),
                      BroadcastCard(
                        title: 'Hybrid Web Dev Lab Test for INT410 conducted will be 13th Aug 2024 at Central Computing Facility',
                        by: 'Lab Instructor CCF',
                        date: '11 Aug 2024',
                        url: 'https://msritdigitalapp.web.app/',
                      ),
                      BroadcastCard(
                        title: 'iOS App Dev Lab Test for INT410 conducted will be 13th Aug 2024 at Central Computing Facility',
                        by: 'Lab Instructor CCF',
                        date: '11 Aug 2024',
                        url: 'https://msritdigitalapp.web.app/',
                      ),
                      BroadcastCard(
                        title: 'Data Analytics using MATLAB/Excel Lab Test for INT410 conducted will be 13th Aug 2024 at Central Computing Facility',
                        by: 'Lab Instructor CCF',
                        date: '11 Aug 2024',
                        url: 'https://msritdigitalapp.web.app/',
                      ),
                      BroadcastCard(
                        title: 'Online Project Demo Schedule at 26th Aug 2024 from 09:00 AM to 01:00 PM',
                        by: 'Skill Lab Teacher',
                        date: '20 Aug 2024',
                        url: 'https://msritdigitalapp.web.app/',
                      ),
                      BroadcastCard(
                        title: 'Due to Administrative Work, Online Project Demo Schedule at 26th Aug 2024 from 09:00 AM to 01:00 PM is Cancelled',
                        by: 'Skill Lab Teacher',
                        date: '23 Aug 2024',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BroadcastCard extends StatelessWidget {
  final String title;
  final String by;
  final String date;
  final String? url;

  BroadcastCard({
    required this.title,
    required this.by,
    required this.date,
    this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'By: $by',
              style: TextStyle(
                fontSize: 14.0,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              date.isNotEmpty ? 'Date: $date' : 'Date: Not specified',
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
            SizedBox(height: 8.0),
            if (url != null && url!.isNotEmpty) 
              GestureDetector(
                onTap: () async {
                  if (await canLaunch(url!)) {
                    await launch(url!);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Could not launch $url'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: Text(
                  'More Info',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
