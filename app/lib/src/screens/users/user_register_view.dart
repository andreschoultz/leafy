import 'package:flutter/material.dart';

import '../../models/forms/user_register_model.dart';
import '../../utils/constants/assets_constants.dart';
import 'widgets/user_register/register_btn_widget.dart';
import 'widgets/user_register/register_form_widget.dart';

class UserRegisterView extends StatelessWidget {
  UserRegisterView({super.key});

  final _formData = RegisterFormData.empty();

  static const routeName = '/user/register';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(241, 245, 249, 1),
        surfaceTintColor: const Color.fromRGBO(241, 245, 249, 1),
      ),
      body: Container(
        child: Column(
          children: [
            /* ------ Header Image ------ */
            Container(
                height: MediaQuery.of(context).viewInsets.bottom > 1 ? MediaQuery.of(context).viewInsets.bottom / 12 : 240,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Image container
                    Positioned(
                        left: 0,
                        right: 0,
                        top: -100,
                        bottom: -40,
                        child: Image(image: AssetImage(Asset.flowers['registerHeader']!), fit: BoxFit.cover)),
                    /* ------ Header Page Title ------ */
                    Positioned(
                      left: 110,
                      right: 110,
                      top: 50,
                      child: Container(
                        height: 100,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          color: Colors.white.withOpacity(0.6),
                        ),
                        child: const Text.rich(
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.black87),
                          TextSpan(children: [
                            TextSpan(text: 'REGISTER', style: TextStyle(fontSize: 36, fontWeight: FontWeight.w500)),
                            TextSpan(text: '\n Get your leafy on', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16)),
                          ]),
                        ),
                      ),
                    ),
                  ],
                )),
            /* ------ Forms & Action Buttons ------ */
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 34, right: 34, bottom: 26),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    /* ------ Form ------ */
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.only(bottom: 50),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(padding: const EdgeInsets.only(top: 40), child: RegisterForm(formData: _formData)),
                          ],
                        ),
                      ),
                    ),
                    /* ------ Action Buttons ------ */
                    RegisterButton(formData: _formData),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
