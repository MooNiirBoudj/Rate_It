import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_it/DB/dbhelper.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());

    try {
      // Simulate loading delay
      await Future.delayed(const Duration(seconds: 3));

      // Query the database
      final db = await DBHelper.getDatabase();
      final List<Map<String, dynamic>> users = await db.query(
        'users',
        where: 'email = ?',
        whereArgs: [email],
      );

      // Check user credentials
      if (users.isNotEmpty && users[0]['password'] == password) {
        emit(LoginSuccess('Login Successful'));
      } else {
        emit(LoginFailure('Invalid email or password'));
      }
    } catch (e) {
      emit(LoginFailure('An error occurred: ${e.toString()}'));
    }
  }
}
