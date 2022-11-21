import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/style.dart';

class TextfieldWidget extends StatelessWidget {
  //Required
  final String labelText;
  final TextEditingController controller;

  //Optional
  final MaterialColor? colorTheme;
  final String? hintText;
  final Icon? icon;
  final bool? hideText;
  final TextInputType textInputType;

  const TextfieldWidget(
      {Key? key,
      required this.labelText,
      required this.controller,
      this.colorTheme,
      this.hintText,
      this.icon,
      this.hideText = false,
      this.textInputType = TextInputType.none})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: Theme(
        data: ThemeData.from(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: colorTheme!),
        ),
        child: TextField(
          controller: controller,

          //Hide text (i.e. for passwords)
          obscureText: hideText == true ? true : false,
          enableSuggestions: hideText == true ? false : true,
          autocorrect: hideText == true ? false : true,

          decoration: InputDecoration(
            filled: false,
            fillColor: light,
            labelText: labelText,
            prefixIcon: icon,
            suffixIcon: controller.text.isEmpty
                ? Container(width: 0)

                //Clear textfield button ('X')
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
