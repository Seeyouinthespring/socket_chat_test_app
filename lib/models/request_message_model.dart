import 'base_message_model.dart';

class RequestMessageModel extends BaseMessageModel {
  final String clientMessageId;
  final String chatId;
  final String text;
  final String time;

  RequestMessageModel(
      {required super.action,
      required this.clientMessageId,
      required this.chatId,
      required this.text,
      required this.time,});

  factory RequestMessageModel.fromJson(Map<String, dynamic> json) =>
      RequestMessageModel(
        action: json['action'] ?? "",
        clientMessageId: json['client_message_id'] ?? "",
        chatId: json['chat_id'] ?? "",
        text: json['text'] ?? "",
        time: json['ctime'] ?? "",
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    json['action'] = action;
    json['client_message_id'] = clientMessageId;
    json['chat_id'] = chatId;
    json['text'] = text;
    return json;
  }
}
