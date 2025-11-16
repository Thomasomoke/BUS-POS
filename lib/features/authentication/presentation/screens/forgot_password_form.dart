import 'package:bus_pos/common/widgets/app_button.dart';
import 'package:bus_pos/common/widgets/textfield_widget.dart';
import 'package:bus_pos/features/authentication/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final TextEditingController _operatorController = TextEditingController();
  final FocusNode _operatorFocus = FocusNode();

  void _submitForm() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState?.validate() ?? false) {
      Provider.of<AuthProvider>(context, listen: false).forgotPassword(
        _emailController.text.trim(),
        _operatorController.text.trim(),
      );
    } else {
      debugPrint("Validation failed");
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _emailFocus.dispose();
    _operatorController.dispose();
    _operatorFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, provider, child) {
        return Form(
          key: _formKey,
          child: Column(
            children: [
              TextfieldWidget(
                controller: _emailController,
                focusNode: _emailFocus,
                hintText: "john@example.com",
                isLoading: provider.isLoading,
                nextFocusNode: _operatorFocus,
                labelText: "Email",
              ),
              const SizedBox(height: 10.0),
              TextfieldWidget(
                controller: _operatorController,
                focusNode: _operatorFocus,
                hintText: "Operator name",
                isLoading: provider.isLoading,
                labelText: "Operator",
              ),
              const SizedBox(height: 16.0),
              AppButton(
                isLoading: provider.isLoading,
                onPressed: () => _submitForm(),
                text: "Send Reset Instructions",
              ),
              const SizedBox(height: 16.0),
              if (provider.successMessage != null)
                Text(
                  provider.successMessage!,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.green),
                  textAlign: TextAlign.center,
                ),
              if (provider.errorMessage != null)
                Text(
                  provider.errorMessage!,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
            ],
          ),
        );
      },
    );
  }
}
