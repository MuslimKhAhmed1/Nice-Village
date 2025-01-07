import 'package:flutter/material.dart';
import 'package:nice_village/Localization/app_localizations.dart';
import 'package:nice_village/screens/HomePageMain_screen.dart';
import 'package:nice_village/screens/forgetPassword_screen.dart';
import 'package:nice_village/widgets/customTextFields.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _houseNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _houseNumberController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<bool> _validateHouseNumber(String houseNumber, String email) async {
    try {
      // Query users collection where both house number and email match
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('houseNumber', isEqualTo: houseNumber)
          .where('email', isEqualTo: email)
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error validating house number: $e');
      return false;
    }
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);

      try {
        // First validate house number matches email
        bool isValidHouseNumber = await _validateHouseNumber(
          _houseNumberController.text,
          _emailController.text,
        );

        if (!isValidHouseNumber) {
          throw FirebaseAuthException(
            code: 'invalid-house-number',
            message:
                'Invalid house number or house number does not match email.',
          );
        }

        // Attempt Firebase authentication
        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        // Fetch user data after successful login
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .where('email', isEqualTo: _emailController.text)
            .get();

        if (userDoc.docs.isEmpty) {
          throw FirebaseAuthException(
            code: 'user-not-found',
            message: 'User data not found.',
          );
        }

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  AppLocalizations.of(context)?.translate('login_success') ??
                      'Login successful'),
              backgroundColor: Colors.green,
            ),
          );

          // Navigate to home page after successful login
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePageMain()),
            );
          });
        }
      } on FirebaseAuthException catch (e) {
        String message = '';
        switch (e.code) {
          case 'INVALID_LOGIN_CREDENTIALS':
            message = 'Invalid email or password.';
            break;
          case 'invalid-house-number':
            message = 'Invalid house number or does not match email.';
            break;
          case 'user-not-found':
            message = 'No user found with this email.';
            break;
          case 'wrong-password':
            message = 'Wrong password provided.';
            break;
          case 'user-disabled':
            message = 'This account has been disabled.';
            break;
          default:
            message = 'An error occurred. Please try again.';
        }

        if (mounted) {
          Fluttertoast.showToast(
            msg: message,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.SNACKBAR,
            backgroundColor: Colors.black54,
            textColor: Colors.white,
            fontSize: 14.0,
          );
        }
      } catch (e) {
        if (mounted) {
          Fluttertoast.showToast(
            msg: 'An unexpected error occurred. Please try again.',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.SNACKBAR,
            backgroundColor: Colors.black54,
            textColor: Colors.white,
            fontSize: 14.0,
          );
        }
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),
                Text(
                  AppLocalizations.of(context)?.translate('login') ?? 'Login',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                CustomTextField(
                  hintText:
                      AppLocalizations.of(context)?.translate('house_number') ??
                          'House Number',
                  controller: _houseNumberController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return AppLocalizations.of(context)
                              ?.translate('house_number_required') ??
                          'House number is required';
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  hintText: AppLocalizations.of(context)
                          ?.translate('email_username') ??
                      'Enter your email / username',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return AppLocalizations.of(context)
                              ?.translate('email_required') ??
                          'Email/username is required';
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  hintText:
                      AppLocalizations.of(context)?.translate('password') ??
                          'Enter your password',
                  controller: _passwordController,
                  isPassword: true,
                  obscureText: _obscurePassword,
                  onToggleVisibility: () {
                    setState(() => _obscurePassword = !_obscurePassword);
                  },
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return AppLocalizations.of(context)
                              ?.translate('password_required') ??
                          'Password is required';
                    }
                    return null;
                  },
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ForgotPasswordScreen()),
                      );
                    },
                    child: Text(
                      AppLocalizations.of(context)
                              ?.translate('forgot_password') ??
                          'Forgot Password?',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _isLoading ? null : _handleLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).secondaryHeaderColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                          AppLocalizations.of(context)?.translate('login') ??
                              'Login',
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white),
                        ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePageMain(),
                    ),
                  ),
                  child: Text("guest"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
