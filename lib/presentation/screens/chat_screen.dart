import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:study_platform/constants/styles.dart';
import 'package:study_platform/logic/bloc/chat_bloc/chat_bloc.dart';
import 'package:study_platform/logic/bloc/courses_bloc/courses_bloc.dart';
import 'package:study_platform/logic/cubit/user_info_cubit/user_info_cubit.dart';
import 'package:study_platform/presentation/widgets/message_bubble.dart';
import 'package:study_platform/presentation/widgets/study_platform_scaffold.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController messageTextController = TextEditingController();

  @override
  void initState() {
    context.read<ChatBloc>().add(ChatEventStart(
        courseId: (context.read<CoursesBloc>().state as CoursesStateLoadSuccess)
            .currentCourse
            .id,
        userName: context.read<UserInfoCubit>().state.firstName.value +
            ' ' +
            context.read<UserInfoCubit>().state.surname.value));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StudyPlatformScaffold(
      title: (context.read<CoursesBloc>().state as CoursesStateLoadSuccess)
              .currentCourse
              .name +
          ' Chat',
      child: Center(
        child: BlocBuilder<ChatBloc, ChatState>(
          builder: (context, state) {
            if (state is ChatStateLoading) {
              return CircularProgressIndicator();
            } else if (state is ChatStateLoadSuccess) {
              return Column(
                children: [
                  Expanded(
                    flex: 9,
                    child: ListView.separated(
                      reverse: true,
                      padding: EdgeInsets.all(8),
                      itemCount: state.hasMoreData
                          ? state.messages.length + 1
                          : state.messages.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (index >= state.messages.length) {
                          context.read<ChatBloc>().add(ChatEventFetchMore());
                          return Container(
                            margin: EdgeInsets.only(top: 15),
                            height: 30,
                            width: 30,
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
                        return MessageBubble(
                            sender: state.messages[index].senderName,
                            text: state.messages[index].text,
                            isMe: state.messages[index].senderName == state.userName);
                      },
                      separatorBuilder: (context, i) {
                        return SizedBox(
                          height: 1,
                        );
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: kMessageContainerDecoration,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              maxLines: null,
                              controller: messageTextController,
                              onChanged: (value) => context
                                  .read<ChatBloc>()
                                  .add(MessageTextChangedEvent(value)),
                              decoration: kMessageTextFieldDecoration,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              context.read<ChatBloc>().add(ChatMessageSentEvent());
                              messageTextController.clear();
                            },
                            child: const Text(
                              'Send',
                              style: kSendButtonTextStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Text('Error');
            }
          },
        ),
      ),
    );
  }
}
