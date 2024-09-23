abstract class PersonDetailsState {}

class PersonDetailsInitial extends PersonDetailsState {}

class PersonDetailsloading extends PersonDetailsState {}

class PersonDetailsloaded extends PersonDetailsState {
  var person;
  final List<String> images; // إضافة قائمة الصور

  PersonDetailsloaded(
      this.person, this.images); // تعديل الكونستركتور لاستقبال الصور
}

class PersonDetailsError extends PersonDetailsState {
  final String message;
  PersonDetailsError(this.message);
}
