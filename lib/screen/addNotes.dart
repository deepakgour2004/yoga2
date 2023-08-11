import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AddNote extends StatefulWidget {
  var id;
  var title;
  var description;

  AddNote({this.id, this.title, this.description});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  var databaseref = FirebaseDatabase.instance.ref("notes");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text('Add Note')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              // controller: _titleController,
              initialValue: widget.title,
              maxLines: 1,
              decoration: InputDecoration(labelText: 'Enter your note'),
              onChanged: (value) {
                setState(() {
                  widget.title = value;
                });
              },
            ),
            TextFormField(
              // controller: _descriptionController,
              initialValue: widget.description,
              maxLines: 5,
              decoration: InputDecoration(labelText: 'Enter your note'),
              onChanged: (value) {
                setState(() {
                  widget.description = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                databaseref.child(widget.id).set({
                  "id": widget.id,
                  "title": widget.title,
                  "description": widget.description
                }).whenComplete(() {
                  Navigator.pop(context);
                });
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
