import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import './message_babble.dart';

class MessageStream extends StatelessWidget {
  final Stream<QuerySnapshot> streamSnapshot;
  final String? currentUserName;

  MessageStream({required this.currentUserName, required this.streamSnapshot});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: streamSnapshot,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: null,
            );
          }
          final messages = snapshot.data!.docs;
          List<MessageBabble> messageWidgets = [];
          for (var message in messages) {
            final messageText = message['text'];
            final messageSender = message['sender'];
            final currentUser = currentUserName;
            final messageWidget = MessageBabble(
              text: messageText,
              sender: messageSender,
              isMe: currentUser == messageSender,
            );
            messageWidgets.add(messageWidget);
          }
          return Expanded(
            child: ListView(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
              children: messageWidgets,
            ),
          );
        });
  }
}
