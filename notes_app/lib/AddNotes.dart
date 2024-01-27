import 'package:flutter/material.dart';
import 'package:notes_app/Model/NotesModel.dart';

import 'main.dart';

class AddNote extends StatefulWidget {
  final NotesModel? model;

  const AddNote({super.key, this.model});

  @override
  State<AddNote> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNote> {
  final TextEditingController titleController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initialiseValues();
  }

  void initialiseValues() {
    if (widget.model != null) {
      titleController.text = widget.model!.title!;
      descriptionController.text = widget.model!.description!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Notes"),
        backgroundColor: Colors.greenAccent.shade700,
      ),
      body: Column(
        children: [
          customTextField("Title", titleController),
          customTextField("Description", descriptionController),
          ElevatedButton(
            onPressed: () {

              if (widget.model == null) {
                final map = {
                  "title": titleController.text,
                  "description": descriptionController.text,
                  "time": DateTime.now().millisecondsSinceEpoch,
                };

                final notesModel = NotesModel.fromJson(map);

                Navigator.pop(context, notesModel);
              } else {
                final map = {
                  "title": titleController.text,
                  "description": descriptionController.text,
                  "time": widget.model!.time!,
                };

                final notesModel = NotesModel.fromJson(map);

                Navigator.pop(context, notesModel);
              }
            },
            child: const Text("Save"),
          ),
          SizedBox(height: 15.0),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Back to Main Page ?'),
                TextButton(
                  child: Text('Click Here !',
                      style: TextStyle(
                        color: Colors.blue,
                      )
                  ),
                  onPressed:(){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => HomePage()));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget customTextField(String title, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: title,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}