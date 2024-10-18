import 'package:aiserve/Models/chat_message_model.dart';
import 'package:aiserve/bloc/chat_bloc_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/services.dart';

//import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ChatBlocBloc chatBlocBloc = ChatBlocBloc();
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ChatBlocBloc, ChatBlocState>(
        bloc: chatBlocBloc,
        listener: (context, state) {   
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case ChatSuccessState:
            List<ChatMessageModel> messages = (state as ChatSuccessState).messages;
            return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 100,
                  
                  padding:
                      const EdgeInsets.only(top: 30,left: 16),
                      //color:  const Color.fromARGB(255, 29, 29, 29),
                  child:  Row(
                    children: [
                      Container(
                        height: 35,
                        width: 35,
                        child: const Image(image: AssetImage('assets/ai2.png',
                        
                         )),
                      ),
                    ],
                  ),
                ),
                Expanded(child: ListView.builder(
                  itemCount: messages.length,
                  itemBuilder:(context, index) {
                  return Container(
                    margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.grey.shade800
                    
                    ),
                    
                    child: 

                    Column(
                      
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                     
                      Text(messages[index].role == 'user' ? 'User':'Ai    ',
                      
                    
                        style: TextStyle(
                          fontSize: 14,
                          color: messages[index].role == 'user' ? Colors.greenAccent.shade200 : Colors.blue
                        ),
                        ),
                      //  SizedBox(width: 275,),
                      //   IconButton(
                      //         onPressed: (){
                      //         Clipboard.setData(ClipboardData(text: messages[index].parts.first.text));
                      //         //Tooltip(message: 'copy',);
                      //        AlignmentDirectional.topEnd;
                      //       },
                      //       highlightColor: Colors.cyan,
                      //       icon: 
                      //       const Icon (
                      //        size: 15,
                      //        Icons.content_copy,
                      //        color: Color.fromARGB(255, 180, 180, 180), 
                             
                      //   ),)], ),
                        const SizedBox(
                          height: 12,
                        ),
                        //TextSelectionTheme(data: TextSelectionThemeData(selectionColor: Colors.lightBlueAccent, selectionHandleColor: Colors.lightBlueAccent),  child: 
                        
                         SelectableText(messages[index].parts.first.text,
                         
                         
                        
                        // toolbarOptions: const ToolbarOptions( 
                        // copy: true,
                       //  selectAll: true,
                       //  paste: true,
                         
                        //),
                    // cursorColor: Colors.lightBlueAccent,
                     
                     //scrollPhysics: ClampingScrollPhysics(),
                    //onSelectionChanged: (selection, cause) {
                        
                  //  },
                        ),
                   // ) 
                     ],
                    ));
                },) 
                 
                ),
                 if(chatBlocBloc.generating)
                 Row(
                   children: [
                     SizedBox(
                      height: 50,
                      width: 50,
                      child:
                      Lottie.asset('assets/loader.json') , ),
                     // const SizedBox (width: 20),
                     const Text('...', 
                      style: TextStyle(
                        fontWeight: FontWeight.w100, fontSize: 16,
                      ),
                      )
                      
                      
                   ],
                 ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
                     // color:  const Color.fromARGB(255, 29, 29, 29),
                  child: Row(
                    children: [
                      Expanded(
                          child: TextField(
                            controller: textEditingController,
                        style: const TextStyle(color: Color.fromARGB(255, 85, 85, 85)),
                        cursorColor: Theme.of(context).primaryColor,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            fillColor:const Color.fromARGB(255, 231, 231, 231),
                            hintText: 'Write something',
                            hintStyle:
                           const TextStyle(color: Color.fromARGB(255, 209, 209, 209)),
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor))),
                      )),
                      const SizedBox(width: 12),
                      InkWell(
                        onTap: (){
                          if (textEditingController.text.isNotEmpty) {
                            String text =textEditingController.text;
                            textEditingController.clear();
                            chatBlocBloc.add(ChatGenerateNewTextMessageEvent(inputMessage: text));
                          }
                        },
                        child: CircleAvatar(
                          radius: 31,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Theme.of(context).primaryColor,
                              child: const Center(
                                child: Icon(Icons.send, color: Colors.white),
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
              
              
            default:
            return SizedBox();
          }
        },
      ),
    );
  }
}
