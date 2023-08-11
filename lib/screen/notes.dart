import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:yoga2/screen/addNotes.dart';

class NotesApp extends StatefulWidget {
  const NotesApp({super.key});

  @override
  State<NotesApp> createState() => _NotesAppState();
}

class _NotesAppState extends State<NotesApp> {
  var databaseref = FirebaseDatabase.instance.ref("notes");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
        backgroundColor: Colors.blue,
      ),
      body: StreamBuilder(
          stream: databaseref.onValue,
          builder: (context, snapshot) {
            if (!snapshot.hasData ||
                snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else {
              Map<dynamic, dynamic> map =
                  snapshot.data!.snapshot.value as dynamic;

              List<dynamic> notes = [];
              notes.clear();
              notes = map.values.toList();
              return ListView.builder(
                itemCount: snapshot.data!.snapshot.children.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddNote(
                                  id: notes[index]["id"],
                                  title: notes[index]["title"],
                                  description: notes[index]["description"],
                                )),
                      );
                    },
                    child: Container(
                      height: 100,
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.black.withOpacity(0.4)),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            notes[index]["title"],
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            notes[index]['description'],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddNote(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      title: "",
                      description: "",
                    )),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
