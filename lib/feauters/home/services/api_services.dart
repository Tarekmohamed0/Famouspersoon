import 'dart:developer';

import 'package:dio/dio.dart';

import '../models/famous_person_model.dart';

class ApiServices {
  final Dio dio = Dio();
  final String baseurl =
      'https://api.themoviedb.org/3/person/popular?api_key=2dfe23358236069710a379edd4c65a6b';

  Future<List<FamousPersonModel>> fetchFamousPerson() async {
    final response = await dio.get(baseurl);

    List<dynamic> famousPersons = response.data['results'];

    return famousPersons
        .map((famous) => FamousPersonModel.fromJson(famous))
        .toList();
  }

  Future<FamousPersonModel> fetchFamousePerosnDetails(int id) async {
    final response = await dio.get(
        'https://api.themoviedb.org/3/person/$id?api_key=2dfe23358236069710a379edd4c65a6b');

    if (response.data != null) {
      Map<String, dynamic> persondetails = response.data;

      return FamousPersonModel.fromJson(persondetails);
    } else {
      throw Exception("Failed to load person details: Data is null");
    }
  }

  Future<List<String>> fetchPersonimage(int personid) async {
    try {
      final response = await dio.get(
          'https://api.themoviedb.org/3/person/$personid/images?api_key=2dfe23358236069710a379edd4c65a6b');

      const String baseImageUrl = 'https://image.tmdb.org/t/p/w500';

      List<dynamic> images = response.data['profiles'] ?? [];

      // إضافة الرابط الأساسي لكل صورة
      return images
          .map((image) => '$baseImageUrl${image['file_path']}')
          .toList();
    } on DioException catch (e) {
      log('there is an error while loading image of person:$e');
      throw Exception('Failed to load person images: $e');
    } catch (e) {
      log('no images found for this person:$e');
      return [];
    }
  }
}
