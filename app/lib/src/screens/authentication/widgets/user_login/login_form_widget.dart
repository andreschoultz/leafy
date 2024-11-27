import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../state/global_state.dart';
import '../../../../utils/validators/input_validator.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  State<LoginForm> createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  @override
  void initState() {
    super.initState();
    _formKey = widget.formKey;
    _emailController = widget.emailController;
    _passwordController = widget.passwordController;
  }

  late GlobalKey<FormState> _formKey;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

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
        key: _formKey,
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
              controller: _emailController,
              enabled: !globalModel.isLoading,
              validator: (String? value) {
                return InputValidator.email(value);
              },
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 18)),
            TextFormField(
              keyboardType: TextInputType.text,
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
              controller: _passwordController,
              enabled: !globalModel.isLoading,
              validator: (String? value) {
                return InputValidator.password(value);
              },
            ),
          ],
        ),
      );
    });
  }
}
