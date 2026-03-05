import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  StateMachineController? controller;
  SMIInput<bool>? isChecking;
  SMIInput<double>? numLook;
  SMIInput<bool>? isHandsUp;
  SMITrigger? trigSuccess;
  SMITrigger? trigFail;

  @override
  void initState() {
    super.initState();
    emailFocusNode.addListener(emailFocus);
    passwordFocusNode.addListener(passwordFocus);
    emailController.addListener(updateLook);
    passwordController.addListener(updateLook);
  }

  @override
  void dispose() {
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void emailFocus() {
    isChecking?.change(emailFocusNode.hasFocus);
  }

  void passwordFocus() {
    isHandsUp?.change(passwordFocusNode.hasFocus);
  }

  void updateLook() {
    if (emailFocusNode.hasFocus) {
      numLook?.change(emailController.text.length.toDouble() * 2);
    }
  }

  void login() {
    emailFocusNode.unfocus();
    passwordFocusNode.unfocus();

    // Simulate login
    if (emailController.text == 'test@test.com' &&
        passwordController.text == '1234') {
      trigSuccess?.fire();
    } else {
      trigFail?.fire();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD6E2EA),
      body: SafeArea(
        child: Stack(
          children: [
            // Animation Background
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 200.0),
                child: RiveAnimation.asset(
                  'assets/animated_login_character.riv',
                  fit: BoxFit.contain,
                  stateMachines: const ['Login Machine'],
                  onInit: (artboard) {
                    controller = StateMachineController.fromArtboard(
                      artboard,
                      'Login Machine',
                    );
                    if (controller != null) {
                      artboard.addController(controller!);
                      isChecking = controller!.findInput('isChecking');
                      numLook = controller!.findInput('numLook');
                      isHandsUp = controller!.findInput('isHandsUp');
                      trigSuccess =
                          controller!.findInput<bool>('trigSuccess')
                              as SMITrigger?;
                      trigFail =
                          controller!.findInput<bool>('trigFail')
                              as SMITrigger?;
                    }
                  },
                ),
              ),
            ),

            // Text Header
            const Positioned(
              top: 40,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Text(
                    'Animated Guardian\nPolar Bear',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF5A6B7A),
                    ),
                  ),
                ],
              ),
            ),

            // Login UI Card
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(left: 24, right: 24, bottom: 40),
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: emailController,
                      focusNode: emailFocusNode,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        filled: true,
                        fillColor: Colors.grey[200],
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 16.0,
                          horizontal: 16.0,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: passwordController,
                      focusNode: passwordFocusNode,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        filled: true,
                        fillColor: Colors.grey[200],
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 16.0,
                          horizontal: 16.0,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[500],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
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
