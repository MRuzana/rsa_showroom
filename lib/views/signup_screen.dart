import 'package:flutter/material.dart';
import 'package:rsa_showroom/core/constants/spacing_constants.dart';
import 'package:rsa_showroom/core/constants/string_constants.dart';
import 'package:rsa_showroom/core/themes/text_styles.dart';
import 'package:rsa_showroom/core/validators.dart';
import 'package:rsa_showroom/services/login_services.dart';
import 'package:rsa_showroom/views/widgets/button.dart';
import 'package:rsa_showroom/views/widgets/text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _designationController = TextEditingController();
  final TextEditingController _watsappController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _nameController.dispose();
    _designationController.dispose();
    _watsappController.dispose();
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
                              text: 'SIGN UP',
                              style: AppTextStyles.heading3,
                            ),
                          ],
                        ),
                      ),

                      Text(
                        signUpDetails,
                        style: AppTextStyles.textSmallGrey,
                      ),

                      kHeight25,

                      /// 🔹 FORM
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            textField(
                              controller: _nameController,
                              keyboardType: TextInputType.name,
                              labelText: 'Enter name',
                              suffixIcon: const Icon(Icons.person),
                              validator: (value) =>
                                  Validator.validateNotEmpty(value),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                            ),
                            kHeight10,
                            textField(
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                              labelText: 'Enter Phone number',
                              suffixIcon: const Icon(Icons.phone),
                              validator: (value) =>
                                  Validator.validatePhoneNumber(value),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                            ),
                            kHeight10,
                            textField(
                              controller: _watsappController,
                              keyboardType: TextInputType.phone,
                              labelText: 'Enter watsapp number',
                              suffixIcon: const Icon(Icons.phone),
                              validator: (value) =>
                                  Validator.validatePhoneNumber(value),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                            ),
                            kHeight10,
                            textField(
                              controller: _designationController,
                              keyboardType: TextInputType.name,
                              labelText: 'Enter designation',
                              suffixIcon: const Icon(Icons.work),
                              validator: (value) =>
                                  Validator.validateNotEmpty(value),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                            ),
                          ],
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
                    buttonText: 'SIGN UP',
                    color: const Color(0xFFFF0000),
                    buttonPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final success = await LoginServices().sendSignUpDetails(
                          name: _nameController.text.trim(),
                          phone: _phoneController.text.trim(),
                          designation: _designationController.text.trim(),
                          whatsappNumber: _watsappController.text.trim(),
                          showroomId: '694cc84328153b3d845b49ff',
                        );

                        if (success) {
                          //  SUCCESS MESSAGE
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Signup successful! Please login.'),
                              backgroundColor: Colors.green,
                            ),
                          );

                          // Optional: navigate to login after delay
                          Future.delayed(const Duration(seconds: 1), () {
                            Navigator.pushReplacementNamed(context, '/signIn');
                          });
                        } else {

                          //  USER EXISTS / FAILED
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text('User already exists. Please login.'),
                              backgroundColor: Colors.red,
                            ),
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
                        "Already have an account? ",
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
                            Navigator.pushReplacementNamed(context, '/signIn');
                          },
                          child: Text(
                            'Sign in',
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
