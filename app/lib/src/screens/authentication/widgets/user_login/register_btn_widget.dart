
import 'package:flutter/material.dart';

import '../../../users/user_register_view.dart';

class RegisterActionButton extends StatelessWidget {
  const RegisterActionButton({super.key});

  void onRegister(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => UserRegisterView()));    
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 26),
      child: Align(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Don' 't have an account?'),
            GestureDetector(
              onTap: () => onRegister(context),
              behavior: HitTestBehavior.opaque,
              child: const Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 50, vertical: 10), // Tiny wittle button hard to click, hooman adds padding. Happy user, happy dev (ﾉ◕ヮ◕)ﾉ*:･ﾟ✧
                child: Text(
                  'Register',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: Colors.blueGrey),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
