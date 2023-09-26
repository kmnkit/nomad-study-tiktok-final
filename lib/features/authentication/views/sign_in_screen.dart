import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:study_final/constants/routes.dart';
import 'package:study_final/features/authentication/view_models/sign_in_view_model.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  String _email = "";
  String _password = "";

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController()
      ..addListener(() {
        _email = _emailController.text;
      });
    _passwordController = TextEditingController()
      ..addListener(() {
        _password = _passwordController.text;
      });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (!ref.watch(signInProvider).isLoading) {
      if (_formKey.currentState != null) {
        if (_formKey.currentState!.validate()) {
          ref.read(signInForm.notifier).state = {
            'email': _email,
            'password': _password,
          };
          ref.read(signInProvider.notifier).signIn(context);
        }
      }
    }
  }

  String? _emailValidator(String? value) {
    final regExp =
        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (value == null || value.isEmpty || !regExp.hasMatch(value)) {
      return "Invalid Email";
    }
    return null;
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.length < 8) {
      return "Password must be at least 8 characters";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "🔥 MOOD 🔥",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: width * 3 / 4,
            child: Column(
              children: [
                const SizedBox(
                  height: 80,
                ),
                Title(
                  color: Theme.of(context).primaryColor,
                  child: const Text(
                    "Welcome!",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        autocorrect: false,
                        controller: _emailController,
                        onChanged: _emailValidator,
                        decoration: const InputDecoration(
                          hintText: "Email",
                          contentPadding: EdgeInsets.only(left: 24),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(45),
                            ),
                          ),
                        ),
                        validator: _emailValidator,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        autocorrect: false,
                        controller: _passwordController,
                        obscureText: true,
                        onChanged: _passwordValidator,
                        decoration: const InputDecoration(
                          hintText: "Password",
                          contentPadding: EdgeInsets.only(left: 24),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(45),
                            ),
                          ),
                        ),
                        validator: _passwordValidator,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      ElevatedButton(
                        onPressed: _onSubmit,
                        child: const Text(
                          "Enter",
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () => context.go(RoutePath.signUp),
                  child: const Text(
                    "Create Account 🚀",
                  ),
                ),
                const SizedBox(
                  height: 36,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
