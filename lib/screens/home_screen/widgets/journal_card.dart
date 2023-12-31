import 'package:appdiariooo/services/journal_service.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../../helpers/weekday.dart';
import '../../../models/journal.dart';
import '../../commom/confirmation_dialog.dart';

class JournalCard extends StatelessWidget {
  final Journal? journal;
  final DateTime showedDate;
  final Function refreshFunction;

  const JournalCard({
    Key? key,
    this.journal,
    required this.showedDate,
    required this.refreshFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (journal != null) {
      return InkWell(
          onTap: () {
            callAddJournalScreen(context, journal: journal);
          },
          child: Container(
            height: 133,
            margin: const EdgeInsets.all(8),
            child: Container(
              height: 115,
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(26),
              ),
              child: Row(
                children: [
                  Column(
                    children: [
                      Container(
                        height: 70,
                        width: 75,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: Colors.black54,
                          border: Border(
                              right: BorderSide(
                                color: Colors.black87,
                              ),
                              bottom: BorderSide(color: Colors.black87)),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          journal!.createdAt.day.toString(),
                          style: const TextStyle(
                              fontSize: 32,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        height: 38,
                        width: 75,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          border: Border(
                            right: BorderSide(color: Colors.black87),
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Text(WeekDay(journal!.createdAt).short),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        journal!.content,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        removeJournalScreen(context);
                      },
                      icon: const Icon(
                        Icons.delete,
                      )),
                ],
              ),
            ),
          ));
    } else {
      return InkWell(
        onTap: () {
          callAddJournalScreen(context);
        },
        child: Container(
          height: 115,
          alignment: Alignment.center,
          child: Text(
            "${WeekDay(showedDate).short} - ${showedDate.day}",
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }

  callAddJournalScreen(BuildContext context, {Journal? journal}) {
    Journal innerJournal = Journal(
      id: const Uuid().v1(),
      content: "",
      createdAt: showedDate,
      updatedAt: showedDate,
    );

    Map<String, dynamic> map = {};
    if (journal != null) {
      innerJournal = journal;
      map["is_editing"] = false;
    } else {
      map["is_editing"] = true;
    }

    map["journal"] = innerJournal;

    Navigator.pushNamed(
      context,
      "add-journal",
      arguments: map,
    ).then((value) {
      refreshFunction();

      if (value != null && value == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Registro salvo com sucesso."),
          ),
        );
      } else if (value == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Houve uma falha ao registar."),
          ),
        );
      }
    });
  }

  removeJournalScreen(BuildContext context) {
    JournalService service = JournalService();
    if (journal != null) {
      showConfirmationDialog(
        context,
        content: "vai REMOVER MESMO??\n${WeekDay(journal!.createdAt)}",
        affirmativeOption: "remover",
      ).then((value){
        if(value != null){
          if(value){
            service.delete(journal!.id).then((value) {
              if (value == true) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: (Text("Deletado com sucesso")),
                  ),
                );
                refreshFunction();
              }
            });
          }
        }
      }
     );

    } else {
      return false;
    }
  }
}
