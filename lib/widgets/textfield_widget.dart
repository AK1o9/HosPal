import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/style.dart';

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
      child: Theme(
        data: ThemeData.from(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: darkTheme),
        ),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            filled: false,
            fillColor: light,
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
          inputFormatters: textInputType == TextInputType.number
              ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
              : null,
          textInputAction: TextInputAction.done,
        ),
      ),
    );
  }
}
