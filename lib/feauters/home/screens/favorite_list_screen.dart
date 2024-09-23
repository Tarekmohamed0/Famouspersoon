import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../detailsScreen/cubit/Person_details_cubit.dart';
import '../../detailsScreen/cubit/person_details_state.dart';
import '../models/famous_person_model.dart';

class Favoritelistscreen extends StatefulWidget {
  const Favoritelistscreen({super.key});

  @override
  _FavoritelistscreenState createState() => _FavoritelistscreenState();
}

class _FavoritelistscreenState extends State<Favoritelistscreen> {
  List<int> favoritePersonsIds = [];
  Map<int, FamousPersonModel> favoritePersonsDetails = {};

  @override
  void initState() {
    super.initState();
    _loadFavoritePersons();
  }

  Future<void> _loadFavoritePersons() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<int> personsIds = [];
    Set<String> keys = prefs.getKeys();

    for (String key in keys) {
      if (key.startsWith('favorite_') && prefs.getBool(key) == true) {
        int personId = int.parse(
            key.replaceFirst('favorite_', '')); // تحويل الـ String إلى int
        personsIds.add(personId);
      }
    }

    setState(() {
      favoritePersonsIds = personsIds;
    });

    // جلب تفاصيل الأشخاص المفضلين بعد تحميل القائمة
    for (int personId in personsIds) {
      BlocProvider.of<PersonDetailsCubit>(context).fetchPersonDetails(personId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Persons'),
      ),
      body: favoritePersonsIds.isEmpty
          ? const Center(child: Text('No favorite persons added.'))
          : BlocListener<PersonDetailsCubit, PersonDetailsState>(
              listener: (context, state) {
                if (state is PersonDetailsloaded) {
                  setState(() {
                    favoritePersonsDetails[state.person.id] = state.person;
                  });
                }
              },
              child: ListView.builder(
                itemCount: favoritePersonsIds.length,
                itemBuilder: (context, index) {
                  final personId = favoritePersonsIds[index];

                  if (favoritePersonsDetails.containsKey(personId)) {
                    final person = favoritePersonsDetails[personId];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 8),
                      child: Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: RepaintBoundary(
                                child: Image.network(
                                  person!.imageUrl,
                                  height: 200,
                                  width: 150,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              person.name,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.05,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return const ListTile(
                      title: Text('Loading...'),
                    );
                  }
                },
              ),
            ),
    );
  }
}
