import 'package:bus_pos/common/widgets/app_button.dart';
import 'package:bus_pos/common/widgets/page_layout.dart';
import 'package:bus_pos/common/widgets/textfield_widget.dart';
import 'package:bus_pos/features/authentication/providers/auth_provider.dart';
import 'package:bus_pos/features/authentication/presentation/screens/forgot_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final FocusNode _nameFocus = FocusNode();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _passwordFocus = FocusNode();

  @override
  void dispose() {
    _nameController.dispose();
    _nameFocus.dispose();
    _passwordController.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  void _login() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState?.validate() ?? false) {
      Provider.of<AuthProvider>(
        context,
        listen: false,
      ).login(context, _nameController.text, _passwordController.text.trim());
    } else {
      debugPrint("Validation failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      showBackButton: false,
      child: Consumer<AuthProvider>(
        builder: (context, provider, child) {
          return Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Welcome Back, Please enter your details",
                  style: Theme.of(context).textTheme.displaySmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16.0),
                TextfieldWidget(
                  isUsername: true,
                  controller: _nameController,
                  focusNode: _nameFocus,
                  hintText: "John Doe",
                  isLoading: provider.isLoading,
                  nextFocusNode: _passwordFocus,
                  labelText: "Username",
                ),
                const SizedBox(height: 10.0),
                TextfieldWidget(
                  controller: _passwordController,
                  focusNode: _passwordFocus,
                  hintText: "********",
                  isLoading: provider.isLoading,
                  isPassword: true,
                  labelText: "Password",
                  minimumCharacters: 6,
                ),
                const SizedBox(height: 10.0),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgotPasswordScreen(),
                        ),
                      ),
                      child: Text(
                        "Forgot Password?",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16.0),
                AppButton(
                  isLoading: provider.isLoading,
                  onPressed: () => _login(),
                  text: "Login",
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
