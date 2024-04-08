// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:login/modules/home/home_screens.dart';
import 'package:login/modules/login/cubit/cubit.dart';
import 'package:login/modules/login/cubit/states.dart';
import 'package:login/shared/components/custom_text_field.dart';

import 'package:cubit_form/cubit_form.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen(userName: state.model.userName!, levelId: state.model.lEVELID!, branch: state.model.bRANCH!, personnelNumber:  state.model.pERSONNELNUMBER!,)),


            );

            FlutterToastr.show(
              "Welcome! You've successfully logged in.",
              context,
              backgroundColor: Colors.green,
              duration: FlutterToastr.lengthShort,
              position: FlutterToastr.bottom,
            );
          }
          if (state is LoginErrorState) {
            FlutterToastr.show(
              'Invalid Username or Password. Please try again.',
              context,
              backgroundColor: Colors.red,
              duration: FlutterToastr.lengthShort,
              position: FlutterToastr.bottom,
            );
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          return Scaffold(
            body: SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 100),
                            Text(
                              'Welcome Back!',
                              style: GoogleFonts.josefinSans(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Login to your account',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 40),
                            CustomTextField(
                              controller: emailController,
                              prefix: Icons.person_outline,
                              type: TextInputType.emailAddress,
                              hintText: 'Enter your email',
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your email';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            CustomTextField(
                              controller: passwordController,
                              prefix: Icons.lock_outline,
                              suffix: cubit.iconData,
                              isPassword: cubit.isPassword,
                              
                              hintText: 'Enter your password',
                              suffixPressed: () {
                                cubit.passwordVisibility();
                              },
                              type: TextInputType.text,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  cubit.userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  cubit.userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              child: Text('Login'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}