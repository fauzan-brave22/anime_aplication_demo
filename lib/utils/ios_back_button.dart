import 'package:flutter/material.dart';

class IosBackButton extends StatelessWidget {
  const IosBackButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: InkWell(
        onTap: onPressed,
        child: SizedBox(
          height: 35,
          width: 35,
          child: Container(
            color: Theme.of(context).shadowColor,
            child: Icon(
              Icons.arrow_back_ios_new,
              size: 20,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
