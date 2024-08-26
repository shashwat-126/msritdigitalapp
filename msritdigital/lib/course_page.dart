import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CoursePage extends StatefulWidget {
  @override
  _CoursePageState createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  final Duration modificationPeriod = Duration(hours: 48);
  DateTime? registrationTime;
  Course? selectedCourse;

  bool canModifyRegistration(DateTime registrationTime) {
    final currentTime = DateTime.now();
    final expiryTime = registrationTime.add(modificationPeriod);
    return currentTime.isBefore(expiryTime);
  }

  void registerCourse(Course course) {
    setState(() {
      selectedCourse = course;
      registrationTime = DateTime.now();
    });
  }

  void modifyCourse(Course newCourse) {
    if (registrationTime != null && canModifyRegistration(registrationTime!)) {
      setState(() {
        selectedCourse = newCourse;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Modification period has expired.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Course Registration'),
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            'assets/images/bg.jpg', // Ensure this path is correct
            fit: BoxFit.cover,
          ),
          // Content over the background
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              padding: const EdgeInsets.all(2.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2), // Semi-transparent white background
                borderRadius: BorderRadius.circular(2.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Course Registration',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Ensure text is visible
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Expanded(
                    child: CourseList(
                      onRegister: registerCourse,
                      selectedCourse: selectedCourse,
                      onModify: modifyCourse,
                    ),
                  ),
                  if (selectedCourse != null)
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Selected Course: ${selectedCourse!.name}',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CourseList extends StatelessWidget {
  final List<Course> courses = [
    Course(
      code: 'MAC21',
      name: 'Numerical Techniques and Differential Equations',
      syllabusUrl: 'https://drive.google.com/file/d/1czYK9yCdULltO37G0aUHmg_mhsQ29-xT/view?usp=sharing',
    ),
    Course(
      code: 'CYC22',
      name: 'Engineering Chemistry',
      syllabusUrl: 'https://drive.google.com/file/d/1vFSNqK-b0083ttoiWg0Oi6zEody5CsbU/view?usp=sharing',
    ),
    Course(
      code: 'ESC231',
      name: 'Introduction to Civil Engineering',
      syllabusUrl: 'https://drive.google.com/file/d/1xpv7GNhML5OhbBdNlLFGAL7_ozbHEaro/view?usp=sharing',
    ),
    Course(
      code: 'ETC246',
      name: 'Introduction to Cyber Security',
      syllabusUrl: 'https://drive.google.com/file/d/1Vttu89baaXwdN4_YSUNVaDzw6dcPIac1/view?usp=sharing',
    ),
    Course(
      code: 'HSCC25',
      name: 'Professional Communication English',
      syllabusUrl: 'https://drive.google.com/file/d/1Ij36f7u1Zdk87O5pQS7-vMngrXUHQTrP/view?usp=sharing',
    ),
    Course(
      code: 'HSCC26',
      name: 'Constitution of India',
      syllabusUrl: 'https://drive.google.com/file/d/1Chd4OQtHdaG-TfMpd71GRpjAsMxdD34a/view?usp=sharing',
    ),
    Course(
      code: 'AECC27',
      name: 'Design Thinking',
      syllabusUrl: 'https://drive.google.com/file/d/16DCfoifUNAuK-KkHCIsvHVxONK7uoAaN/view?usp=sharing',
    ),
    Course(
      code: 'MELC28',
      name: 'Computer Aided Engineering Laboratory',
      syllabusUrl: 'https://drive.google.com/file/d/1138vNBDJ9hAnSiKEk-IzCIG01dT2wGxX/view?usp=sharing',
    ),
    Course(
      code: 'CYLC29',
      name: 'Engineering Chemistry Laboratory',
      syllabusUrl: 'https://drive.google.com/file/d/1Kt9EZ6c5N-LsXDFHVJ03Jd0NMVrcgQC-/view?usp=sharing',
    ),
    Course(
      code: 'INT410',
      name: 'Mobile App Development',
      syllabusUrl: 'https://cloud.appwrite.io/v1/storage/buckets/64a0267043e02697af92/files/65a7674132e989163d8f/view?project=649ad3d1ba7f29cdf21e',
    ),
    // Add more courses with corresponding URLs
  ];

  final Function(Course) onRegister;
  final Course? selectedCourse;
  final Function(Course) onModify;

  CourseList({
    required this.onRegister,
    required this.selectedCourse,
    required this.onModify,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: courses.length,
      itemBuilder: (context, index) {
        return CourseCard(
          course: courses[index],
          onRegister: onRegister,
          selectedCourse: selectedCourse,
          onModify: onModify,
        );
      },
    );
  }
}

class Course {
  final String code;
  final String name;
  final String syllabusUrl;

  Course({
    required this.code,
    required this.name,
    required this.syllabusUrl,
  });
}

class CourseCard extends StatelessWidget {
  final Course course;
  final Function(Course) onRegister;
  final Course? selectedCourse;
  final Function(Course) onModify;

  CourseCard({
    required this.course,
    required this.onRegister,
    required this.selectedCourse,
    required this.onModify,
  });

  void _launchURL(BuildContext context) async {
    final url = course.syllabusUrl;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $url')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedCourse != null && selectedCourse!.code == course.code;
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
            ElevatedButton(
              onPressed: () {
                if (isSelected) {
                  // Modify course if already selected
                  onModify(course);
                } else {
                  // Register new course
                  onRegister(course);
                }
              },
              child: Text(isSelected ? 'Modify Selection' : 'Register'),
            ),
            SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: () => _launchURL(context),
              child: Text('Open Syllabus'),
            ),
          ],
        ),
      ),
    );
  }
}
