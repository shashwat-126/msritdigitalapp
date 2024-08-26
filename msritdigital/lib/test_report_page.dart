import 'package:flutter/material.dart';

// Entry point of the app
void main() {
  runApp(MyApp());
}

// Main application widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test &  Reports ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(), // Set MainPage as the home widget
    );
  }
}

// Main Page with Drawer
class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test & Reports'),
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
      ),
      drawer: MainDrawer(),
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
          Center(
            child: Text(
              'Welcome to the Main Page',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
        ],
      ),
    );
  }
}

// Main Drawer with options
class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Navigation',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            title: Text('Test & Reports'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TestReportPage()),
              );
            },
          ),
          // Add more drawer items here
        ],
      ),
    );
  }
}

// Test & Reports Page with Sub-Drawer
class TestReportPage extends StatefulWidget {
  @override
  _TestReportPageState createState() => _TestReportPageState();
}

class _TestReportPageState extends State<TestReportPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _goBack() {
    Navigator.pop(context); // Goes back to the previous screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test & Reports'),
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: _goBack, // Add a back button to go back to the main page
        ),
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
          _selectedIndex == 0 ? TestPage() : AttendancePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.grade),
            label: 'Test',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Attendance',
          ),
        ],
      ),
    );
  }
}

// Page displaying test details
class TestPage extends StatelessWidget {
  final List<Course> courses = [
    Course(code: 'MAC21', name: 'Numerical Techniques and Differential Equations', cie1: 30, cie2: 30, assignments: 19),
    Course(code: 'CYC22', name: 'Engineering Chemistry', cie1: 30, cie2: 30, assignments: 20),
    Course(code: 'HSCC25', name: 'Professional Writing Skills in English', cie1: 29, cie2: 30, assignments: 19),
    Course(code: 'HSCC26', name: 'Constitution of India', cie1: 29, cie2: 30, assignments: 20),
    Course(code: 'ESC231', name: 'Introduction to Civil Engineering', cie1: 30, cie2: 30, assignments: 20),
    Course(code: 'ETC246', name: 'Introduction to Cyber Security', cie1: 30, cie2: 29, assignments: 20),
    Course(code: 'AECC27', name: 'Design Thinking', cie1: 30, cie2: 30, assignments: 20),
    Course(code: 'MELC28', name: 'Computer Aided Engineering Drawing', cie1: 30, cie2: 30, assignments: 20),
    Course(code: 'CYLC29', name: 'Engineering Chemistry Laboratory', cie1: 30, cie2: 30, assignments: 20),
    Course(code: 'INT410', name: 'Mobile App Development', cie1: 30, cie2: 30, assignments: 20),
    // Add more courses
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: courses.length,
      itemBuilder: (context, index) {
        return TestCard(course: courses[index]);
      },
    );
  }
}

// Page displaying attendance details
class AttendancePage extends StatelessWidget {
  final List<Attendance> attendance = [
    Attendance(code: 'MAC21', date: '2024-08-02', status: 'Present'),
    Attendance(code: 'CYC22', date: '2024-08-02', status: 'Present'),
    Attendance(code: 'ESC231', date: '2024-08-02', status: 'Present'),
    Attendance(code: 'ETC246', date: '2024-08-02', status: 'Present'),
    Attendance(code: 'HSCC25', date: '2024-08-02', status: 'Present'),
    Attendance(code: 'HSCC26', date: '2024-08-02', status: 'Present'),
    Attendance(code: 'MELC28', date: '2024-08-02', status: 'Present'),
    Attendance(code: 'CYLC29', date: '2024-08-02', status: 'Present'),
    Attendance(code: 'INT410', date: '2024-08-02', status: 'Present'),
    // Add more attendance records
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: attendance.length,
      itemBuilder: (context, index) {
        return AttendanceCard(attendance: attendance[index]);
      },
    );
  }
}

// Data model for a course with test details
class Course {
  final String code;
  final String name;
  final int cie1;
  final int cie2;
  final int assignments;

  Course({
    required this.code,
    required this.name,
    required this.cie1,
    required this.cie2,
    required this.assignments,
  });

  double get CIE => (cie1 + cie2) / 2 + assignments;
}

// Widget that displays a course with test details in a card format
class TestCard extends StatelessWidget {
  final Course course;

  TestCard({required this.course});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              course.code,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 8.0),
            Text(
              course.name,
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('CIE1: ${course.cie1}'),
                Text('CIE2: ${course.cie2}'),
                Text('Assignments: ${course.assignments}'),
              ],
            ),
            SizedBox(height: 8.0),
            Text('Average CIE: ${course.CIE.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }
}

// Data model for attendance
class Attendance {
  final String code;
  final String date;
  final String status;

  Attendance({
    required this.code,
    required this.date,
    required this.status,
  });
}

// Widget that displays attendance in a card format
class AttendanceCard extends StatelessWidget {
  final Attendance attendance;

  AttendanceCard({required this.attendance});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              attendance.code,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 8.0),
            Text(
              'Date: ${attendance.date}',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 8.0),
            Text(
              'Status: ${attendance.status}',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
