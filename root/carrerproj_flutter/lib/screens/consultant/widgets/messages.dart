import 'package:carrerproj_client/carrerproj_client.dart';
import 'package:carrerproj_flutter/src/serverpod_client.dart';
import 'package:flutter/material.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:serverpod_auth_client/serverpod_auth_client.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

class MessagesContent extends StatefulWidget {
  const MessagesContent({Key? key}) : super(key: key);

  @override
  _MessagesContentState createState() => _MessagesContentState();
}

class _MessagesContentState extends State<MessagesContent> with SingleTickerProviderStateMixin {
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  UserInfo? _currentUser;
  List<UserProfile> _contacts = [];
  List<UserProfile> _searchResults = [];
  UserProfile? _selectedContact;
  final List<ChatMessage> _messages = [];
  Map<int, Stream<ChatMessage>> _messageStreams = {};
  bool _showEmojiPicker = false;
  bool _isSending = false;
  late AnimationController _sendAnimationController;
  late Animation<double> _bubbleAnimation;

  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
    _messageController.addListener(() => setState(() {}));
    
    _sendAnimationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _bubbleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _sendAnimationController,
        curve: Curves.easeOutBack,
      ),
    );
  }

  Future<void> _loadCurrentUser() async {
    try {
      _currentUser = await sessionManager.signedInUser;
      if (_currentUser == null) {
        print('No user logged in');
        return;
      }
      await _loadExistingConversations();
      await _subscribeToAllMessages();
      setState(() {});
    } catch (e) {
      print('Failed to load user: $e');
    }
  }

  Future<void> _loadExistingConversations() async {
    for (var userId = 0; userId <= 1000; userId++) {
      final userProfile = await client.user.getUserProfile(userId);
      if (userId == _currentUser!.id) continue;
      if (userProfile?.role == 'Consultant') continue;
      final messages = await client.chat.getDirectMessageHistory(
        _currentUser!.id!,
        userId,
      );
      if (messages.isNotEmpty && userProfile != null) {
        _addContact(userProfile);
      }
    }
  }

  Future<void> _subscribeToAllMessages() async {
    if (_currentUser == null) return;

    try {
      // Clear existing streams
      for (var stream in _messageStreams.values) {
        await stream.drain();
      }
      _messageStreams.clear();

      // Subscribe to messages for each contact
      for (var contact in _contacts) {
        final stream = await client.chat.observeDirectMessages(
          _currentUser!.id!,
          contact.userId,
        );
        
        _messageStreams[contact.userId] = stream;
        
        stream.listen((message) async {
          if (!_messages.any((m) => m.id == message.id && m.id != 0)) {
            setState(() {
              _messages.add(message);
              if (_selectedContact != null && 
                  message.senderId == _selectedContact!.userId) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ScrollController().animateTo(
                    ScrollController().position.maxScrollExtent,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                });
              }
            });
            
            final senderProfile = await client.user.getUserProfile(message.senderId);
            if (senderProfile != null) {
              _addContact(senderProfile);
            }
          }
        }, onError: (e) {
          print('Message stream error for contact ${contact.userId}: $e');
        });
      }
    } catch (e) {
      print('Failed to subscribe to messages: $e');
    }
  }

  Future<void> _searchUsers(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    final searchResults = <UserProfile>[];
    for (var userId = 0; userId <= 1000; userId++) {
      final userProfile = await client.user.getUserProfile(userId);
      if (userId == _currentUser!.id) continue;
      if (userProfile?.role == 'Conultant') continue;
      if (userProfile != null && userProfile.nickname != null) {
        if (userProfile.nickname!.toLowerCase().contains(query.toLowerCase())) {
          searchResults.add(userProfile);
        }
      }
    }

    setState(() {
      _searchResults = searchResults;
    });
  }

  void _addContact(UserProfile contact) {
    if (!_contacts.any((c) => c.userId == contact.userId)) {
      setState(() {
        _contacts.add(contact);
        // Subscribe to new contact's messages
        _subscribeToContactMessages(contact.userId);
      });
    }
  }

  Future<void> _subscribeToContactMessages(int contactId) async {
    if (_currentUser == null || _messageStreams.containsKey(contactId)) return;

    try {
      final stream = await client.chat.observeDirectMessages(
        _currentUser!.id!,
        contactId,
      );
      
      _messageStreams[contactId] = stream;
      
      stream.listen((message) async {
        if (!_messages.any((m) => m.id == message.id && m.id != 0)) {
          setState(() {
            _messages.add(message);
            if (_selectedContact != null && 
                message.senderId == _selectedContact!.userId) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScrollController().animateTo(
                  ScrollController().position.maxScrollExtent,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
              });
            }
          });
          
          final senderProfile = await client.user.getUserProfile(message.senderId);
          if (senderProfile != null) {
            _addContact(senderProfile);
          }
        }
      }, onError: (e) {
        print('Message stream error for contact $contactId: $e');
      });
    } catch (e) {
      print('Failed to subscribe to messages for contact $contactId: $e');
    }
  }

  Future<void> _loadMessages() async {
    if (_currentUser == null || _selectedContact == null) return;

    try {
      final messages = await client.chat.getDirectMessageHistory(
        _currentUser!.id!,
        _selectedContact!.userId,
      );
      setState(() {
        _messages.clear();
        _messages.addAll(messages);
      });
    } catch (e) {
      print('Failed to load messages: $e');
    }
  }

  Future<void> _sendMessage(String text) async {
    if (text.isEmpty || _currentUser == null || _selectedContact == null) return;

    final message = ChatMessage(
      id: 0,
      senderId: _currentUser!.id!,
      receiverId: _selectedContact!.userId,
      text: text,
      sentAt: DateTime.now().toUtc(),
      isRead: false,
    );

    setState(() {
      _messages.add(message);
      _isSending = true;
    });
    
    _sendAnimationController.forward();

    try {
      await client.chat.sendDirectMessage(message);
      _addContact(_selectedContact!);
      
      await Future.delayed(Duration(milliseconds: 400));
      _sendAnimationController.reset();
    } catch (e) {
      print('Failed to send message: $e');
      setState(() {
        _messages.remove(message);
      });
    } finally {
      setState(() {
        _isSending = false;
        _messageController.clear();
      });
    }
  }

  void _onEmojiSelected(Emoji emoji) {
    setState(() {
      _messageController.text = _messageController.text + emoji.emoji;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 300,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    ),
                    onChanged: _searchUsers,
                  ),
                ),
              ),
              if (_searchResults.isNotEmpty)
                Positioned(
                  top: 70,
                  left: 16,
                  right: 16,
                  child: Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _searchResults.length,
                        itemBuilder: (context, index) {
                          final user = _searchResults[index];
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.grey[300],
                              child: Icon(Icons.person, color: Colors.white),
                            ),
                            title: Text(user.nickname ?? 'Unknown'),
                            onTap: () {
                              setState(() {
                                _selectedContact = user;
                                _searchResults = [];
                                _searchController.clear();
                                _loadMessages();
                                _addContact(user);
                              });
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'PEOPLE',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: _contacts.isEmpty
                      ? Center(child: Text('No conversations yet'))
                      : ListView.builder(
                          itemCount: _contacts.length,
                          itemBuilder: (context, index) {
                            final contact = _contacts[index];
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.grey[300],
                                child: Icon(Icons.person, color: Colors.white),
                              ),
                              title: Text(contact.nickname ?? 'Unknown'),
                              subtitle: Text(''),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '',
                                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                                  ),
                                ],
                              ),
                              onTap: () {
                                setState(() {
                                  _selectedContact = contact;
                                  _loadMessages();
                                });
                              },
                              selected: _selectedContact?.userId == contact.userId,
                              selectedTileColor: Colors.grey[200],
                            );
                          },
                        ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                if (_selectedContact != null)
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          child: Icon(Icons.person, color: Colors.white),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _selectedContact!.nickname ?? 'Unknown',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Online',
                              style: TextStyle(color: Colors.grey[600], fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                Expanded(
                  child: _messages.isEmpty
                      ? Center(child: Text('No messages yet'))
                      : ListView.builder(
                          controller: ScrollController(),
                          padding: const EdgeInsets.all(16.0),
                          itemCount: _messages.length,
                          itemBuilder: (context, index) {
                            final message = _messages[index];
                            final bool isMe = message.senderId == _currentUser!.id;
                            final localTime = message.sentAt.toLocal();
                            final isLatestSent = isMe && index == _messages.length - 1 && _isSending;

                            return Align(
                              alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                              child: AnimatedBuilder(
                                animation: _bubbleAnimation,
                                builder: (context, child) {
                                  return Transform.scale(
                                    scale: isLatestSent ? _bubbleAnimation.value : 1.0,
                                    alignment: isMe ? Alignment.bottomRight : Alignment.bottomLeft,
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(vertical: 5),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: isMe ? Colors.blue : Colors.grey[200],
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            message.text,
                                            style: TextStyle(
                                              color: isMe ? Colors.white : Colors.black,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            '${localTime.hour}:${localTime.minute.toString().padLeft(2, '0')}',
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: isMe ? Colors.white70 : Colors.grey[600],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.emoji_emotions_outlined,
                                      color: _showEmojiPicker ? Colors.blue : Colors.grey[600],
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _showEmojiPicker = !_showEmojiPicker;
                                      });
                                    },
                                  ),
                                  Expanded(
                                    child: TextField(
                                      controller: _messageController,
                                      decoration: InputDecoration(
                                        hintText: 'Type your message here...',
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          AnimatedBuilder(
                            animation: _bubbleAnimation,
                            builder: (context, child) {
                              return Transform.scale(
                                scale: 1.0 + (_isSending ? _bubbleAnimation.value * 0.2 : 0),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.send,
                                    color: _messageController.text.isNotEmpty && _selectedContact != null
                                        ? Colors.blue
                                        : Colors.grey,
                                  ),
                                  onPressed: _messageController.text.isNotEmpty && _selectedContact != null && !_isSending
                                      ? () => _sendMessage(_messageController.text)
                                      : null,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (_showEmojiPicker)
                        Container(
                          height: 250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey[100],
                          ),
                          child: EmojiPicker(
                            onEmojiSelected: (category, emoji) {
                              _onEmojiSelected(emoji);
                            },
                            config: Config(
                              columns: 7,
                              emojiSizeMax: 32,
                              bgColor: Colors.transparent,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    for (var stream in _messageStreams.values) {
      stream.drain();
    }
    _messageStreams.clear();
    _messageController.dispose();
    _searchController.dispose();
    _sendAnimationController.dispose();
    super.dispose();
  }
}