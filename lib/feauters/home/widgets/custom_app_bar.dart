import 'package:flutter/material.dart';

import '../screens/favorite_list_screen.dart';

class CoustomAppbar extends StatelessWidget {
  const CoustomAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Famous Person',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          Icon(
            Icons.search,
            color: Colors.grey[600],
            size: 28,
          ),
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const Favoritelistscreen()));
              },
              icon: const Icon(Icons.favorite_border)),
        ],
      ),
    );
  }
}
