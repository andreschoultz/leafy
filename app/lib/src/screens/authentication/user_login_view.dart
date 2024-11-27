import 'package:flutter/material.dart';

import '../../utils/constants/assets_constants.dart';
import 'widgets/user_login/login_btn_widget.dart';
import 'widgets/user_login/login_form_widget.dart';
import 'widgets/user_login/register_btn_widget.dart';

class UserLoginView extends StatelessWidget {
  UserLoginView({
    super.key,
  });

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static const routeName = '/user/authentication';

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(241, 245, 249, 1),
          surfaceTintColor: const Color.fromRGBO(241, 245, 249, 1),
          automaticallyImplyLeading: false, // Hides back btn
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
                          child: Image(image: AssetImage(Asset.flowers['loginHeader']!), fit: BoxFit.cover)),
                    ],
                  )),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 26),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /* ------ From Title Text ------ */
                            const Text(
                              'Log In',
                              style: TextStyle(fontSize: 36, fontWeight: FontWeight.w500),
                            ),
                            const Wrap(
                              children: [
                                Text(
                                  'Sprout into action! Log in with your account credentials to nurture your journey with Leafy.',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                                ),
                              ],
                            ),
                            /* ------ Form ------ */
                            Padding(
                              padding: const EdgeInsets.only(top: 40),
                              child: LoginForm(
                                formKey: _formKey,
                                emailController: _emailController,
                                passwordController: _passwordController,
                              ),
                            ),
                            const RegisterActionButton(),
                          ],
                        ),
                      ),
                      /* ------ Action Buttons ------ */
                      LoginButton(
                        formKey: _formKey,
                        emailController: _emailController,
                        passwordController: _passwordController,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}