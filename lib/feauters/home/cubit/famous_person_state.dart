import '../models/famous_person_model.dart';

abstract class FamousPersonState {}

class FamousPersonInitial extends FamousPersonState {}

class FamousPersonLoading extends FamousPersonState {}

class FamousPersonloaded extends FamousPersonState {
  final List<FamousPersonModel> famousPerson;
  FamousPersonloaded(this.famousPerson);
}

class FamousPersonErorr extends FamousPersonState {
  final String message;
  FamousPersonErorr(this.message);
}
