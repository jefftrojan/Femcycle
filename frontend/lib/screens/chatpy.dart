import 'dart:convert';
import 'dart:io';
import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/screens/cycletrack.dart';
import 'package:frontend/screens/location.dart';
import 'package:frontend/screens/profile.dart';
import 'package:frontend/utils/colors.dart';
import 'package:frontend/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    // welcome message goes here

    msgs.insert(0,Message(false, "Hello there, Welcome back! I am your AI assistant. You can ask me anything about menstrual hygiene and reproductive health."));

    loadEnvironmentVariables();
  }

  String apiKey = "";

  

  Future<void> loadEnvironmentVariables() async {
    await dotenv.load(fileName: ".env");
    setState(() {
      apiKey = dotenv.env['OPENAI_API_KEY'] ?? "";
    });
  }

  TextEditingController controller = TextEditingController();
  ScrollController scrollController = ScrollController();
  List<Message> msgs = [];
  bool isTyping = false;

  void sendMsg() async {
    String text = controller.text;
    // String apiKey = apiKey;

    controller.clear();
    try {
      if (text.isNotEmpty) {
        setState(() {
          msgs.insert(0, Message(true, text));
          isTyping = true;
        });
        scrollController.animateTo(0.0,
            duration: const Duration(seconds: 1), curve: Curves.easeOut);
        var response = await http.post(
            Uri.parse("https://api.openai.com/v1/chat/completions"),
            headers: {
              "Authorization": "Bearer $apiKey",
              "Content-Type": "application/json"
            },
            body: jsonEncode({
              "model": "gpt-3.5-turbo",
              "messages": [
                {"role": "user", "content": text}
              ]
            }));
        if (response.statusCode == 200) {
          var json = jsonDecode(response.body);
          setState(() {
            isTyping = false;
            msgs.insert(
                0,
                Message(
                    false,
                    json["choices"][0]["message"]["content"]
                        .toString()
                        .trimLeft()));
          });
          scrollController.animateTo(0.0,
              duration: const Duration(seconds: 1), curve: Curves.easeOut);
        }
      }
    } on Exception {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Some error occurred, please try again!")));
    }
  }

    


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
      elevation: 0, 
       backgroundColor: Colors.white,
       leading: Padding(
         padding: const EdgeInsets.all(8.0),
         child: CircleAvatar(
          
          backgroundImage: AssetImage("lib/assets/girlsclock.jpg"),
          radius: 50, 
          
          
             ),
       ),
      ),
      body: Column(
        children: [
         
          
          // Visibility(child: BubbleNormal(
          // text: "Hello there,\nWelcome back. I am your ai assistant. You can ask me anything about menstrual hygiene and reproductive health,",
          // textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w100),
          // isSender: false,
          // color: primarylight,
          // ),
          
         
          // ),
          Expanded(
            child: ListView.builder(
              
                controller: scrollController,
                itemCount: msgs.length,
                shrinkWrap: true,
                reverse: true,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: isTyping && index == 0
                          ? Column(
                              children: [
                                
                                BubbleNormal(
                                  text: msgs[0].msg,
                                  isSender: true,
                                  color: Colors.blue.shade100,
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left: 16, top: 4),
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text("Typing...")),
                                )
                              ],
                            )
                          : BubbleNormal(
                              text: msgs[index].msg,
                              textStyle: TextStyle(color: Colors.white),
                              isSender: msgs[index].isSender,
                              color: msgs[index].isSender
                                  ? accentchatalt
                                  : common,
                ));
                }),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                        color: primarylight,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      
                      child: TextField(
                        
                        controller: controller,
                        textCapitalization: TextCapitalization.sentences,
                        onSubmitted: (value) {
                          sendMsg();
                        },
                        
                        textInputAction: TextInputAction.send,
                        showCursor: true,
                        
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: primarylight,
                          
                            border: InputBorder.none, hintText: "Ask something..."),
                            
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  sendMsg();
                },
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: common,
                      borderRadius: BorderRadius.circular(30)),
                  child: const Icon(
                    Icons.chat,
                    color: Color.fromARGB(167, 255, 255, 255),
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
                height: 10,
              )

            ],
          ),
          SizedBox(height: 20,)
        ],
      ),
      

      // implement bottom navigation
     
    
    );
  }
}


// message class
class Message {
  bool isSender;
  String msg;
  Message(this.isSender, this.msg);
}


