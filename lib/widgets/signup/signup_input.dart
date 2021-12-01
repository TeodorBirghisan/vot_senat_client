import 'package:flutter/material.dart';
import 'package:vot_senat_client/utils/validator.dart';

class SignupInputField extends StatelessWidget {
  final String? title;
  final bool isPassword;
  final double? fieldWidth;
  final Icon? inputIcon;

  const SignupInputField(
      {Key? key,
      @required this.title,
      this.isPassword = false,
      @required this.fieldWidth,
      this.inputIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: fieldWidth,
      margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            decoration: InputDecoration(
              hintText: title,
              prefixIcon: inputIcon,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.black87),
              ),
            ),
            validator: Validator.checkEmptyField,
            obscureText: isPassword,
          )
        ],
      ),
    );
  }
}
