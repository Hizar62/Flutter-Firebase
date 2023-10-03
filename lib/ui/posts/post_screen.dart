import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebaselearning/ui/auth/login_screen.dart';
import 'package:firebaselearning/ui/posts/add_post.dart';
import 'package:firebaselearning/utils/utils.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('POST');
  final searchFilter = TextEditingController();
  final editController = TextEditingController();

  Future<void> showMyDialog(String title, String id) async {
    editController.text = title;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Update'),
            content: Container(
              child: TextField(
                controller: editController,
                decoration: InputDecoration(),
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ref.child(id).update({
                      'title': editController.text.toLowerCase()
                    }).then((value) {
                      Utils().toastMessage("Post Updated");
                    }).onError((error, stackTrace) {
                      Utils().toastMessage(error.toString());
                    });
                  },
                  child: Text('Update'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Post Screen"),
          actions: [
            IconButton(
                onPressed: () {
                  auth.signOut().then((value) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                  });
                },
                icon: const Icon(Icons.logout_outlined)),
          ],
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                controller: searchFilter,
                decoration: const InputDecoration(
                    hintText: 'Search', border: OutlineInputBorder()),
                onChanged: (String value) {
                  setState(() {});
                },
              ),
            ),
            // Expanded(
            //     child: StreamBuilder(
            //         stream: ref.onValue,
            //         builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
            //           if (!snapshot.hasData) {
            //             return const CircularProgressIndicator();
            //           } else {
            //             Map<dynamic, dynamic> map =
            //                 snapshot.data!.snapshot.value as dynamic;

            //             List<dynamic> list = [];
            //             list.clear();
            //             list = map.values.toList();

            //             return ListView.builder(
            //                 itemCount: snapshot.data!.snapshot.children.length,
            //                 itemBuilder: (context, index) {
            //                   return ListTile(
            //                     title: Text(list[index]['title']),
            //                   );
            //                 });
            //           }
            //         })),

            Expanded(
              child: FirebaseAnimatedList(
                  query: ref,
                  itemBuilder: (context, snapshot, animation, index) {
                    final title = snapshot.child('title').value.toString();

                    if (searchFilter.text.isEmpty) {
                      return ListTile(
                        title: Text(snapshot.child('title').value.toString()),
                        subtitle: Text(snapshot.child('id').value.toString()),
                        trailing: PopupMenuButton(
                          child: Icon(Icons.more_vert),
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: 1,
                              child: ListTile(
                                onTap: () {
                                  Navigator.pop(context);
                                  showMyDialog(title,
                                      snapshot.child('id').value.toString());
                                },
                                leading: Icon(Icons.edit),
                                title: Text('Edit'),
                              ),
                            ),
                            PopupMenuItem(
                              value: 2,
                              child: ListTile(
                                onTap: () {
                                  Navigator.pop(context);
                                  ref
                                      .child(
                                          snapshot.child('id').value.toString())
                                      .remove();
                                },
                                leading: Icon(Icons.delete),
                                title: Text('Delete'),
                              ),
                            )
                          ],
                        ),
                      );
                    } else if (title
                        .toLowerCase()
                        .contains(searchFilter.text.toLowerCase())) {
                      return ListTile(
                        title: Text(snapshot.child('title').value.toString()),
                        subtitle: Text(snapshot.child('id').value.toString()),
                      );
                    } else {
                      return Container();
                    }
                  }),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddPost()));
          },
          child: Icon(Icons.add),
        ));
  }
}
