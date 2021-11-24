import 'package:flutter/material.dart';

class LoginInputFied extends StatelessWidget {
  final String title;
  final bool isPassword;

  const LoginInputFied({Key? key, this.title = '', this.isPassword = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 350,
        margin: const EdgeInsets.symmetric(vertical: 2),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Text(
                title,
                style: const TextStyle(fontSize: 14),
              )),
          TextFormField(
              decoration: InputDecoration(
                prefixIcon: isPassword
                    ? const Icon(Icons.security)
                    : const Icon(Icons.account_circle_rounded),
                border: const OutlineInputBorder(),
              ),
              validator: checkEmptyField),
        ]));
  }
}

String? checkEmptyField(String? fieldContent) {
  if (fieldContent == null || fieldContent.isEmpty) {
    return 'Fields cannot be empty!';
  }
  return null;
}
