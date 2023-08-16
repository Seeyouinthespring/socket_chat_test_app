import 'dart:convert';

class ResponseModel {
  final String action;
  final String id;
  final String chatId;
  final String messageId;
  final String ctime;
  final String title;
  final String clientMessageId;
  final List<TitleModel> menu;

  ResponseModel(
      {required this.menu,
      required this.action,
      required this.id,
      required this.chatId,
      required this.messageId,
      required this.ctime,
      required this.title,
      required this.clientMessageId});

  factory ResponseModel.fromJson(dynamic json) {

    List<TitleModel> list = [];


    var a = jsonDecode(json);


    print('TTTTYYYYYYPPPPPPEEEEEEE : ${a.runtimeType.toString()}');

    print('===========> action: ${a['action']} ');
    if (json['menu'] != null) {
      List<dynamic> listJson = List<dynamic>.from(json['menu']);
      for (var element in listJson) {
        list.add(TitleModel.fromJson(element));
      }
    }

    return ResponseModel(
      action: json['action'],
      id: json['id'],
      chatId: json['chat_id'],
      messageId: json['message_id'],
      ctime: json['ctime'],
      title: json['title'],
      clientMessageId: json['client_message_id'],
      menu: list,
    );
  }
}

class TitleModel {
  final String title;
  final String id;

  TitleModel({required this.title, required this.id});

  factory TitleModel.fromJson(dynamic json) {
    return TitleModel(title: json['title'], id: json['id']);
  }
}
