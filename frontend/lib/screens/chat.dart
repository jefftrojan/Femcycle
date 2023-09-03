import 'package:flutter/material.dart';
import 'package:frontend/screens/profile.dart';
import 'package:frontend/utils/colors.dart';
import 'dart:math';
import "package:http/http.dart" as http;
import "dart:convert";

import '../utils/utils.dart';
import 'cycletrack.dart';
import 'location.dart';

class ChatAssistantScreen extends StatefulWidget {
  final User user;

  ChatAssistantScreen({required this.user});

  @override
  _ChatAssistantScreenState createState() => _ChatAssistantScreenState();
}

class _ChatAssistantScreenState extends State<ChatAssistantScreen> {
  final TextEditingController _messageController = TextEditingController();
  List<ChatMessage> _messages = [];

  @override
  void initState() {
  super.initState();
    
    _messages.add(ChatMessage(
      text: "Hello, ${widget.user.name} I am your ai assistant. You can ask me anything about   reproductive health and menstrual hygiene. What is on your mind?",
      isUser: false, 
    ));
  }

  // openai
  Future<String> sendMessageToChatGPT(String message) async {
    final apiKey = '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'; 
    final endpoint = 'https://api.openai.com/v1/engines/davinci/completions'; 

    final response = await http.post(
      Uri.parse(endpoint),
      headers: {
        
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'prompt': message,
        'max-tokens':50,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices'][0]['text'].toString();
    } else {
      throw Exception('Failed to send message to ChatGPT');
    }
  }

  void _sendMessage() async {
  String messageText = _messageController.text.trim();
  if (messageText.isNotEmpty) {
    setState(() {
      _messages.add(ChatMessage(
        text: messageText,
        isUser: true,
      ));
    });

    _messageController.clear();

    try {
      final response = await sendMessageToChatGPT(messageText);
      if (response != null && response.isNotEmpty) {
        setState(() {
          _messages.add(ChatMessage(
            text: response,
            isUser: false,
          ));
        });
      } else {
        print('Received an empty response from ChatGPT.');
      }
    } catch (e) {
      print('Error sending message: $e');
    }
  }
}

 
  // nav links list
  int _currentIndex = 0;
  final List<Widget> _screens = [
    ChatAssistantScreen(user: User(name: "", email: ""),), 
    Periods(), 
    Stores(), 
    Account(), 
  ];
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: primary,
      //   title: Text("Fem Cycle"),
      // ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 24,),ListTile(
            leading: RandomColorAvatar(
              name: widget.user.name,
              radius: 20.0,
            ),
            // title: Text("Hello, ${widget.user.name}"),
          ),

          // Chat messages
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _messages[index];
              },
            ),
          ),

          // Typing bar
          
          Container(
            
            padding: EdgeInsets.all(8.0),
            color: Colors.white,
            
            
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      
                      hintText: "Write something...",
                      
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: primaryDark),
                  onPressed: () {
                    _sendMessage();
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 20,)
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat, color: primaryDark), // Set icon color
            label: "Chat",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pin_drop, color: primaryDark), // Set icon color
            label: "Periods",
            
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_city, color: primaryDark), // Set icon color
            label: "Stores",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined, color: primaryDark), // Set icon color
            label: "Account",
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });

          // Navigate to the selected screen
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => _screens[index],
            ),
          );
        },
      ),
    );
  }

      
 
  }



class ChatMessage extends StatelessWidget {
  final String text;
  final bool isUser;

  ChatMessage({required this.text, required this.isUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: isUser ? primaryDark : Colors.grey,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class RandomColorAvatar extends StatelessWidget {
  final String name;
  final double radius;

  RandomColorAvatar({required this.name, this.radius = 24.0});

  Color _generateRandomColor() {
    final Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = _generateRandomColor();

    return CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor,
      child: Text(
        name.isNotEmpty ? name[0].toUpperCase() : '?',
        style: TextStyle(
          color: Colors.white,
          fontSize: radius * 0.8,
        ),
      ),
    );
  }
}
