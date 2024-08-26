import 'package:flutter/material.dart';
import 'profile_page.dart'; // Import ProfilePage
import 'course_page.dart';
import 'digital_material_page.dart';
import 'recorder_content_page.dart';
import 'doubt_solutions_page.dart';
import 'test_report_page.dart';
import 'fee_payment_page.dart';
import 'notice_board_page.dart';
import 'support_page.dart';
import 'logout_page.dart';
import 'feedback_page.dart';

class HomePage extends StatelessWidget {
  final String userId; // Accept the user ID

  HomePage({required this.userId}); // Constructor to receive the user ID

  @override
  Widget build(BuildContext context) {
    // Sample schedule data
    final List<ClassSchedule> _schedule = [
      // Define your class schedules here
      ClassSchedule(day: 'Monday', time: '10:00 AM - 11:00 AM', subject: 'MAC21', teacher: 'Dr. Arun A S'),
      ClassSchedule(day: 'Monday', time: '11:00 AM - 12:00 PM', subject: 'CYC22', teacher: 'Dr. M Challa'),
      ClassSchedule(day: 'Tuesday', time: '10:00 AM - 11:00 AM', subject: 'ESC231', teacher: 'Dr. Santosh D'),
      ClassSchedule(day: 'Tuesday', time: '11:00 AM - 12:00 PM', subject: 'ETC246', teacher: 'Dr. RPP'),
      ClassSchedule(day: 'Wednesday', time: '10:00 AM - 11:00 AM', subject: 'AECC27', teacher: 'Dr. Nandini S A'),
      ClassSchedule(day: 'Wednesday', time: '11:00 AM - 12:00 PM', subject: 'HSCC25', teacher: 'Dr. Kavya'),
      ClassSchedule(day: 'Thursday', time: '10:00 AM - 11:00 AM', subject: 'HSCC26', teacher: 'Dr. Nimmy V S'),
      ClassSchedule(day: 'Thursday', time: '11:00 AM - 12:00 PM', subject: 'MELC28', teacher: 'Dr. CSR'),
      ClassSchedule(day: 'Friday', time: '10:00 AM - 11:00 AM', subject: 'MAC21', teacher: 'Dr. Arun A S'),
      ClassSchedule(day: 'Friday', time: '11:00 AM - 12:00 PM', subject: 'CYLC29', teacher: 'Dr. Shashank'),
      ClassSchedule(day: 'Saturday', time: '10:00 AM - 11:00 AM', subject: 'INT410', teacher: 'Dr. Vishwchetan'),
      ClassSchedule(day: 'Saturday', time: '11:00 AM - 12:00 PM', subject: 'MAC21', teacher: 'Dr. Arun A  S'),
      // Add more schedules as needed
    ];

    // Group schedules by day of the week
    final Map<String, List<ClassSchedule>> groupedSchedules = {};
    for (var schedule in _schedule) {
      if (groupedSchedules.containsKey(schedule.day)) {
        groupedSchedules[schedule.day]!.add(schedule);
      } else {
        groupedSchedules[schedule.day] = [schedule];
      }
    }

    final List<String> daysOfWeek = [
      'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Weekly Schedule', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.blueAccent,
      ),
      drawer: AppDrawer(userId: userId), // Pass the user ID to the drawer
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            'assets/images/bg.jpg', // Ensure this path is correct
            fit: BoxFit.cover, // Cover the entire screen
          ),
          // Content over the background
          ListView.builder(
            itemCount: daysOfWeek.length,
            itemBuilder: (context, index) {
              final day = daysOfWeek[index];
              final schedules = groupedSchedules[day] ?? [];

              return ExpansionTile(
                title: Text(day, style: TextStyle(color: Colors.black)),
                children: schedules.map((schedule) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16.0),
                      title: Text('${schedule.subject}', style: TextStyle(color: Colors.black)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Time: ${schedule.time}', style: TextStyle(color: Colors.black)),
                          Text('Teacher: ${schedule.teacher}', style: TextStyle(color: Colors.black)),
                        ],
                      ),
                      leading: CircleAvatar(
                        child: Text((schedules.indexOf(schedule) + 1).toString()),
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ClassSchedule {
  final String day;
  final String time;
  final String subject;
  final String teacher;

  ClassSchedule({
    required this.day,
    required this.time,
    required this.subject,
    required this.teacher,
  });
}

class AppDrawer extends StatelessWidget {
  final String userId; // Accept the user ID

  AppDrawer({required this.userId}); // Constructor to receive the user ID

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            'assets/images/bg.jpg', // Ensure this path is correct
            fit: BoxFit.cover, // Cover the entire screen
          ),
          // Drawer content over the background
          ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text('Demo', style: TextStyle(color: Colors.black)),
                accountEmail: Text(userId, style: TextStyle(color: Colors.black)), // Set email to userId
                currentAccountPicture: CircleAvatar(
                  child: Text(userId.isNotEmpty ? userId[0].toUpperCase() : 'DE', // Display first letter of userId
                      style: TextStyle(color: Colors.black)),
                ),
                decoration: BoxDecoration(
                  color: Colors.blueAccent, // Background color for the header
                ),
              ),
              ListTile(
                leading: Icon(Icons.school, color: Colors.black),
                title: Text('Course', style: TextStyle(color: Colors.black)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CoursePage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.menu_book, color: Colors.black),
                title: Text('Digital Material', style: TextStyle(color: Colors.black)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DigitalMaterialPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.video_library, color: Colors.black),
                title: Text('Recorder Content', style: TextStyle(color: Colors.black)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RecorderContentPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.question_answer, color: Colors.black),
                title: Text('Doubt & Solutions', style: TextStyle(color: Colors.black)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DoubtAndSolutionsPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.assignment, color: Colors.black),
                title: Text('Test & Reports', style: TextStyle(color: Colors.black)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TestReportPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.payments_outlined, color: Colors.black),
                title: Text('Fee Payment', style: TextStyle(color: Colors.black)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FeePaymentPage(title: 'College Fee')),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.forum, color: Colors.black),
                title: Text('Notice Board', style: TextStyle(color: Colors.black)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NoticeBoardPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.message, color: Colors.black),
                title: Text('Broadcast Message', style: TextStyle(color: Colors.black)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FeedbackPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.headset_mic, color: Colors.black),
                title: Text('Support', style: TextStyle(color: Colors.black)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SupportPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.person, color: Colors.black),
                title: Text('Profile', style: TextStyle(color: Colors.black)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(userId: userId), // Pass the user ID to ProfilePage
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.logout, color: Colors.black),
                title: Text('Logout', style: TextStyle(color: Colors.black)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LogoutPage()),
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
