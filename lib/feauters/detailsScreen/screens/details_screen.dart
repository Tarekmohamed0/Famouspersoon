import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/Person_details_cubit.dart';
import '../cubit/person_details_state.dart';
import '../widgets/container_of_information_person.dart';
import '../widgets/custom_appbar_details.dart';
import '../widgets/grid_view_item_of_person.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var personId = ModalRoute.of(context)!.settings.arguments as int;
    context.read<PersonDetailsCubit>().fetchPersonDetails(personId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PersonDetailsCubit, PersonDetailsState>(
          builder: (context, state) {
        if (state is PersonDetailsloading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is PersonDetailsloaded) {
          final person = state.person;
          final images = state.images;

          return SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const customAppBarDetails(),
                const SizedBox(height: 16),
                ContainerOfInformationPerson(state: person),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  child: Text(
                    'celebrity images',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(height: 26),
                GridViewItemImagesOfPerson(images: images),
              ],
            ),
          );
        } else if (state is PersonDetailsError) {
          return Center(
            child: Text(state.message),
          );
        }
        return Container();
      }),
    );
  }
}
