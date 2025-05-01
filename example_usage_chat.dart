// import 'package:flutter/material.dart';
// import 'package:chatapp_client/chatapp_client.dart';
// import 'package:serverpod_flutter/serverpod_flutter.dart';

// var client = Client('http://localhost:8080/')
//   ..connectivityMonitor = FlutterConnectivityMonitor();

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Direct Chat',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: const ChatPage(),
//     );
//   }
// }

// class ChatPage extends StatefulWidget {
//   const ChatPage({Key? key}) : super(key: key);

//   @override
//   _ChatPageState createState() => _ChatPageState();
// }

// class _ChatPageState extends State<ChatPage> {
//   final TextEditingController _messageController = TextEditingController();
//   final String _myUserId = 'user1'; // this would come from authentication
//   final String _otherUserId =
//       'user2'; // this would be selected from a contacts list
//   final List<ChatMessage> _messages = [];
//   Stream<ChatMessage>? _messageStream;

//   @override
//   void initState() {
//     super.initState();
//     _loadMessages();
//     _subscribeToMessages();
//     _markMessagesAsRead();
//   }

//   Future<void> _loadMessages() async {
//     try {
//       final messages = await client.chat.getDirectMessageHistory(
//         _myUserId,
//         _otherUserId,
//       );
//       setState(() {
//         _messages.clear();
//         _messages.addAll(messages);
//       });
//     } catch (e) {
//       print('Failed to load messages: $e');
//     }
//   }

//   Future<void> _subscribeToMessages() async {
//     try {
//       _messageStream = await client.chat.observeDirectMessages(
//         _myUserId,
//         _otherUserId,
//       );
//       _messageStream!.listen((message) {
//         setState(() {
//           _messages.add(message);
//         });
//         // Mark messages as read when received
//         if (message.receiverId == _myUserId) {
//           _markMessagesAsRead();
//         }
//       });
//     } catch (e) {
//       print('Failed to subscribe to messages: $e');
//     }
//   }

//   Future<void> _markMessagesAsRead() async {
//     try {
//       await client.chat.markMessagesAsRead(_otherUserId, _myUserId);
//     } catch (e) {
//       print('Failed to mark messages as read: $e');
//     }
//   }

//   Future<void> _sendMessage() async {
//     if (_messageController.text.isEmpty) return;

//     final message = ChatMessage(
//       id: 0, // Will be set by the database
//       senderId: _myUserId,
//       receiverId: _otherUserId,
//       message: _messageController.text,
//       sentAt: DateTime.now(),
//       isRead: false,
//     );

//     try {
//       await client.chat.sendDirectMessage(message);
//       _messageController.clear();
//     } catch (e) {
//       print('Failed to send message: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Chat with $_otherUserId')),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: _messages.length,
//               itemBuilder: (context, index) {
//                 final message = _messages[index];
//                 final bool isMe = message.senderId == _myUserId;

//                 return Align(
//                   alignment:
//                       isMe ? Alignment.centerRight : Alignment.centerLeft,
//                   child: Container(
//                     margin:
//                         const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//                     padding: const EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       color: isMe ? Colors.blue[100] : Colors.grey[200],
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(message.message),
//                         Text(
//                           '${message.sentAt.hour}:${message.sentAt.minute}',
//                           style:
//                               TextStyle(fontSize: 12, color: Colors.grey[600]),
//                         ),
//                         if (isMe)
//                           Icon(
//                             message.isRead ? Icons.done_all : Icons.done,
//                             size: 12,
//                             color: Colors.grey[600],
//                           ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _messageController,
//                     decoration: const InputDecoration(
//                       hintText: 'Type a message',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.send),
//                   onPressed: _sendMessage,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _messageController.dispose();
//     super.dispose();
//   }
// }
