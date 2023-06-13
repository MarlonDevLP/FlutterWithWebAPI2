import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/intercepted_client.dart';
import '../models/journal.dart';
import 'http_interceptors.dart';

class JournalService {
  static const String url = "http://10.0.0.106:3000/";
  static const String resource = "journals/";

  http.Client client = InterceptedClient.build(
    interceptors: [LoggingInterceptor()],
  );

  String getUrl() {
    return "$url$resource";
  }

  Uri getUri() {
    return Uri.parse(getUrl());
  }

  Future<bool> register(Journal journal) async {
    String journalJournal = json.encode(journal.toMap());

    http.Response response = await client.post(
      getUri(),
      headers: {'Content-type': 'application/json'},
      body: journalJournal,
    );

    if (response.statusCode == 201) {
      return true;
    }

    return false;
  }

  Future<bool> edit(String id, Journal journal) async{
    String journalJournal = json.encode(journal.toMap());

    http.Response response = await client.put(
      Uri.parse("{$getUrl()}"),
      headers: {'Content-type': 'application/json'},
      body: journalJournal,
    );
    if(response.statusCode == 200){
      return true;
    }
      return false;
  }





  Future<List<Journal>> getAll() async {
    http.Response response = await client.get(getUri());

    if (response.statusCode != 200) {
      //TODO: Criar uma exceção personalizada
      throw Exception();
    }

    List<Journal> result = [];

    List<dynamic> jsonList = json.decode(response.body);
    for (var jsonMap in jsonList) {
      result.add(Journal.fromMap(jsonMap));
    }

    return result;
  }
}