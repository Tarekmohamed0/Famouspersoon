import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContainerOfInformationPerson extends StatelessWidget {
  const ContainerOfInformationPerson({super.key, required this.state});
  final state;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.3,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Celebrity Details',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700)),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: RepaintBoundary(
                      child: Image.network(
                        state.imageUrl,
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      Text('${state.name}',
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w700)),
                      Text('jop:${state.knownForDepartment}',
                          style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 14,
                              fontWeight: FontWeight.w400)),
                      Text('birthday:${state.birthday}',
                          style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 12,
                              fontWeight: FontWeight.w400)),
                      Text(
                        '${state.placeOfBirth}',
                        style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 10,
                            fontWeight: FontWeight.w400),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text('popularity:${state.popularity.toString()}',
                          style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 14,
                              fontWeight: FontWeight.w400)),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(state.biography ?? 'Unknown',
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis),
              const SizedBox(height: 10),
              const Row(
                children: [
                  FaIcon(FontAwesomeIcons.facebook, color: Colors.blue),
                  SizedBox(
                    width: 10,
                  ),
                  FaIcon(FontAwesomeIcons.twitter, color: Colors.black),
                  SizedBox(
                    width: 10,
                  ),
                  FaIcon(FontAwesomeIcons.instagram, color: Colors.pink),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
