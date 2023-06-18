import 'package:flutter/material.dart';
import '../../helpers/weekday.dart';
import '../../models/journal.dart';
import '../../services/journal_service.dart';

class AddJournalScreen extends StatelessWidget {
  final Journal journal;
  final bool isEditing;
  AddJournalScreen({Key? key, required this.journal,required this.isEditing }) : super(key: key);

   final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _contentController.text = journal.content;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text(WeekDay(journal.createdAt).toString(),
          style: const TextStyle(fontSize: 16),),
        actions: [
          IconButton(
            onPressed: () {
              registerJournal(context);
            },
            icon: const Icon(Icons.check),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: TextField(
          autofocus: true,
          decoration:
          const InputDecoration(border:
          InputBorder.none,
          hintText: 'No que você está pensando hoje?',),
          controller: _contentController,
          keyboardType: TextInputType.multiline,
          style: const TextStyle(fontSize: 22),
          expands: true,
          maxLines: null,
          minLines: null,
        ),
      ),
    );
  }

  registerJournal(BuildContext context) async {
    String content = _contentController.text;

    journal.content = content;

    JournalService service = JournalService();
    if(isEditing){
      service.register(journal).then((value) {
        Navigator.pop(context, value);
      });
    }else{
      service.edit(journal.id, journal).then((value) {
        Navigator.pop(context, value);
      });
    }
  }
}





