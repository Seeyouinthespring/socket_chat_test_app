import 'package:socket_chat_test_app/models/base_message_model.dart';

class RequestMenuItemModel extends BaseMessageModel {
  final String menuId;
  final String valueId;
  final String chatId;

  RequestMenuItemModel({
    required super.action,
    required this.menuId,
    required this.valueId,
    required this.chatId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    json['action'] = action;
    json['menu_id'] = menuId;
    json['value_id'] = valueId;
    json['chat_id'] = chatId;
    return json;
  }
}
