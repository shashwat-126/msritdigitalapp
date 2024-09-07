mport 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MaterialApp(
    title: 'College Fee',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: FeePaymentPage(title: 'College Fee'),
  ));
}

class FeePaymentPage extends StatefulWidget {
  FeePaymentPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _FeePaymentPageState createState() => _FeePaymentPageState();
}

class _FeePaymentPageState extends State<FeePaymentPage> {
  Future<void> _launchURL() async {
    const url = 'https://erp.eshiksa.net/esh/index.php?plugin=Login&action=index&pb=bob';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2), // Semi-transparent white background
                  borderRadius: BorderRadius.circular(2.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16.0),
                    Text(
                      'College fee 2024-25',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Ensure text is visible
                      ),
                    ),
                    SizedBox(height: 32.0),
                    Text(
                      'Fee Details',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Ensure text is visible
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text('Academic Year 2024-25 College Tuition Fees', style: TextStyle(color: Colors.black)),
                    SizedBox(height: 16.0),
                    Text(
                      'Fee breakup',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Ensure text is visible
                      ),
                    ),
                    SizedBox(height: 32.0),
                    Text(
                      'Contact Us:',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Ensure text is visible
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        Icon(Icons.email, color: Colors.black),
                        SizedBox(width: 8.0),
                        Text('accounts@msrit.edu', style: TextStyle(color: Colors.black)),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        Icon(Icons.phone, color: Colors.black),
                        SizedBox(width: 8.0),
                        Text('080-23600822, 23606934, 23606936, 23603120', style: TextStyle(color: Colors.black)),
                      ],
                    ),
                    SizedBox(height: 32.0),
                    Text(
                      'Terms & Conditions:',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Ensure text is visible
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text('* Transaction charges are non-refundable for successful payments.', style: TextStyle(color: Colors.black)),
                    SizedBox(height: 8.0),
                    Text('* For any fee refund, kindly reach out to the Account Section directly.', style: TextStyle(color: Colors.black)),
                    SizedBox(height: 32.0),
                    Container(
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(2.0),
                        color: Colors.white.withOpacity(0.2), // Semi-transparent white background
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Payment Details',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black, // Ensure text is visible
                            ),
                          ),
                          SizedBox(height: 16.0),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Name of the Student',
                            ),
                          ),
                          SizedBox(height: 16.0),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'USN',
                            ),
                          ),
                          SizedBox(height: 16.0),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'MSRIT Email ID',
                            ),
                          ),
                          SizedBox(height: 16.0),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Phone',
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Row(
                            children: [
                              Text('College Fee', style: TextStyle(color: Colors.black)),
                              Spacer(),
                              Text('₹ 2,81,316.00', style: TextStyle(color: Colors.black)),
                            ],
                          ),
                          SizedBox(height: 16.0),
                          ElevatedButton(
                            onPressed: _launchURL,
                            child: Text('Pay ₹ 2,81,316.00'),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 32.0),
                    Text('You agree to share information entered on this page with M S Ramaiah Institute of Technology adhering to applicable laws.', style: TextStyle(color: Colors.black)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
