import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_platform/logic/cubit/other_user_info_cubit/other_user_info_cubit.dart';
import 'package:study_platform/presentation/screens/profile_screen.dart';

class MessageBubble extends StatelessWidget {
  final String senderEmail;
  final String senderName;
  final String text;
  final bool isMe;

  const MessageBubble(
      {Key? key,
      required this.senderEmail,
      required this.senderName,
      required this.text,
      required this.isMe})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: senderName,
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.black54,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      context
                          .read<OtherUserInfoCubit>()
                          .loadOtherUserInfo(senderEmail);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ProfileScreen(
                            currentUser: false,
                          ),
                        ),
                      );
                    },
                ),
              ],
            ),
          ),
          Material(
            borderRadius: isMe
                ? const BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  )
                : const BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  ),
            elevation: 5.0,
            color: isMe ? Colors.lightBlueAccent : Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 20.0,
              ),
              child: Text(
                text,
                style: TextStyle(
                  color: isMe ? Colors.white : Colors.black54,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
