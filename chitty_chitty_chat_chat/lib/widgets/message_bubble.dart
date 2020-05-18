import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final String userId;

  final Key key;

  MessageBubble(this.message, this.isMe, this.userId, {this.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: !isMe ? MainAxisAlignment.start: MainAxisAlignment.end,
      children: [
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(10),
              bottomRight: isMe ? Radius.circular(0) : Radius.circular(10)),
          color: isMe ? Colors.grey[300] : Theme.of(context).accentColor,
        ),
        width: 200,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Column(
          children: <Widget>[
            FutureBuilder(
              future: Firestore.instance.collection('users').document(userId).get(),
              builder: (context, snap) => Text(snap.data['username'], style: TextStyle(fontWeight: FontWeight.bold),)),
            Text(
              message,
              style: TextStyle(
                  fontSize: 20,
                  color: isMe
                      ? Colors.black
                      : Theme.of(context).accentTextTheme.title.color),
            ),
          ],
        ),
      ),
    ]);
  }
}
