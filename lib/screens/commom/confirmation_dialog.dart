import 'package:flutter/material.dart';

Future<dynamic> showConfirmationDialog(
  BuildContext context, {
  String title = "Atenção!!",
  String content = "Você quer DELETAR?",
  String affirmativeOption = "Confirmar",
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: const Text(
              "Cancelar",
              style:
                  TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Text(
                affirmativeOption.toUpperCase(),
                style: const TextStyle(
                    color: Colors.orange, fontWeight: FontWeight.bold),
              )),
        ],
      );
    },
  );
}
