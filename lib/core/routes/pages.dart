import 'package:flutter/material.dart';

import '../../feauters/detailsScreen/screens/details_screen.dart';
import 'routes.dart';

class AppRoute {
  static Route<dynamic> generate(RouteSettings? settings) {
    switch (settings?.name) {
      case RoutesName.details:
        return MaterialPageRoute(builder: (_) => const DetailsScreen());
      default:
        // If there is no such named route in the switch statement
        // throw const RouteException('Route not found!');
        return MaterialPageRoute(
            builder: (_) => const Center(
                  child: Text('no screen with this name'),
                ));
    }
  }
}
