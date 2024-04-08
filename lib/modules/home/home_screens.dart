// ignore_for_file: prefer_const_constructors, use_super_parameters

import 'package:flutter/material.dart';
import 'package:login/modules/login/login_screen.dart';

class HomeScreen extends StatelessWidget {
  
 final String userName;
 final int   levelId;
 final String  branch;
 final String  personnelNumber; 
  const HomeScreen({Key? key, required this.userName, required this.levelId, required this.branch, required this.personnelNumber, }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.teal, 
        elevation: 0, 
        centerTitle: true,
        actions: [
         IconButton(
  onPressed: () {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Logout'),
          content: Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); 
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
      
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  },
  icon: Icon(Icons.logout),
),

        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 20),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.teal.withOpacity(0.1), 
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'Welcome, ${userName}!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal, 
                ),
              ),
            ),
            _buildUserInfoTile(title: 'PERSONNEL NUMBER', value: personnelNumber),
            _buildUserInfoTile(title: 'BRANCH', value: branch),
            _buildUserInfoTile(title: 'LEVEL ID', value: levelId.toString()),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfoTile({required String title, required String value}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
