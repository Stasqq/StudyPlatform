part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class ChatEventStart extends ChatEvent {
  const ChatEventStart(
      {required this.courseId,
      required this.userEmail,
      required this.userName});

  final String courseId;
  final String userEmail;
  final String userName;

  @override
  List<Object> get props => [courseId, userEmail, userName];
}

class ChatEventLoad extends ChatEvent {
  final List<List<Message>> messages;

  const ChatEventLoad(this.messages);

  @override
  List<Object> get props => [messages];
}

class ChatEventFetchMore extends ChatEvent {}

class MessageTextChangedEvent extends ChatEvent {
  final String messageText;

  MessageTextChangedEvent(this.messageText);
}

class ChatMessageSentEvent extends ChatEvent {}
