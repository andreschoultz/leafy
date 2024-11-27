import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/forms/user_register_model.dart';
import '../../../../state/global_state.dart';
import '../../../../state/user_state.dart';
import '../../../plants/plant_list_view.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({
    super.key,
    required this.formData,
  });

  final RegisterFormData formData;

  Future<void> _onRegister(BuildContext context) async {
    if (formData.formKey.currentState?.validate() ?? false) {
      final registerResult = await Provider.of<UserModel>(context, listen: false).register(
          formData.emailController.text, formData.firstNameController.text, formData.surnameController.text, formData.passwordController.text);

      if (registerResult.error() == false && context.mounted) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const PlantListView()));
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
              onPressed: () => _onRegister(context),
              style: ButtonStyle(padding: WidgetStateProperty.all<EdgeInsets>(const EdgeInsets.all(14))),
              child: globalModel.isLoading
                  ? const CircularProgressIndicator(
                      color: Colors.white60,
                    )
                  : const Text('Register', style: TextStyle(fontSize: 24)),
            ),
          ),
        );
      },
    );
  }
}
