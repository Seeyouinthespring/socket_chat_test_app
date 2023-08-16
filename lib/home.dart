import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:socket_chat_test_app/response_model.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

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
    //Uri.parse('wss://echo.websocket.events'),
    Uri.parse('ws://212.41.9.88:83/'),
  );

  List<String> messages = [];

  @override
  void initState() {
    _channel.stream.listen((message) {

      print('type of message ---> ${message.runtimeType.toString()}');


      try{
        print('MESSAGE ---> ${message}');
        //var a = jsonDecode(message);
        //print('JSON a ---> ' + a);

        ResponseModel m = ResponseModel.fromJson(message);

        print('1 -> ${m.id}');
        print('2 -> ${m.title}');
        print('3 -> ${m.action}');

        print('MESSAGE ---> ${message}');

        setState(() {
          messages.add(message);
        });
      } catch (e){
        print('eeeeee -.>>>  ${e}');
        setState(() {
          messages.add(message);
        });
      }

      //_channel.sink.add('received!');
      //channel.sink.close(status.goingAway);
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    
    // return Scaffold(
    //   body: SafeArea(
    //       child: Container(
    //         color: const Color(0xFFF9FAFB),
    //         child: Column(
    //           children: [
    //             Container(
    //               height: 100,
    //               color: Colors.white,
    //               child: Padding(
    //                 padding: const EdgeInsets.all(20),
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.start,
    //                   crossAxisAlignment: CrossAxisAlignment.center,
    //                   children: [
    //                     Container(
    //                       margin: EdgeInsets.only(right: 8),
    //                       height: 52,
    //                       width: 52,
    //                       decoration: BoxDecoration(
    //                         color: Color(0xFFD9D9D9),
    //                         borderRadius: BorderRadius.all(Radius.circular(26))
    //                       ),
    //                     ),
    //
    //                     Container(
    //                       child: Column(
    //                         mainAxisAlignment: MainAxisAlignment.center,
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         children: [
    //                           Text('Виртуальный ассистент', style: TextStyle(color: Color(0xFF455168), fontSize: 16, fontWeight: FontWeight.w600),),
    //                           Row(
    //                             mainAxisAlignment: MainAxisAlignment.start,
    //                             crossAxisAlignment: CrossAxisAlignment.center,
    //                             children: [
    //                               Container(
    //                                 width: 6,
    //                                 height: 6,
    //                                 decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(3)), color: Color(0xFF0BA4A4)),
    //                               ),
    //                               Text(" Online", style: TextStyle(color: Color(0xFF0BA4A4), fontSize: 17, fontWeight: FontWeight.w500)),
    //                             ],
    //                           )
    //                         ],
    //                       ),
    //                     )
    //                   ],
    //                 ),
    //               ),
    //             ),
    //             Expanded(
    //               child: ListView(
    //                 shrinkWrap: true,
    //                 children: [
    //                   Align(
    //                     alignment: Alignment.centerLeft,
    //                     child: UnconstrainedBox(
    //                       child: Container(
    //                         margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    //                         padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
    //                         decoration: BoxDecoration(
    //                             color: Colors.white,
    //                             borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30), bottomRight: Radius.circular(30))
    //                         ),
    //                         child: Column(
    //                           //mainAxisSize: MainAxisSize.min,
    //                           crossAxisAlignment: CrossAxisAlignment.end,
    //                           children: [
    //                             Text('Здравствуйте, чем могу помочь? ', style: TextStyle(color: Color(0xFF455168), fontSize: 13, fontWeight: FontWeight.w400),),
    //                             Container(
    //                               child: Text('10:44',
    //                                 style: TextStyle(color: Color(0xFF667799), fontSize: 10, fontWeight: FontWeight.w400),
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                   // Row(
    //                   //   mainAxisSize: MainAxisSize.min,
    //                   //   children: [
    //                   //     Container(
    //                   //       margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    //                   //       padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
    //                   //       decoration: BoxDecoration(
    //                   //         color: Colors.white,
    //                   //         borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30), bottomRight: Radius.circular(30))
    //                   //       ),
    //                   //       child: Column(
    //                   //         children: [
    //                   //           Text('Здравствуйте, чем могу помочь?'),
    //                   //           Text('10:44')
    //                   //         ],
    //                   //       ),
    //                   //     ),
    //                   //   ],
    //                   // ),
    //
    //                   Align(
    //                     alignment: Alignment.centerRight,
    //                     child: UnconstrainedBox(
    //                       child: Container(
    //                         margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    //                         padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    //                         decoration: BoxDecoration(
    //                             color: Color(0xFF4267EC),
    //                             borderRadius: BorderRadius.all(Radius.circular(15))
    //                         ),
    //                         child: Text('Создать заявку в IT support', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 14),)
    //                       ),
    //                     ),
    //                   ),
    //
    //                   Align(
    //                     alignment: Alignment.centerRight,
    //                     child: UnconstrainedBox(
    //                       child: Container(
    //                           margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    //                           padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    //                           decoration: BoxDecoration(
    //                               color: Color(0xFF97A3BA),
    //                               borderRadius: BorderRadius.all(Radius.circular(15))
    //                           ),
    //                           child: Text('Оформить sick days', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 14),)
    //                       ),
    //                     ),
    //                   ),
    //
    //                   Align(
    //                     alignment: Alignment.centerLeft,
    //                     child: UnconstrainedBox(
    //                       child: Container(
    //                         margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    //                         padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
    //                         decoration: BoxDecoration(
    //                             color: Colors.white,
    //                             borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30), bottomRight: Radius.circular(30))
    //                         ),
    //                         child: Column(
    //                           //mainAxisSize: MainAxisSize.min,
    //                           crossAxisAlignment: CrossAxisAlignment.end,
    //                           children: [
    //                             Text('Заявка IT1034839 успешно создана', style: TextStyle(color: Color(0xFF455168), fontSize: 13, fontWeight: FontWeight.w400),),
    //                             Container(
    //                               child: Text('10:45',
    //                                 style: TextStyle(color: Color(0xFF667799), fontSize: 10, fontWeight: FontWeight.w400),
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //
    //                 ],
    //               ),
    //             ),
    //             Container(
    //               margin: EdgeInsets.all(20),
    //               padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    //               decoration: BoxDecoration(
    //                 color: Colors.white,
    //                 borderRadius: BorderRadius.all(Radius.circular(30))
    //               ),
    //               height: 56,
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: [
    //                   Expanded(
    //                     child: TextField(
    //                       controller: _controller,
    //                       style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w400 ),
    //                       decoration: const InputDecoration(
    //                         border: InputBorder.none,
    //                         hintText: 'Напишите ваше сообщение',
    //                         hintStyle: TextStyle(color: Color(0xFF97A3BA), fontSize: 13, fontWeight: FontWeight.w400 ),
    //                         //contentPadding: EdgeInsets.only(left: 14, right: 12, bottom: 0),
    //                       ),
    //                     ),
    //                   ),
    //                   Icon(Icons.send, color: Colors.blue,)
    //                 ],
    //               ),
    //             )
    //           ],
    //         ),
    //       )
    //   ),
    // );
    
    
    
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              child: TextFormField(
                controller: _controller,
                decoration: const InputDecoration(labelText: 'Send a message'),
              ),
            ),
            const SizedBox(height: 24),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 500,
              child: ListView(
                children: messages.map((element) {
                  return Text(element);
                }).toList(),
              ),
            ),
            // StreamBuilder(
            //   stream: _channel.stream,
            //   builder: (context, snapshot) {
            //     messages.add(snapshot.data ?? 'null');
            //     print('GET DATA ----> ${snapshot.data ?? 'null'}');
            //     return Container(
            //       width: MediaQuery.of(context).size.width,
            //       height: 500,
            //       child: ListView(
            //         children: messages.map((element) {
            //           return Text(element);
            //         }).toList(),
            //       ),
            //     );
            //     return Text(snapshot.hasData ? '${snapshot.data}' : '');
            //   },
            // )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: 'Send message',
        child: const Icon(Icons.send),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      _channel.sink.add(_controller.text);
    }
  }

  @override
  void dispose() {
    _channel.sink.close();
    _controller.dispose();
    super.dispose();
  }
}