import 'package:flutter/material.dart';
import 'package:flutter_gemini_bot/flutter_gemini_bot.dart';
import 'package:flutter_gemini_bot/models/chat_model.dart';

class Chatbot extends StatefulWidget {
  const Chatbot({super.key});

  @override
  State<Chatbot> createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {
  List<ChatModel> chatList = []; // Your list of ChatModel objects
  String apiKey = 'AIzaSyCu13wqeKYGQvK-SZ1wUJT-QxIMNzy8T18';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterGeminiChat(
        chatContext: 'je suis un developpeur',
        chatList: chatList,
        apiKey: apiKey,
      ),
    );
  }
}
