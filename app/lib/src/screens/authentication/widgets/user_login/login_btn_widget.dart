import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../state/global_state.dart';
import '../../../../state/user_state.dart';
import '../../../plants/plant_details_view.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  Future<void> _onLogin(BuildContext context) async {
    if (formKey.currentState?.validate() ?? false) {
      final loginResult = await Provider.of<UserModel>(context, listen: false).login(emailController.text, passwordController.text);

      if (loginResult.error() == false && context.mounted) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const PlantMoreDetailsView()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalModel>(
      builder: (_, globalModel, __) {
        return Container(
          height: 60,
          alignment: Alignment.bottomCenter,
          child: SizedBox.expand(
            child: FilledButton(
              onPressed: () => _onLogin(context),
              style: ButtonStyle(padding: WidgetStateProperty.all<EdgeInsets>(const EdgeInsets.all(14))),
              child: globalModel.isLoading
                  ? const CircularProgressIndicator(
                      color: Colors.white60,
                    )
                  : const Text('Login', style: TextStyle(fontSize: 24)),
            ),
          ),
        );
      },
    );
  }
}