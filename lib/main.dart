import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/bloc/My_bloc_observer.dart';
import 'core/routes/names.dart';
import 'feauters/detailsScreen/cubit/Person_details_cubit.dart';
import 'feauters/detailsScreen/screens/details_screen.dart';
import 'feauters/home/cubit/famous_person_cubit.dart';
import 'feauters/home/screens/home_scren.dart';

void main() {
  // ignore: deprecated_member_use
  BlocOverrides.runZoned(
    () {
      runApp(const MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<FamousPersonCubit>(
            create: (context) => FamousPersonCubit(),
          ),
          BlocProvider<PersonDetailsCubit>(
            create: (context) => PersonDetailsCubit(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            // RoutesName.login: (context) => LoginScreen(),
            // RoutesName.register: (context) => RegisterScreen(),
            // RoutesName.chat: (context) => CahtScreen(),
            RoutesName.details: (context) => const DetailsScreen(),
            // RoutesName.home: (context) => HomeProduct(),
            // RoutesName.updateProduct: (context) => UpdateProduct(),
          },
          theme: ThemeData(
            appBarTheme: const AppBarTheme(),
            scaffoldBackgroundColor: Colors.white,
            useMaterial3: true,
          ),
          home: const HomeScren(),
        ));
  }
}
