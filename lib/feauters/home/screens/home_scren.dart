import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/famous_person_cubit.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_search_bar.dart';
import '../widgets/grid_view_person_item.dart';

class HomeScren extends StatefulWidget {
  const HomeScren({super.key});

  @override
  State<HomeScren> createState() => _HomeScrenState();
}

class _HomeScrenState extends State<HomeScren> {
  @override
  void initState() {
    context.read<FamousPersonCubit>().fetchFamousPersons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          CoustomAppbar(),
          SizedBox(
            height: 16,
          ),
          CustomSearchBar(),
          SizedBox(
            height: 12,
          ),
          GridviewPersonItem(),
        ],
      ),
    ));
  }
}
