import 'package:flutter/material.dart';

class CredentialField extends StatelessWidget {
  final String label;
  final TextEditingController tec;

  const CredentialField(this.label, this.tec, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white, 
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: tec,
          obscureText: label == "Password" || label == "Confirm Password",
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: 'Enter $label',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12), 
              borderSide: const BorderSide(
                color: Colors.transparent,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.transparent,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.blue,
                width: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
