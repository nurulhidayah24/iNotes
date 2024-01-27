import 'package:flutter/material.dart';
import 'package:notes_app/Model/NotesModel.dart';
import 'package:notes_app/Database/DbNotes.dart';
import 'package:notes_app/main.dart';
import 'AddNotes.dart';
import 'login.dart'; // Import your login screen widget here

class DisplayNotes extends StatefulWidget {
  const DisplayNotes({Key? key}) : super(key: key);

  @override
  State<DisplayNotes> createState() => _DisplayNotesState();
}

class _DisplayNotesState extends State<DisplayNotes> {
  List<NotesModel> notesItems = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    notesItems = await NotesDatabase.getDataFromDatabase();

    print(notesItems.length);

    setState(() {});
  }

  void logout() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => HomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("iNotes"),
        backgroundColor: Colors.greenAccent.shade700,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Call the logout function when the user clicks the logout button
              logout();
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: notesItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(notesItems[index].title!),
            subtitle: Text(notesItems[index].description!),
            leading: IconButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddNote(
                      model: notesItems[index],
                    ),
                  ),
                );

                await NotesDatabase.updateDataInDatabase(
                  result,
                  result.time,
                );

                notesItems[index] = result;

                setState(() {});
              },
              icon: const Icon(Icons.edit),
            ),
            trailing: IconButton(
              onPressed: () async {
                await NotesDatabase.deleteDataFromDatabase(
                  notesItems[index].time!,
                );

                notesItems.removeAt(index);
                setState(() {});
              },
              icon: const Icon(Icons.delete),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNote(),
            ),
          );

          print(result);

          if (result != null) {
            notesItems.add(result);

            await NotesDatabase.insertData(result);

            setState(() {});
          }
        },
      ),
    );
  }
}
