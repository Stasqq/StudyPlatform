part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  ChatState({
    required this.courseId,
    required this.userEmail,
    required this.userName,
    required this.currentMessageText,
  });

  late String courseId;
  late String userName;
  late String userEmail;
  late String currentMessageText;

  @override
  List<Object> get props => [];
}

class ChatStateLoading extends ChatState {
  ChatStateLoading()
      : super(
          courseId: '',
          userEmail: '',
          userName: '',
          currentMessageText: '',
        );
}

class ChatStateEmpty extends ChatStateLoadSuccess {
  ChatStateEmpty({
    required String courseId,
    required String userEmail,
    required String userName,
  }) : super(
          messages: [],
          hasMoreData: false,
          courseId: courseId,
          userEmail: userEmail,
          userName: userName,
          currentMessageText: '',
        );
}

class ChatStateLoadSuccess extends ChatState {
  final List<Message> messages;
  final bool hasMoreData;

  ChatStateLoadSuccess({
    required String userName,
    required String userEmail,
    required String courseId,
    required String currentMessageText,
    required this.messages,
    required this.hasMoreData,
  }) : super(
          userName: userName,
          userEmail: userEmail,
          courseId: courseId,
          currentMessageText: currentMessageText,
        );

  ChatStateLoadSuccess copyWith({
    List<Message>? messages,
    bool? hasMoreData,
    String? courseId,
    String? userName,
    String? userEmail,
    String? currentMessageText,
  }) {
    return ChatStateLoadSuccess(
      messages: messages ?? this.messages,
      hasMoreData: hasMoreData ?? this.hasMoreData,
      courseId: courseId ?? this.courseId,
      userName: userName ?? this.userName,
      userEmail: userEmail ?? this.userEmail,
      currentMessageText: currentMessageText ?? this.currentMessageText,
    );
  }

  @override
  List<Object> get props => [
        messages,
        hasMoreData,
        courseId,
        userEmail,
        userName,
        currentMessageText
      ];
}
