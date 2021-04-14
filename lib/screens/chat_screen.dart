import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:letschat/widgets/chats/messages.dart';
import 'package:letschat/widgets/chats/new_message.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Let\'s Chat"),
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton(
              items: [
                DropdownMenuItem(
                  child: Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.exit_to_app,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text('Logout'),
                      ],
                    ),
                  ),
                  value: 'logout',
                )
              ],
              onChanged: (itemIdentifer) {
                if (itemIdentifer == 'logout') {
                  FirebaseAuth.instance.signOut();
                }
              },
              icon: Icon(Icons.more_vert),
              dropdownColor: Theme.of(context).primaryIconTheme.color,
            ),
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Messages(),
            ),
            NewMessage(),
          ],
        ),
      ),
    );
  }
}
