import 'package:bankease/core/app_routes.dart';
import 'package:bankease/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bankease/core/injection.dart';
import 'package:bankease/core/value_objects/email_value_object.dart';
import 'package:bankease/core/value_objects/password_value_object.dart';
import 'package:bankease/core/widgets/custom_pop_up.dart';
import 'package:bankease/features/auth/domain/failures.dart';
import 'package:bankease/features/auth/presentation/manager/login_bloc/login_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return sl<LoginBloc>();
      },
      child: LoginForm(),
    );
  }
}

class LoginForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          state.authFailureOrSuccessOption.fold(() {}, (a) {
            late final String message;
            a.fold((l) {
              if (l is InvalidEmailFailure || l is WrongPasswordFailure) {
                message = 'Invalid email or password';
              }
              if (l is UserNotFoundFailure) {
                message = 'User not found';
              }
              if (l is UserDisabledFailure) {
                message = 'User is disabled';
              }
              if (l is TooManyRequestFailure) {
                message = ' Too many requests';
              }
              ScaffoldMessenger.of(context)
                  .showSnackBar(CustomPopUp.errorSnackBar(message));
            }, (r) {
              Navigator.pushNamedAndRemoveUntil(
                  context, AppRoutes.home, (route) => false);
            });
          });
        },
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                const SizedBox(height: 150),
                SizedBox(
                  width: 60,
                  height: 60,
                  child: Image.asset('images/icon.png'),
                ),
                const SizedBox(height: 10),
                Text(
                  "Login to your account",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 60),
                CustomTextField(
                  text: 'Email',
                  icon: const Icon(Icons.email_outlined),
                  // onEditingComplete: () => _focusNodePassword.requestFocus(),
                  onChanged: (value) {
                    context
                        .read<LoginBloc>()
                        .add(EmailChanged(email: EmailAddress(value ?? '')));
                  },
                  validator: (value) {
                    return context
                        .read<LoginBloc>()
                        .state
                        .email
                        .value
                        .fold((l) => 'Invalid email', (r) => null);
                  },
                ),
                const SizedBox(height: 10),
                PasswordTextField(
                    onChanged: (value) {
                      context
                          .read<LoginBloc>()
                          .add(PasswordChanged(password: Password(value!)));
                    },
                    text: 'Password',
                    validator: (value) {
                      return context
                          .read<LoginBloc>()
                          .state
                          .password
                          .value
                          .fold((l) => 'Invalid password', (r) => null);
                    }),
                const SizedBox(height: 60),
                Column(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        final isValid = _formKey.currentState!.validate();
                        if (isValid) {
                          context.read<LoginBloc>().add(LoginSubmitted());
                        }
                      },
                      child: const Text("Login"),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?"),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, AppRoutes.register);
                          },
                          child: const Text("Register"),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
