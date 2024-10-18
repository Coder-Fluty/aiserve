import 'dart:async';

import 'package:aiserve/Depository/chat_depo.dart';
import 'package:aiserve/Models/chat_message_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'chat_bloc_event.dart';
part 'chat_bloc_state.dart';

class ChatBlocBloc extends Bloc<ChatBlocEvent, ChatBlocState> {
  ChatBlocBloc() : super(ChatSuccessState(messages: [])) {
    on<ChatGenerateNewTextMessageEvent>(chatGenerateNewTextMessageEvent);
  }

  List<ChatMessageModel> messages =[];
  bool generating = false;

  FutureOr<void> chatGenerateNewTextMessageEvent(
    ChatGenerateNewTextMessageEvent event, Emitter<ChatBlocState> emit) async {
      messages.add(ChatMessageModel(role: 'user', parts:[
        ChatPartModel(text: event.inputMessage)]));
  emit(ChatSuccessState(messages: messages));
  generating = true;
  String generatedText = await ChatDepo.chatTextGenerationDepo(messages);
  if(generatedText.length>0) {
    messages.add(ChatMessageModel(role: 'model', parts:[
      ChatPartModel(text: generatedText)
    ]));
    emit(ChatSuccessState(messages: messages));
    
  }
  generating = false;
  }
}
