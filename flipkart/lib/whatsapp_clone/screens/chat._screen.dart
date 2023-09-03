import 'package:flutter/material.dart';
import 'package:my_first_app/utils/url_list.dart';

List<Map<String, Icon>> contactIconList = [
  {
    'icons': const Icon(Icons.group),
  },
  {'icons': const Icon(Icons.group_add)},
  {'icons': const Icon(Icons.qr_code)},
  {
    'icons': const Icon(Icons.groups),
  }
];

class ContactChatScreen extends StatelessWidget {
  const ContactChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.amber,
      appBar: AppBar(
        title: const ListTile(
          textColor: Colors.white,
          title: Text(
            'Select contact',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
          ),
          subtitle: Text(
            '100 contacts',
            style: TextStyle(fontSize: 15),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search_sharp),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.builder(
              shrinkWrap: true,
              // itemCount: contactIconList.length,
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                return const ListTile(
                  // tileColor: Colors.amber,
                  //  Icons icon=contactListIcon();
                  leading: CircleAvatar(
                      backgroundColor: Colors.teal,
                      child: Icon(
                        Icons.group,
                        color: Colors.white,
                      )),
                  title: Text(
                    'New group',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                );
              },
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Text(
                'Contacts on WhatsApp',
                style: TextStyle(
                    // fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 109, 106, 106)),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: chatList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(
                      chatList[index]['avatar'],
                    ),
                  ),
                  title: Text(
                    chatList[index]['name'],
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                  subtitle: Text(
                    chatListSubtitle[index]['Message'],
                  ),
                );
              },
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Text(
                'Invite to WhatsApp',
                style: TextStyle(
                    // fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 109, 106, 106)),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: invitetowhatsapplist.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(
                    Icons.account_circle_rounded,
                    color: Color.fromARGB(255, 185, 185, 185),
                    size: 42,
                  ),
                  title: Text(
                    invitetowhatsapplist[index]['Name'],
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                  trailing: Text(
                    invitetowhatsapplist[index]['invite'],
                    style: const TextStyle(color: Colors.teal, fontSize: 15),
                  ),
                );
              },
            ),
            const ListTile(
              leading: CircleAvatar(
                child: Icon(
                  Icons.share_sharp,
                  color: Color.fromARGB(255, 97, 90, 90),
                ),
              ),
              title: Text(
                'Share invite link',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
              ),
            ),
            const ListTile(
              leading: CircleAvatar(
                child: Icon(
                  Icons.help,
                  color: Color.fromARGB(255, 174, 174, 174),
                  size: 40,
                ),
              ),
              title: Text(
                'Contacts help',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
              ),
            )
          ],
        ),
      ),
    );
  }
}
