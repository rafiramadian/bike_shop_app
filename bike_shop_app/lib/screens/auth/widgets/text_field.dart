import 'package:bike_shop_app/utils/theme.dart';
import 'package:flutter/material.dart';

TextFormField textField(String text, IconData icon, bool isPasswordType, TextEditingController controller) {
  return TextFormField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: darkBlue300,
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: darkBlue300,
      ),
      labelText: text,
      labelStyle: subtitleTextStyle,
      filled: true,
      fillColor: colorWhite.withOpacity(0.7),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: const BorderSide(
          width: 0,
          style: BorderStyle.none,
        ),
      ),
      floatingLabelBehavior: FloatingLabelBehavior.never,
    ),
    keyboardType: isPasswordType ? TextInputType.visiblePassword : TextInputType.emailAddress,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Form tidak boleh kosong';
      } else if (isPasswordType && value.length < 6) {
        return 'Password minimal 6 karakter';
      }
      return null;
    },
  );
}
