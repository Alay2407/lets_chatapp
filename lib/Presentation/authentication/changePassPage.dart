import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lets_chatapp/domain/bloc/auth/change_pass/changepass_bloc.dart';

import '../../constants/AppRoutes.dart';
import '../../constants/strings.dart';
import '../../core/colors/colors.dart';
import '../../core/mediaquery.dart';
import '../../getit_injector.dart';
import '../widgets/gradientBtn.dart';
import '../widgets/snackbar.dart';

class ChangePassPage extends StatelessWidget {
  ChangePassPage({super.key});

  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  ChangepassBloc changepassBloc = locator<ChangepassBloc>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent, systemStatusBarContrastEnforced: false, statusBarIconBrightness: Brightness.dark, statusBarBrightness: Brightness.dark));

    return BlocListener(
      bloc: changepassBloc,
      listener: (context, state) {
        if (state is ChangepassFinishedState) {
          Navigator.of(context).pushReplacementNamed(AppRoutes.homeScreen);
          showSnackbar(color: ColorManager.darkGrey, context: context, message: 'Password Changed');
        } else if (state is ChangepassErrorState) {
          print('error giving');
          showSnackbar(color: ColorManager.darkGrey, context: context, message: state.message.toString());
        }
      },
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 60),
                child: Text(
                  AppStrings.changePassword,
                  style: TextStyle(
                    fontSize: 18,
                    color: ColorManager.txtColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      AppStrings.currentPassword,
                      style: TextStyle(color: ColorManager.txtColor),
                    ),
                    TextFormField(
                      controller: currentPasswordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'required';
                        } else if (value.length < 8 || !RegExp(r'[!@#%^&*(),.?":{}|<>]').hasMatch(value)) {
                          if (!RegExp(r'[!@#%^&*(),.?":{}|<>]').hasMatch(value)) {
                            return 'Password need one special charactor';
                          }
                          return 'Password must be at least 8 characters long';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(AppStrings.newPassword,
                        style: TextStyle(
                          color: ColorManager.txtColor,
                        )),
                    TextFormField(
                      controller: newPasswordController,
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
                    BlocBuilder(
                      bloc: changepassBloc,
                      builder: (context, state) {
                        if (state is ChangepassLoadingState) {
                          return Center(child: const CircularProgressIndicator());
                        } else {
                          return GradientBtn(
                            text: AppStrings.save,
                            onpress: () {
                              final isValid = _formKey.currentState!.validate();
                              if (!isValid) {
                                return;
                              }

                              changepassBloc.add(
                                Changepass(
                                  currentPassword: currentPasswordController.text.toString(),
                                  newPassword: newPasswordController.text.toString(),
                                ),
                              );
                            },
                          );
                        }
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
