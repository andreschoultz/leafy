import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/forms/user_register_model.dart';
import '../../../../state/global_state.dart';
import '../../../../utils/validators/input_validator.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({
    super.key,
    required this.formData,
  });

  final RegisterFormData formData;
  
  @override
  State<RegisterForm> createState() => RegisterFormState();
}

class RegisterFormState extends State<RegisterForm> {
  @override
  void initState() {
    super.initState();
    _formData = widget.formData;
  }

  late RegisterFormData _formData;

  bool _showPassword = false;

  void _setPasswordVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalModel>(builder: (_, globalModel, __) {
      return Form(
        key: _formData.formKey,
        child: Column(
          children: [
            (globalModel.isError && globalModel.message != null)
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      globalModel.message ?? 'Something went wrong, please try again.',
                      style: const TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  )
                : const SizedBox.shrink(),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'Email'),
              controller: _formData.emailController,
              enabled: !globalModel.isLoading,
              validator: (String? value) {
                return InputValidator.email(value);
              },
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            TextFormField(
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'Name',),
              controller: _formData.firstNameController,
              enabled: !globalModel.isLoading,
              validator: (String? value) {
                return InputValidator.name(value);
              },
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            TextFormField(
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'Surname (optional)'),
              controller: _formData.surnameController,
              enabled: !globalModel.isLoading,
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return null;
                }

                return InputValidator.name(value);
              },
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            TextFormField(
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              obscureText: !_showPassword,
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: IconButton(
                    onPressed: _setPasswordVisibility,
                    icon: Icon(
                      _showPassword ? Icons.visibility_off : Icons.visibility,
                      color: Theme.of(context).buttonTheme.colorScheme?.primary ?? Colors.green,
                    )),
              ),
              controller: _formData.passwordController,
              enabled: !globalModel.isLoading,
              validator: (String? value) {
                return InputValidator.password(value);
              },
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            TextFormField(
              keyboardType: TextInputType.text,
              obscureText: !_showPassword,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                suffixIcon: IconButton(
                    onPressed: _setPasswordVisibility,
                    icon: Icon(
                      _showPassword ? Icons.visibility_off : Icons.visibility,
                      color: Theme.of(context).buttonTheme.colorScheme?.primary ?? Colors.green,
                    )),
              ),
              enabled: !globalModel.isLoading,
              onEditingComplete: () => _formData.formKey.currentState?.validate(),
              validator: (String? value) {
                if (value != _formData.passwordController.text) {
                  return 'Passwords do not match';
                }

                return null;
              },
            ),
          ],
        ),
      );
    });
  }
}