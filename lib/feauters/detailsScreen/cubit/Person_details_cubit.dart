import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home/services/api_services.dart';
import 'person_details_state.dart';

class PersonDetailsCubit extends Cubit<PersonDetailsState> {
  PersonDetailsCubit() : super(PersonDetailsInitial());

  Future<void> fetchPersonDetails(int personId) async {
    try {
      emit(PersonDetailsloading());

      final person = await ApiServices().fetchFamousePerosnDetails(personId);
      final images =
          await ApiServices().fetchPersonimage(personId); // جلب الصور أيضًا

      emit(PersonDetailsloaded(person, images));
    } on DioException catch (e) {
      log("There is a Dio error: $e");
      emit(PersonDetailsError('Network Error: $e'));
    } catch (e) {
      emit(PersonDetailsError('Failed to load person data: $e'));
      log('Failed to load person data: $e');
    }
  }
}
