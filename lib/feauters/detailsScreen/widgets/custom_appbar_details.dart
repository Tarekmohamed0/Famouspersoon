import 'package:flutter/material.dart';

class customAppBarDetails extends StatelessWidget {
  const customAppBarDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        const SizedBox(
          width: 77,
        ),
        const Text('celebrity details',
            style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w700)),
      ],
    );
  }
}
