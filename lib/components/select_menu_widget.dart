import 'package:flutter/material.dart';
import 'package:socket_chat_test_app/models/menu_item_model.dart';

class SelectMenuWidget extends StatelessWidget {
  final List<MenuItemModel> menu;
  final Function(String) onSelect;

  const SelectMenuWidget(
      {super.key, required this.menu, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    bool readOnly = menu.any((element) => element.isSelected);

    return Column(
      children: menu.map((element) {
        return Align(
          alignment: Alignment.centerRight,
          child: UnconstrainedBox(
            child: InkWell(
              onTap: readOnly
                  ? () {}
                  : () {
                      onSelect(element.id);
                    },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                    color: element.isSelected
                        ? const Color(0xFF4267EC)
                        : const Color(0xFF97A3BA),
                    borderRadius: const BorderRadius.all(Radius.circular(15))),
                child: Text(
                  element.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
