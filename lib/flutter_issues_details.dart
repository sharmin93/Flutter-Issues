import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'issues.dart';

class issueDetails extends StatelessWidget{
  var textStyle = TextStyle(
      fontSize: 18,
      color: Color(0xff371D32),
      fontFamily: 'SFProDisplayRegular',
      fontWeight: FontWeight.normal);
  @override
  Widget build(BuildContext context) {
    final Issue issue = ModalRoute.of(context).settings.arguments;
  return Scaffold(
      appBar: AppBar(title: Text("issue Details"),centerTitle: true,),
    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Padding(
            padding: const EdgeInsets.only(left: 8,top: 10,bottom: 15),
            child: Text('${issue.title} #${issue.number}',style: textStyle,),
          ),
          Row(children: [
            Container(
              height: 40,
              width: MediaQuery.of(context).size.width*.25,
              decoration: BoxDecoration(color: Colors.green,borderRadius: BorderRadius.circular(18.0),shape: BoxShape.rectangle),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.arrow_drop_down_circle,color: Colors.white,),
                    SizedBox(width: 6,),
                    Text(
                      issue.state,
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontFamily: 'SF Pro Display',
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.4),
                    ),

                  ],
                ),
              ),
            ),
            SizedBox(width: 10,),
            Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [ issue.user!=null &&issue.user.login!=null?Text('${issue.user.login}'):Container(),
              SizedBox(width: 8,),
              Text('opened this issue ${DateFormat('hh:00').format(issue.createdAt)}\'s ago.'),
              SizedBox(width: 8,),
              Text('${issue.comments} comments'),],)


          ],),
            SizedBox(height: 15,),
            Text(issue.body)
        ],),
      ),
    ),

  );
  }

}
