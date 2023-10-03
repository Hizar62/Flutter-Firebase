import 'package:firebase_database/firebase_database.dart';
import 'package:firebaselearning/utils/utils.dart';
import 'package:firebaselearning/widgets/round_button.dart';
import 'package:flutter/material.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  bool loading = false;
  final addPostController = TextEditingController();
  final databaseRef = FirebaseDatabase.instance.ref('POST');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Post"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              maxLines: 5,
              controller: addPostController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Tell me what you want to keep it secret!'),
            ),
            const SizedBox(
              height: 50,
            ),
            RoundButton(
              title: 'Add',
              loading: loading,
              onTap: () {
                setState(() {
                  loading = true;
                });

                databaseRef
                    .child(DateTime.now().millisecondsSinceEpoch.toString())
                    .set({
                  'title': addPostController.text.toString(),
                  'id': DateTime.now().millisecondsSinceEpoch.toString()
                }).then((value) {
                  Utils().toastMessage('Post Added');
                  setState(() {
                    loading = false;
                  });
                }).onError((error, stackTrace) {
                  Utils().toastMessage(error.toString());
                  setState(() {
                    loading = false;
                  });
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
