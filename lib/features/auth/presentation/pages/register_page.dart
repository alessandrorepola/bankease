import 'package:bankease/core/app_routes.dart';
import 'package:bankease/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bankease/core/injection.dart';
import 'package:bankease/core/value_objects/email_value_object.dart';
import 'package:bankease/core/value_objects/name_value_object.dart';
import 'package:bankease/core/value_objects/password_value_object.dart';
import 'package:bankease/core/widgets/custom_pop_up.dart';
import 'package:bankease/features/auth/domain/failures.dart';
import 'package:bankease/features/auth/presentation/manager/register_bloc/register_bloc.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return Injection.getIt.get<RegisterBloc>();
      },
      child: RegisterForm(),
    );
  }
}

class RegisterForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          state.authFailureOrSuccessOption.fold(() {}, (a) {
            late final String message;
            a.fold((l) {
              if (l is InvalidEmailFailure) {
                message = 'Invalid email';
              } else if (l is EmailAlreadyInUseFailure) {
                message = 'Email already in use';
              } else if (l is WeakPasswordFailure) {
                message = 'Weak password';
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
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: [
                  const SizedBox(height: 120),
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: Image.asset('images/icon.png'),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Create your account",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 35),
                  CustomTextField(
                    text: 'First name',
                    icon: const Icon(Icons.person_outlined),
                    onChanged: (value) {
                      context
                          .read<RegisterBloc>()
                          .add(FirstNameChanged(firstName: Name(value ?? '')));
                    },
                    validator: (value) {
                      return context
                          .read<RegisterBloc>()
                          .state
                          .firstName
                          .value
                          .fold((l) => 'The name must be at least 3 letters',
                              (r) => null);
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    text: 'Last name',
                    icon: const Icon(Icons.person_outlined),
                    onChanged: (value) {
                      context
                          .read<RegisterBloc>()
                          .add(LastNameChanged(lastName: Name(value ?? '')));
                    },
                    validator: (value) {
                      return context
                          .read<RegisterBloc>()
                          .state
                          .lastName
                          .value
                          .fold((l) => 'The name must be at least 3 letters',
                              (r) => null);
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    text: 'Email',
                    icon: const Icon(Icons.email_outlined),
                    onChanged: (value) {
                      context
                          .read<RegisterBloc>()
                          .add(EmailChanged(email: EmailAddress(value ?? '')));
                    },
                    validator: (value) {
                      return context
                          .read<RegisterBloc>()
                          .state
                          .email
                          .value
                          .fold((l) => 'Invalid Email', (r) => null);
                    },
                  ),
                  const SizedBox(height: 10),
                  PasswordTextField(
                      onChanged: (value) {
                        context
                            .read<RegisterBloc>()
                            .add(PasswordChanged(password: Password(value!)));
                      },
                      text: 'Password',
                      validator: (value) {
                        return context
                            .read<RegisterBloc>()
                            .state
                            .password
                            .value
                            .fold((l) => 'Invalid password', (r) => null);
                      }),
                  const SizedBox(height: 50),
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
                            context
                                .read<RegisterBloc>()
                                .add(RegisterSubmitted());
                          }
                        },
                        child: const Text("Register"),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account?"),
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Login"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
