import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:socket_chat_test_app/components/assistant_message_widget.dart';
import 'package:socket_chat_test_app/components/chat_header_widget.dart';
import 'package:socket_chat_test_app/components/input_text_field.dart';
import 'package:socket_chat_test_app/components/select_menu_widget.dart';
import 'package:socket_chat_test_app/models/request_menu_item_model.dart';
import 'package:socket_chat_test_app/models/request_message_model.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:uuid/uuid.dart';

import 'models/base_message_model.dart';
import 'models/menu_item_model.dart';
import 'models/response_message_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();
  final _channel = WebSocketChannel.connect(
    Uri.parse('ws://212.41.9.88:83/'),
  );
  Uuid uuid = const Uuid();
  String chatId = "";
  List<BaseMessageModel> messages = [];

  RequestMessageModel _createSendMessage(
      {required String chatId, required String text}) {
    return RequestMessageModel(
      action: "send_message",
      clientMessageId: uuid.v1(),
      chatId: chatId,
      text: text,
      time: DateFormat('yyyy-MM-ddTHH:mm:ssZ').format(DateTime.now()),
    );
  }

  void _sendMessage(dynamic message) {
    _channel.sink.add(message);
  }

  void _updateMenu(ResponseMessageModel model, String id) {
    List<MenuItemModel> newMenu = [];
    for (var element in model.menu) {
      newMenu.add(
        MenuItemModel(
          title: element.title,
          id: element.id,
          isSelected: element.id == id,
        ),
      );
    }

    int index =
        messages.indexWhere((element) => element.action == "create_menu");
    messages[index] = ResponseMessageModel(
      id: model.id,
      text: model.text,
      username: model.username,
      chatId: model.chatId,
      messageId: model.messageId,
      time: model.time,
      title: model.time,
      clientMessageId: model.clientMessageId,
      menu: newMenu,
      action: model.action,
    );
    setState(() {});
  }

  void _initListener() {
    _channel.stream.listen((message) {
      try {
        var jsonData = jsonDecode(message);

        if (jsonData is List<dynamic>) {
          for (var element in jsonData) {
            messages.add(ResponseMessageModel.fromJson(element));
          }
          RequestMessageModel model = _createSendMessage(
            chatId: (messages.firstWhere(
                        (element) => element.action == "create_chat")
                    as ResponseMessageModel)
                .id,
            text: "menu",
          );
          chatId = model.chatId;

          _sendMessage(jsonEncode(model.toJson()));
          setState(() {});
        }

        if (jsonData is Map<String, dynamic>) {
          var message = ResponseMessageModel.fromJson(jsonData);
          if (message.action != 'ping') {
            setState(() {
              messages.add(message);
            });
          }
        }
      } catch (e) {
        setState(() {
          messages.add(BaseMessageModel(action: message));
        });
      }
    });
  }

  List<Widget> _generateChatChildren() {
    return messages.map((e) {
      if (e.action == 'AUTH_OK') {
        return AssistantMessageWidget(
          text: "Здравствуйте, чем могу помочь? ",
          time: DateTime.now(),
          alignment: Alignment.centerLeft,
        );
      }
      if (e.action == 'send_message' && e is RequestMessageModel) {
        return AssistantMessageWidget(
          text: e.text,
          time: DateTime.parse(e.time),
          alignment: Alignment.centerRight,
        );
      }
      if (e.action == 'create_menu' && e is ResponseMessageModel) {
        return SelectMenuWidget(
          menu: e.menu,
          onSelect: (String id) {
            RequestMenuItemModel model = RequestMenuItemModel(
              action: "force_menu",
              menuId: e.id,
              valueId: id,
              chatId: e.chatId,
            );
            _sendMessage(jsonEncode(model.toJson()));
            _updateMenu(e, id);
          },
        );
      }
      if (e.action == 'create_message' && e is ResponseMessageModel) {
        return AssistantMessageWidget(
          text: e.text,
          time: DateTime.parse(e.time),
          alignment: Alignment.centerLeft,
        );
      }
      return Container();
    }).toList();
  }

  @override
  void initState() {
    _initListener();
    _sendMessage("AUTH testtoken");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: const Color(0xFFF9FAFB),
          child: Column(
            children: [
              const ChatHeaderWidget(),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: _generateChatChildren(),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(20),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                height: 56,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InputTextField(
                        controller: _controller,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.send,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        _sendMessage(_controller.text);
                        RequestMessageModel model = _createSendMessage(
                          chatId: chatId,
                          text: _controller.text,
                        );
                        messages.add(model);
                        _controller.text = "";
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _channel.sink.close();
    _controller.dispose();
    super.dispose();
  }
}
