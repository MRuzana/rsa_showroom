import 'package:flutter/material.dart';
import 'package:rsa_showroom/core/constants/spacing_constants.dart';
import 'package:rsa_showroom/core/constants/string_constants.dart';
import 'package:rsa_showroom/core/themes/text_styles.dart';
import 'package:rsa_showroom/core/validators.dart';
import 'package:rsa_showroom/services/login_services.dart';
import 'package:rsa_showroom/views/signup_screen.dart';
import 'package:rsa_showroom/views/widgets/button.dart';
import 'package:rsa_showroom/views/widgets/text_field.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            /// 🔹 TOP CONTENT
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: kpadding25,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset('assets/images/logo.png'),

                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Welcome',
                              style: AppTextStyles.heading1,
                            ),
                            WidgetSpan(child: kWidth5),
                            TextSpan(
                              text: 'RSA Showroom',
                              style: AppTextStyles.heading3,
                            ),
                          ],
                        ),
                      ),

                      Text(
                        signInDetails,
                        style: AppTextStyles.textSmallGrey,
                      ),

                      kHeight25,

                      /// 🔹 FORM
                      Form(
                        key: _formKey,
                        child: textField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          labelText: 'Enter Phone number',
                          suffixIcon: const Icon(Icons.phone),
                          validator: (value) =>
                              Validator.validatePhoneNumber(value),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            /// 🔹 BOTTOM SECTION
            Padding(
              padding: kpadding25,
              child: Column(
                children: [
                  // SIGN IN BUTTON
                  button(
                    buttonText: 'SIGN IN',
                    color: const Color(0xFFFF0000),
                    buttonPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final success = await LoginServices().sendLoginDetails(
                          phoneNumber: _phoneController.text.trim(),
                          showroomId: "694cc84328153b3d845b49ff",
                        );

                        if (success) {
                          Navigator.pushReplacementNamed(context, '/home');
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Login failed')),
                          );
                        }
                      }
                    },
                  ),

                  kHeight10,

                  /// SIGN UP TEXT
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: AppTextStyles.textSmallGrey,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const SignUpScreen(),
                            ),
                          );
                        },
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(context, '/signUp');
                          },
                          child: Text(
                            'Sign up',
                            style: AppTextStyles.textXSmallBold.copyWith(
                              color: const Color(0xFFFF0000),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  kHeight10,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
