import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lets_chatapp/Presentation/widgets/gradientBtn.dart';
import 'package:lets_chatapp/Presentation/widgets/header.dart';
import 'package:lets_chatapp/core/colors/colors.dart';
import 'package:lets_chatapp/constants/strings.dart';
import 'package:lets_chatapp/domain/bloc/auth/login_bloc/login_bloc.dart';

import '../../constants/AppRoutes.dart';
import '../../core/mediaquery.dart';
import '../../getit_injector.dart';
import '../widgets/snackbar.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  LoginBloc loginBloc = locator<LoginBloc>();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemStatusBarContrastEnforced: false,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );
    return BlocListener<LoginBloc, LoginState>(
      bloc: loginBloc,
      listener: (context, state) {
        if (state is LoginFinishedState) {
          Navigator.of(context).pushReplacementNamed(AppRoutes.homeScreen);
          showSnackbar(color: ColorManager.darkGrey, context: context, message: 'Login Successfully');
        } else if (state is LoginErrorState) {
          print('error giving');
          showSnackbar(color: ColorManager.darkGrey, context: context, message: state.message.toString());
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
                      AppStrings.loginToChatBox,
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            AppStrings.yourEmail,
                            style: TextStyle(color: ColorManager.txtColor),
                          ),
                          TextFormField(
                            controller: emailController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'required';
                              } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                                return 'required @ and .in,.com,etc.. ';
                              }
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
                            controller: passwordController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'required';
                              } else if (value.length < 6 || !RegExp(r'[!@#%^&*(),.?":{}|<>]').hasMatch(value)) {
                                if (!RegExp(r'[!@#%^&*(),.?":{}|<>]').hasMatch(value)) {
                                  return 'Password need one special charactor';
                                }
                                return 'Password must be at least 6 characters long';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: kHeight(context) * 0.011,
                          ),
                        ],
                      ),
                    ),
                  ),
                  BlocBuilder(
                    bloc: loginBloc,
                    builder: (context, state) {
                      if (state is LoginLoadingState) {
                        return CircularProgressIndicator();
                      }
                      // else if(state is LoginErrorState){
                      //   return GradientBtn(
                      //     text: AppStrings.login,
                      //     onpress: () {
                      //
                      //
                      //       loginBloc.add(LoginUser(
                      //         email: emailController.text.toString(),
                      //         password: passwordController.text.toString(),
                      //       ));
                      //     },
                      //   );
                      // }
                      else {
                        return GradientBtn(
                          text: AppStrings.login,
                          onpress: () {
                            final isValid = _formKey.currentState!.validate();
                            if (!isValid) {
                              return;
                            }
                            loginBloc.add(LoginUser(
                              email: emailController.text.toString(),
                              password: passwordController.text.toString(),
                            ));
                          },
                        );
                      }
                    },
                  ),
                  BlocBuilder(
                    bloc: loginBloc,
                    builder: (context, state) {
                      if (state is LoginLoadingState) {
                        return Container();
                      }
                      return const Center(
                        child: Text(
                          AppStrings.forgetPass,
                          style: TextStyle(color: ColorManager.txtColor),
                        ),
                      );
                    },
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
                    padding: const EdgeInsets.only(top: 38),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                            radius: 24,
                            backgroundColor: ColorManager.darkGrey,
                            child: SvgPicture.asset(
                              SvgString.facebook,
                            )),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: CircleAvatar(radius: 24, backgroundColor: ColorManager.darkGrey, child: SvgPicture.asset(SvgString.google)),
                        ),
                        CircleAvatar(
                            radius: 24,
                            backgroundColor: ColorManager.darkGrey,
                            child: SvgPicture.asset(
                              SvgString.apple,
                              color: ColorManager.white,
                            )),
                      ],
                    ),
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
