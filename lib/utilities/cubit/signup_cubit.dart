import 'package:flutter_bloc/flutter_bloc.dart';
import 'signup_state.dart';
import 'package:rate_it/DB/dbhelper.dart';
import 'package:sqflite/sqflite.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());

  Future<void> signup({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String gender,
  }) async {
    emit(SignupLoading());
    try {
      final db = await DBHelper.getDatabase();

      final user = {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'gender': gender,
      };

      await db.insert(
        'users',
        user,
        conflictAlgorithm: ConflictAlgorithm.abort,
      );

      emit(SignupSuccess());
    } catch (e) {
      if (e.toString().contains('UNIQUE constraint failed')) {
        emit(SignupFailure('A user with this email already exists.'));
      } else {
        emit(SignupFailure('An error occurred: ${e.toString()}'));
      }
    }
  }
}
