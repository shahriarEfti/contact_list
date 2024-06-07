import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ContactTile extends StatelessWidget {
  final String name;
  final String number;
  final VoidCallback onLongPress;
  final VoidCallback onCallPressed;

  const ContactTile({
    required this.name,
    required this.number,
    required this.onLongPress,
    required this.onCallPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: onLongPress,
      child:  ListTile(
          title: Text(
            name,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            number,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.grey[600],
            ),
          ),
          leading: const CircleAvatar(
            backgroundColor: Colors.blue,
            child: Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
          trailing: IconButton(
            icon: const Icon(
              Icons.call,
              color: Colors.green,
            ),
            onPressed: onCallPressed,
          ),
          tileColor: Colors.grey[200],
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
    );

  }
}
