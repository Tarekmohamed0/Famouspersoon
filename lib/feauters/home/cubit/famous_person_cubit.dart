import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../services/api_services.dart';
import 'famous_person_state.dart';

class FamousPersonCubit extends Cubit<FamousPersonState> {
  FamousPersonCubit() : super(FamousPersonInitial());

  Future<void> fetchFamousPersons() async {
    try {
      emit(FamousPersonLoading());
      final famousPersons = await ApiServices().fetchFamousPerson();
      if (famousPersons != null) {
        emit(FamousPersonloaded(famousPersons));
      }
    } on DioException catch (e) {
      log('there is an error:$e');
    } catch (e) {
      emit(FamousPersonErorr('failed to load data from api:$e'));
      log('there is an error:$e');
    }
  }
}
