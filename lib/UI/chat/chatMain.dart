import 'dart:isolate';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hirelane/CONSTANTS/app_style.dart';
import 'package:hirelane/CONSTANTS/circularImageContainer.dart';
import 'package:hirelane/CONSTANTS/heading_widget.dart';
import 'package:hirelane/CONSTANTS/height_spacer.dart';
import 'package:hirelane/CONSTANTS/reusable_text.dart';
import 'package:hirelane/CONSTANTS/width_spacer.dart';
import 'package:hirelane/UI/home/home_page.dart';
import 'package:hirelane/UI/profile/profile.dart';
import 'package:hirelane/UI/recruiterPages/recruiterHome.dart';
import 'package:hirelane/UI/recruiterPages/recruiterJobs.dart';
import 'package:hirelane/UI/recruiterPages/recruiterProfile.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Chatmain extends StatefulWidget {
  const Chatmain({super.key, this.recipientId , this.recipientName});
  
  final String? recipientId;
  final String? recipientName;

  @override
  State<Chatmain> createState() => _ChatmainState();
}

class _ChatmainState extends State<Chatmain> {

  @override
  void initState(){
    super.initState();
    getPreferences();
  }

  bool? isAgent;

  void getPreferences() async  {
    final prefs = await SharedPreferences.getInstance();
    bool userAgentStatus = prefs.getBool("isAgent")!;
    setState(() {
      isAgent = userAgentStatus;
    });
  }

  String getChatId(String userA , String userB){
    if( userA != userB){
      if(userA.hashCode <= userB.hashCode){
        return "${userA}_$userB";
      }else{
        return "${userB}_$userA";
      }
    }else{
      return "Self chat not allowed";
    }
  }

  void sendMessage(String text, String recipientId) async {
    final prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('firebase_id')!;
    final chatId = getChatId(userId, recipientId);

    await FirebaseFirestore.instance
        .collection('chats')
        .doc(chatId) // uniquely identifies the conversation
        .collection('messages')
        .add({
          'text': text,
          'senderId': userId,
          'recipientId': recipientId,
          'createdAt': FieldValue.serverTimestamp(),
          'isRead': false,
        });

    // Optionally: store/update chat metadata (for showing last message in chat list)
    await FirebaseFirestore.instance.collection('chats').doc(chatId).set({
      'lastMessage': text,
      'lastSender': userId,
      'lastUpdated': FieldValue.serverTimestamp(),
      'participants': [userId, recipientId],
    }, SetOptions(merge: true));
  }

  Stream<QuerySnapshot> getContacts() {
    // This assumes SharedPreferences is already initialized and firebase_id is set.
    // If you need to fetch userId asynchronously, consider using FutureBuilder instead.
    // For now, let's use a synchronous getter for demonstration.
    // You may want to refactor this for production code.
    return Stream<QuerySnapshot>.multi((controller) async {
      final prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString('firebase_id');
      if (userId != null) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('contacts')
            .orderBy('lastContacted', descending: true)
            .snapshots()
            .listen((snapshot) {
          controller.add(snapshot);
        });
      } else {
        controller.close();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color.fromARGB(255, 2, 38, 68), Color.fromARGB(255, 11, 106, 144)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        height: 170,
                        decoration: BoxDecoration(
                          color: Colors.white54,
                          borderRadius: BorderRadius.circular(10.0)
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Container(
                        height: 160,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10.0)
                        ),
                      ),
                    ),
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child:
                        StreamBuilder<QuerySnapshot>(
                          stream: getContacts(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            }
                            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                              return Center(child: Text("No contacts found"));
                            }
                            final contacts = snapshot.data!.docs;
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: contacts.length,
                              itemBuilder: (context, index) {
                                final contact = contacts[index];
                                final contactId = contact['userId'];
                                final contactName = contact['name'];
                                return Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => Chatmain(recipientId: contactId, recipientName: contactName)));
                                    },
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Circularimagecontainer(img: "assets/pageThreeWallpaper.jpg"),
                                        ReusableText(text: contactName, style: appStyle(12,Colors.grey,FontWeight.normal))
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
                const HeightSpacer(size: 10),
                HeadingWidget(headingText: "Chat", color: Colors.grey.shade800,textColor: Colors.grey.shade800,),
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white
                    ),
                    //child: ChatPage(recipientId: widget.recipientId! ),
                    child: widget.recipientId != null ? ChatPage(recipientId: widget.recipientId! , recipientName: widget.recipientName!,) : Center(child: Image(image: AssetImage("assets/chat.gif"), fit: BoxFit.cover,))
                  ),
                )
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar:BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 6.0,
          color: Colors.white,
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(onPressed: (){
                if(isAgent == true){
                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => RecruiterHome()));
                }else{
                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => HomePage()));
                }
                
              }, icon: Icon(CupertinoIcons.home)),
              IconButton(onPressed: (){
                
              }, icon: Icon(CupertinoIcons.doc_plaintext)),
              IconButton(onPressed: (){
                
              }, icon: Icon(Icons.work)),
              //SizedBox(width: 40,),
              IconButton(onPressed: (){
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>Chatmain()));
              }, icon: Icon(CupertinoIcons.captions_bubble)),
              IconButton(onPressed: (){
                if(isAgent == true){
                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> Recruiterprofile()));
                }else{
                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> MyProfile()));
                }
                
              }, icon: Icon(CupertinoIcons.person))
            ],
          )
        ),
      ),
    );
  }
}


class ChatPage extends StatefulWidget {
  final String recipientId; // the user you're chatting with
  final String recipientName;
  const ChatPage({super.key, required this.recipientId, required this.recipientName});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  final TextEditingController _controller = TextEditingController();
  String? userId;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('firebase_id');
    });
    print("Logged in user ID: $userId");
  }

  /// Generate chatId so both users share the same conversation
  String getChatId(String userA, String userB) {
    if(userA != userB) {
      if (userA.hashCode <= userB.hashCode) {
        return "${userA}_$userB";
      } else {
        return "${userB}_$userA";
      }
    } else {
      return "Self chat not allowed";
    }
  }

  Future<void> sendMessage(
    String text,
    String recipientId,
    String recipientName,
    String senderName,
  ) async {
    final chatId = getChatId(userId!, recipientId);

    // 1. Save message
    await FirebaseFirestore.instance
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .add({
      'text': text.trim(),
      'senderId': userId,
      'recipientId': recipientId,
      'createdAt': FieldValue.serverTimestamp(),
      'isRead': false,
    });

    // 2. Update chat metadata (for chat previews)
    await FirebaseFirestore.instance.collection('chats').doc(chatId).set({
      'lastMessage': text.trim(),
      'lastSender': userId,
      'lastUpdated': FieldValue.serverTimestamp(),
      'participants': [userId, recipientId],
    }, SetOptions(merge: true));

    // 3. Update sender's contacts
    final senderDoc = FirebaseFirestore.instance.collection('users').doc(userId);
    await senderDoc.collection('contacts').doc(recipientId).set({
      'userId': recipientId,
      'name': recipientName,
      'lastContacted': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    // 4. Update recipient's contacts
    final recipientDoc = FirebaseFirestore.instance.collection('users').doc(recipientId);
    await recipientDoc.collection('contacts').doc(userId).set({
      'userId': userId,
      'name': senderName,
      'lastContacted': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  @override
  Widget build(BuildContext context) {
    final chatId = getChatId(userId ?? '00', widget.recipientId);
    final recipientName = widget.recipientName;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          toolbarHeight: 40,
          leading: IconButton(
            icon: Icon(Iconsax.direct_left, color: Colors.white,),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
          ),
          title: Text(recipientName.toString(), style: appStyle(16, Colors.white, FontWeight.w500),),
        ),
        body: Column(
          children: [
            // messages list
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('chats')
                    .doc(chatId)
                    .collection('messages')
                    .orderBy('createdAt', descending: true)
                    .snapshots(),
                builder: (ctx, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final docs = snapshot.data!.docs;
      
                  return ListView.builder(
                    reverse: true,
                    itemCount: docs.length,
                    itemBuilder: (ctx, index) {
                      final msg = docs[index];
                      final isMe = msg['senderId'] == userId;
      
                      return Align(
                        alignment:
                            isMe ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 8),
                          decoration: BoxDecoration(
                            color: isMe ? Colors.blue : Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            msg['text'],
                            style: TextStyle(
                                color: isMe ? Colors.white : Colors.black87),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
      
            // input field
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: "Type a message...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 16),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send, color: Colors.blue),
                      onPressed: () async {
                        if (_controller.text.trim().isEmpty || userId == null) return;
                        // You may want to fetch recipientName and senderName from your user data
                        String recipientName = "Recipient"; // Replace with actual recipient name
                        final prefs = await SharedPreferences.getInstance();
                        String senderName = prefs.getString('username') ?? "Sender";
                         // Replace with actual sender name
                        await sendMessage(
                          _controller.text.trim(),
                          widget.recipientId,
                          widget.recipientName,
                          senderName,
                        );
                        _controller.clear();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}