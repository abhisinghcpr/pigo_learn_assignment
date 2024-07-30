import 'package:flutter/material.dart';
import 'package:flutter_task/view/screens/auth/signup/signup_screen.dart';
import 'package:provider/provider.dart';
import '../../../../controller/provider/auth_provider.dart';
import '../../../utils/colors/app_color.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_redirect.dart';
import '../../../widgets/custom_textfield.dart';
import '../../home/home_screen.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'e-Shop',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Spacer(
                  flex: 2,
                ),
                CustomTextField(
                  controller: _emailController,
                  hintText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  controller: _passwordController,
                  hintText: 'Password',
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                ),
                const Spacer(
                  flex: 4,
                ),
                CustomButton(
                  text: 'Login',
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      Provider.of<AuthProvider>(context, listen: false)
                          .signIn(
                        _emailController.text,
                        _passwordController.text,
                      )
                          .then((success) {
                        if (success) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomePage(),
                              ));
                        } else {
                          final errorMessage =
                              Provider.of<AuthProvider>(context, listen: false)
                                  .errorMessage;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(errorMessage)),
                          );
                        }
                      });
                    }
                  },
                ),
                CustomRedirect(
                  message: 'New Here? ',
                  linkText: 'SignUp',
                  Navigate: SignupPage(),
                ),

                const Spacer(
                  flex: 1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
