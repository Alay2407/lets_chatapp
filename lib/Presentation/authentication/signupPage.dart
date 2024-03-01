import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lets_chatapp/Presentation/screen/home_Screen.dart';
import 'package:lets_chatapp/Presentation/widgets/gradientBtn.dart';
import 'package:lets_chatapp/Presentation/widgets/header.dart';
import 'package:lets_chatapp/core/colors/colors.dart';
import 'package:lets_chatapp/constants/strings.dart';
import 'package:lets_chatapp/getit_injector.dart';

import '../../constants/AppRoutes.dart';
import '../../domain/bloc/auth/signup_bloc/signup_bloc.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passewordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  SignupBloc signupBloc = locator<SignupBloc>();

  final _formKey = GlobalKey<FormState>();

  void _submitForm() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    // _formKey.currentState!.save();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent, systemStatusBarContrastEnforced: false, statusBarIconBrightness: Brightness.dark, statusBarBrightness: Brightness.light));
    return BlocListener<SignupBloc, SignupState>(
      bloc: signupBloc,
      listener: (context, state) {
        if (state is SignupLoadingState) {
          const CircularProgressIndicator();
        }
        if (state is SignupFinishedState) {
          Navigator.of(context).pushReplacementNamed(AppRoutes.homeScreen);
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Row(
                children: [
                  Header(),
                ],
              ),
              Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 60),
                    child: Text(
                      AppStrings.signUp,
                      style: TextStyle(
                        fontSize: 18,
                        color: ColorManager.txtColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 19, left: 41, right: 41),
                    child: Text(AppStrings.welBackTxt),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 30, left: 28, right: 28),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Divider(),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 7),
                          child: Text(
                            AppStrings.OR,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ColorManager.lightgrey,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            AppStrings.yourName,
                            style: TextStyle(color: ColorManager.txtColor),
                          ),
                          TextFormField(
                            controller: nameController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'required';
                              } else if (value.length < 4) {
                                return 'Name must be at least 4 characters long';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          const Text(
                            AppStrings.yourEmail,
                            style: TextStyle(color: ColorManager.txtColor),
                          ),
                          TextFormField(
                            controller: emailController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'required';
                              } else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                                return 'Enter valid email address';
                              }

                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          const Text(AppStrings.password,
                              style: TextStyle(
                                color: ColorManager.txtColor,
                              )),
                          TextFormField(
                            controller: passewordController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'required';
                              } else if (value.length < 6) {
                                return 'Password must be at least 6 characters long';
                              }
                              return null;
                            },
                            obscureText: true,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          const Text(
                            AppStrings.conPassword,
                            style: TextStyle(color: ColorManager.txtColor),
                          ),
                          TextFormField(
                            controller: confirmPasswordController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'required';
                              } else if (value != passewordController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                            obscureText: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.011),
                  BlocBuilder(
                    bloc: signupBloc,
                    builder: (context, state) {
                      if (state is SignupLoadingState) {
                        return const CircularProgressIndicator();
                      } else {
                        return GradientBtn(
                          text: AppStrings.createAcc,
                          onpress: () {
                            // _submitForm();
                            // signupBloc.add(
                            //   SignupUser(
                            //     name: nameController.text.toString(),
                            //     email: emailController.text.toString(),
                            //     password: passewordController.text.toString(),
                            //     confirmPassword: confirmPasswordController.text.toString(),
                            //   ),
                            // );

                            final isValid = _formKey.currentState!.validate();
                            if (!isValid) {
                              return;
                            }
                            signupBloc.add(
                              SignupUser(
                                name: nameController.text.toString(),
                                email: emailController.text.toString(),
                                password: passewordController.text.toString(),
                                confirmPassword: confirmPasswordController.text.toString(),
                              ),
                            );
                            print('clicked');
                          },
                        );
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
