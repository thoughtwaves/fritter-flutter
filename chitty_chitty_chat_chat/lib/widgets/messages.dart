import 'package:chitty_chitty_chat_chat/widgets/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseAuth.instance.currentUser(),
        builder: (ctx, futureSnap) {
          if (futureSnap.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(),
            );

          return StreamBuilder(
              stream: Firestore.instance
                  .collection('chat')
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (ctx, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  final data = snap.data.documents;
                  return ListView.builder(
                    reverse: true,
                    itemCount: data.length,
                    itemBuilder: (ctx, index) => MessageBubble(
                        data[index]['text'],
                        data[index]['user'] == futureSnap.data.uid,
                        data[index]['user'],
                        key: ValueKey(data[index].documentID)),
                  );
                }
              });
        });
  }
}
