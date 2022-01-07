import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:study_platform/data/models/course/message.dart';
import 'package:study_platform/data/repositories/chat_repository.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc({required ChatRepository chatRepository})
      : _chatRepository = chatRepository,
        super(ChatStateLoading()) {
    on<ChatEventStart>(_onStartEvent);
    on<ChatEventLoad>(_onLoadEvent);
    on<ChatEventFetchMore>(_onFetchMore);
    on<ChatMessageSentEvent>(_onChatMessageSent);
    on<MessageTextChangedEvent>(_onMessageTextChanged);
  }

  final ChatRepository _chatRepository;
  List<StreamSubscription> subscriptions = [];
  List<List<Message>> messages = [];
  bool hasMoreData = true;
  DocumentSnapshot? lastDoc;

  void _onStartEvent(
    ChatEventStart event,
    Emitter<ChatState> emit,
  ) {
    state.courseId = event.courseId;
    state.userName = event.userName;

    hasMoreData = true;
    lastDoc = null;
    subscriptions.forEach((subscription) {
      subscription.cancel();
    });
    messages.clear();
    subscriptions.clear();

    subscriptions.add(
      _chatRepository.getChatMessages(courseId: event.courseId).listen(
        (snapshot) {
          _handleStreamEvent(0, snapshot);
        },
      ),
    );
    emit(ChatStateEmpty(
        courseId: event.courseId,
        userEmail: event.userEmail,
        userName: event.userName));
  }

  void _onLoadEvent(
    ChatEventLoad event,
    Emitter<ChatState> emit,
  ) {
    final elements = messages.expand((i) => i).toList();

    if (elements.isEmpty) {
      emit(ChatStateEmpty(
          userName: state.userName,
          userEmail: state.userEmail,
          courseId: state.courseId));
    } else {
      emit(ChatStateLoadSuccess(
        messages: elements,
        hasMoreData: hasMoreData,
        userName: state.userName,
        userEmail: state.userEmail,
        courseId: state.courseId,
        currentMessageText: state.currentMessageText,
      ));
    }
  }

  void _onFetchMore(
    ChatEventFetchMore event,
    Emitter<ChatState> emit,
  ) {
    if (lastDoc == null) {
      throw Exception('Last doc is not set');
    }
    final index = messages.length;
    subscriptions.add(_chatRepository
        .getMessagesPage(lastDoc: lastDoc!, courseId: state.courseId)
        .listen((event) {
      _handleStreamEvent(index, event);
    }));
  }

  Future<void> _onChatMessageSent(
    ChatMessageSentEvent event,
    Emitter<ChatState> emit,
  ) async {
    Message message = Message(state.currentMessageText, state.userEmail,
        state.userName, DateTime.now().millisecondsSinceEpoch);
    await _chatRepository.sentNewMessage(
        courseId: state.courseId, message: message);
  }

  void _onMessageTextChanged(
    MessageTextChangedEvent event,
    Emitter<ChatState> emit,
  ) async {
    emit((state as ChatStateLoadSuccess).copyWith(
      currentMessageText: event.messageText,
    ));
  }

  void _handleStreamEvent(int index, QuerySnapshot snapshot) {
    hasMoreData = snapshot.docs.length < 40 ? false : true;

    if (snapshot.docs.isEmpty) return;

    if (index == messages.length) {
      lastDoc = snapshot.docs[snapshot.docs.length - 1];
    }

    List<Message> newList = [];
    snapshot.docs.reversed.forEach((doc) {
      newList.add(Message.fromJson(doc.data() as Map<String, dynamic>));
    });

    if (messages.length <= index) {
      messages.add(newList);
    } else {
      messages[index].clear();
      messages[index] = newList;
    }
    add(ChatEventLoad(messages));
  }

  @override
  Future<void> close() async {
    subscriptions.forEach((subscription) {
      subscription.cancel();
    });
    super.close();
  }

  @override
  void onChange(Change<ChatState> change) {
    print(change);
    super.onChange(change);
  }
}
