import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intern/services/authentication.dart';
import '../../widgets/widgets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final auth = AuthenticationMethods(FirebaseAuth.instance);

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

// registering the user with email and password
  registerUser({required String email, required String password}) async {
    await auth.signUpUserWithEmailAndPassword(
        email: email, password: password, context: context);
  }

  // register using google sign in
  signInWithGoogle() async {
    await auth.signInWithGoogle(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
        centerTitle: true,
        elevation: 2.0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                // the email textfield
                CustomTextField(
                  controller: emailController,
                  label: "Email",
                  obscureText: false,
                  hintText: "e.g admin@gmail.com",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter an email";
                    } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                      return "Please Enter a Valid Email";
                    }
                    return null;
                  },
                ),

                // the password textfield
                const SizedBox(
                  height: 12,
                ),
                CustomTextField(
                  controller: passwordController,
                  label: "Password",
                  obscureText: true,
                  validator: (value) {
                    bool hasSpecialCharacters =
                        value!.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
                    if (value.isEmpty || value.length < 8) {
                      return "Password must be greater the 8 characters";
                    } else if (!hasSpecialCharacters) {
                      return "Must have at least one special character";
                    }
                    return null;
                  },
                  hintText: "e.g qw23bdty",
                ),

                // the register button
                const SizedBox(
                  height: 18,
                ),
                CustomButton(
                  color: Colors.blueAccent.shade200,
                  title: "Register",
                  onTap: () async {
                    final email = emailController.text;
                    final password = passwordController.text;
                    if (formKey.currentState!.validate()) {
                      await registerUser(email: email, password: password);
                    }
                  },
                ),

                // the google sign in button
                const SizedBox(
                  height: 18,
                ),
                CustomButton(
                  color: Theme.of(context).colorScheme.primary,
                  title: "Continue with Google",
                  onTap: signInWithGoogle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
