import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart'; // استيراد SharedPreferences

import '../../../core/routes/names.dart';
import '../cubit/famous_person_cubit.dart';
import '../cubit/famous_person_state.dart';

class Personitem extends StatefulWidget {
  const Personitem({
    super.key,
    required this.person,
  });
  final person;

  @override
  _personItemState createState() => _personItemState();
}

class _personItemState extends State<Personitem> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkIfFavorite();
  }

  // التحقق مما إذا كان الشخص مضافًا إلى المفضلة أم لا
  void _checkIfFavorite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isFavorite = prefs.getBool('favorite_${widget.person.id}') ?? false;
    });
  }

  // تغيير حالة المفضلة
  void _toggleFavorite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isFavorite = !isFavorite;
      prefs.setBool('favorite_${widget.person.id}', isFavorite);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FamousPersonCubit, FamousPersonState>(
      builder: (context, state) {
        if (state is FamousPersonloaded) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(RoutesName.details, arguments: widget.person.id);
            },
            child: SizedBox(
              height: 310,
              width: 167,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(children: [
                    Container(
                      height: 191,
                      width: 143,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: RepaintBoundary(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network('${widget.person.imageUrl}',
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 2,
                      bottom: 2,
                      child: IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : Colors.white,
                        ),
                        onPressed: _toggleFavorite,
                      ),
                    ),
                  ]),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${widget.person.name}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      'Famous Person known for ${widget.person.knownForDepartment} Department.',
                      overflow: TextOverflow.clip,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (state is FamousPersonLoading) {
          return const Center(
            child: CircularProgressIndicator(),
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
