import 'package:flutter/material.dart';
import '../../helpers/weekday.dart';
import '../../models/journal.dart';
import '../../services/journal_service.dart';

class AddJournalScreen extends StatefulWidget {
  final Journal journal;
  const AddJournalScreen({Key? key, required this.journal, }) : super(key: key);

  @override
  State<AddJournalScreen> createState() => _AddJournalScreenState();
}

class _AddJournalScreenState extends State<AddJournalScreen> {
  final TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    contentController.text = widget.journal.content;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text(WeekDay(widget.journal.createdAt).toString(),
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
          controller: contentController,
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
    JournalService journalService = JournalService();
    widget.journal.content = contentController.text;
    journalService.register(widget.journal).then((value) {
      if (value) {
        Navigator.pop(context, DisposeStatus.success);
      } else {
        Navigator.pop(context, DisposeStatus.error);
      }
    });
  }
}

enum DisposeStatus { exit, error, success }



