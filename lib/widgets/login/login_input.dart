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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Text(
              title,
              style: const TextStyle(fontSize: 15),
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: isPassword ? 'Type your password' : 'Type your email',
              prefixIcon: isPassword
                  ? const Icon(
                      Icons.security,
                      color: Colors.black87,
                    )
                  : const Icon(Icons.account_circle_rounded,
                      color: Colors.black87),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.black87),
              ),
            ),
            validator: checkEmptyField,
            obscureText: isPassword,
          ),
        ],
      ),
    );
  }
}

String? checkEmptyField(String? fieldContent) {
  if (fieldContent == null || fieldContent.isEmpty) {
    return 'Fields cannot be empty!';
  }
  return null;
}
