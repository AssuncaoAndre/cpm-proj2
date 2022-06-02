import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final data;
  DetailPage(this.data);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data['name']['first']),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: CircleAvatar(
                radius: 40.0,
                backgroundColor: Colors.pink,
                backgroundImage: NetworkImage(
                    data['picture']['thumbnail']),
              ),
            ),
            Divider(
              height: 40.0,
              color: Colors.grey,
            ),
            Text(
              'NAME',
              style: TextStyle(
                  letterSpacing: 2.0
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              data['name']['title'] +" "+ data['name']['first'] + " "+ data['name']['last'],
              style: TextStyle(
                color: Colors.black,
                letterSpacing: 2.0,
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(
              height: 30.0,
              color: Colors.grey,
            ),
            Text(
              'USERNAME',
              style: TextStyle(
                  letterSpacing: 2.0
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              data['login']['username'],
              style: TextStyle(
                color: Colors.black,
                letterSpacing: 2.0,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(
              height: 30.0,
              color: Colors.grey,
            ),
            Text(
              'EMAIL',
              style: TextStyle(
                  letterSpacing: 2.0
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              data['email'],
              style: TextStyle(
                color: Colors.black,
                letterSpacing: 2.0,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(
              height: 30.0,
              color: Colors.grey,
            ),
            Text(
              'PHONE',
              style: TextStyle(
                  letterSpacing: 2.0
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              data['phone'],
              style: TextStyle(
                color: Colors.black,
                letterSpacing: 2.0,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(
              height: 30.0,
              color: Colors.grey,
            ),

          ],
        ),

      ),
    );
  }
}