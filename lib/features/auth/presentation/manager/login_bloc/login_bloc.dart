import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:bankease/core/domain/entities/user_entity.dart';
import 'package:bankease/core/value_objects/email_value_object.dart';
import 'package:bankease/core/value_objects/password_value_object.dart';
import 'package:bankease/features/auth/domain/failures.dart';
import 'package:bankease/features/auth/domain/use_cases/login_use_case.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  LoginBloc(this.loginUseCase) : super(LoginState.initial()) {
    on<LoginEvent>((event, emit) async {
      if (event is EmailChanged) {
        emit(state.copyWith(
            email: event.email, authFailureOrSuccessOption: none()));
      } else if (event is PasswordChanged) {
        emit(state.copyWith(
            password: event.password, authFailureOrSuccessOption: none()));
      } else if (event is LoginSubmitted) {
        final params = LoginParams(
          emailAddress: state.email,
          password: state.password,
        );
        print(params.emailAddress);
        print(params.password);
        final result = await loginUseCase.call(params);
        emit(state.copyWith(authFailureOrSuccessOption: some(result)));
      }
    });
  }
}
