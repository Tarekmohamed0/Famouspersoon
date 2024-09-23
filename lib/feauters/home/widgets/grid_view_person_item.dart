import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../cubit/famous_person_cubit.dart';
import '../cubit/famous_person_state.dart';
import 'personItem.dart';

class GridviewPersonItem extends StatelessWidget {
  const GridviewPersonItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FamousPersonCubit, FamousPersonState>(
      builder: (context, state) {
        if (state is FamousPersonLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is FamousPersonloaded) {
          return Expanded(
            child: MasonryGridView.count(
              itemCount: state.famousPerson.length,
              crossAxisCount: 2,
              mainAxisSpacing: 2,
              crossAxisSpacing: 2,
              itemBuilder: (context, index) {
                final person = state.famousPerson[index];
                return Personitem(
                  person: person,
                );
              },
            ),
          );
        } else if (state is FamousPersonErorr) {
          return Center(
            child: Text(state.message),
          );
        }
        return Container();
      },
    );
  }
}
