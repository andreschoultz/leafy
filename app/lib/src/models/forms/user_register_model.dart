import 'package:flutter/material.dart';

class RegisterFormData {
    const RegisterFormData({
    required this.formKey,
    required this.emailController,
    required this.firstNameController,
    required this.surnameController,
    required this.passwordController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController firstNameController;
  final TextEditingController surnameController;
  final TextEditingController passwordController;

  static RegisterFormData empty() {
    return RegisterFormData(
      formKey: GlobalKey<FormState>(),
      emailController: TextEditingController(),
      firstNameController: TextEditingController(),
      surnameController: TextEditingController(),
      passwordController: TextEditingController(),
      );
  }
}