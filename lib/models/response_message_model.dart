import 'base_message_model.dart';
import 'menu_item_model.dart';

class ResponseMessageModel extends BaseMessageModel {
  final String id;
  final String chatId;
  final String messageId;
  final String time;
  final String title;
  final String clientMessageId;
  final String text;
  final String username;
  final List<MenuItemModel> menu;

  ResponseMessageModel(
      {required this.id,
      required this.text,
      required this.username,
      required this.chatId,
      required this.messageId,
      required this.time,
      required this.title,
      required this.clientMessageId,
      required this.menu,
      required super.action});

  factory ResponseMessageModel.fromJson(Map<String, dynamic> json) {
    Iterable<dynamic> menu = json['menu'] ?? [];

    return ResponseMessageModel(
      id: json['id'] ?? "",
      chatId: json['chat_id'] ?? "",
      messageId: json['message_id'] ?? "",
      time: json['ctime'] ?? "",
      title: json['title'] ?? "",
      clientMessageId: json['client_message_id'] ?? "",
      text: json['text'] ?? "",
      username: json['username'] ?? "",
      menu: List<MenuItemModel>.from(
        menu.map(
          (e) => MenuItemModel.fromJson(e),
        ),
      ),
      action: json['action'] ?? "",
    );
  }
}
