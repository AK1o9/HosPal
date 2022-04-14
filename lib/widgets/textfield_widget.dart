import 'package:flutter/material.dart';

class TextfieldWidget extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;

  //Optional
  final String hintText;
  final Icon? icon;
  final TextInputType textInputType;

  const TextfieldWidget(
      {Key? key,
      required this.labelText,
      required this.controller,
      this.hintText = '',
      this.icon,
      this.textInputType = TextInputType.none})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: icon,
          suffixIcon: controller.text.isEmpty
              ? Container(width: 0)
              : IconButton(
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  icon: const Icon(Icons.close),
                  onPressed: () => controller.clear(),
                ),
          border: const OutlineInputBorder(),
        ),
        keyboardType: textInputType,
        textInputAction: TextInputAction.done,
      ),
    );
  }
}
