import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:socket_chat_test_app/components/assistant_message_widget.dart';
import 'package:socket_chat_test_app/components/select_menu_widget.dart';
import 'package:socket_chat_test_app/models/request_menu_item_model.dart';
import 'package:socket_chat_test_app/models/request_message_model.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

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

  List<BaseMessageModel> messages = [];

  @override
  void initState() {
    _channel.stream.listen((message) {
      try {
        var jsonData = jsonDecode(message);

        if (jsonData is List<dynamic>) {
          for (var element in jsonData) {
            messages.add(ResponseMessageModel.fromJson(element));
          }

          RequestMessageModel model = RequestMessageModel(
            action: "send_message",
            clientMessageId: "b1bc5a9a-9552-4855-a9a9-4a91c8e56763",
            chatId: (messages.firstWhere(
                        (element) => element.action == "create_chat")
                    as ResponseMessageModel)
                .id,
            text: "menu",
          );
          _channel.sink.add(jsonEncode(model.toJson()));
        }

        if (jsonData is Map<String, dynamic>) {
          var message = ResponseMessageModel.fromJson(jsonData);
          if (message.action != 'ping') {
            messages.add(message);
          }
        }

        setState(() {
          print('SET STATE');
        });
      } catch (e) {
        setState(() {
          messages.add(BaseMessageModel(action: message));
        });
      }
    });
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
              Container(
                height: 100,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 8),
                        height: 52,
                        width: 52,
                        decoration: const BoxDecoration(
                            color: Color(0xFFD9D9D9),
                            borderRadius:
                                BorderRadius.all(Radius.circular(26))),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Виртуальный ассистент',
                            style: TextStyle(
                                color: Color(0xFF455168),
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(3)),
                                    color: Color(0xFF0BA4A4)),
                              ),
                              const Text(
                                " Online",
                                style: TextStyle(
                                    color: Color(0xFF0BA4A4),
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: messages.map((e) {
                    if (e.action == 'AUTH_OK') {
                      return AssistantMessageWidget(
                          text: "Здравствуйте, чем могу помочь? ",
                          time: DateTime.now());
                    }
                    if (e.action == 'create_menu' &&
                        e is ResponseMessageModel) {
                      return SelectMenuWidget(
                          menu: e.menu,
                          onSelect: (String id) {
                            RequestMenuItemModel model = RequestMenuItemModel(
                              action: "force_menu",
                              menuId: e.id,
                              valueId: id,
                              chatId: e.chatId,
                            );
                            _channel.sink.add(jsonEncode(model.toJson()));

                            List<MenuItemModel> newMenu = [];
                            for (var element in e.menu) {
                              newMenu.add(MenuItemModel(
                                  title: element.title,
                                  id: element.id,
                                  isSelected: element.id == id));
                            }

                            int index = messages.indexWhere(
                                (element) => element.action == "create_menu");
                            messages[index] = ResponseMessageModel(
                              id: e.id,
                              text: e.text,
                              username: e.username,
                              chatId: e.chatId,
                              messageId: e.messageId,
                              time: e.time,
                              title: e.time,
                              clientMessageId: e.clientMessageId,
                              menu: newMenu,
                              action: e.action,
                            );
                          });
                    }
                    if (e.action == 'create_message' &&
                        e is ResponseMessageModel) {
                      return AssistantMessageWidget(
                          text: e.text, time: DateTime.parse(e.time));
                    }
                    return Container();
                  }).toList(),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(20),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                height: 56,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Напишите ваше сообщение',
                          hintStyle: TextStyle(
                              color: Color(0xFF97A3BA),
                              fontSize: 13,
                              fontWeight: FontWeight.w400),
                          //contentPadding: EdgeInsets.only(left: 14, right: 12, bottom: 0),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.send,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        _sendMessage();
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      _channel.sink.add(_controller.text);
      _controller.text = "";
    }
  }

  @override
  void dispose() {
    _channel.sink.close();
    _controller.dispose();
    super.dispose();
  }
}
