import 'package:bus_pos/core/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class TextfieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;
  final bool isPassword;
  final bool isEmail;
  final String hintText;
  final String? labelText;
  final bool isLoading;
  final int? minimumCharacters;
  final bool isUsername;
  final TextInputType keyboardType;
  final bool isRequired;

  const TextfieldWidget({
    super.key,
    required this.controller,
    required this.focusNode,
    this.nextFocusNode,
    this.isPassword = false,
    this.isEmail = false,
    this.isUsername = false,
    required this.hintText,
    this.labelText,
    required this.isLoading,
    this.minimumCharacters,
    this.keyboardType = TextInputType.text,
    this.isRequired = true,
  });

  @override
  State<TextfieldWidget> createState() => _TextfieldWidgetState();
}

class _TextfieldWidgetState extends State<TextfieldWidget> {
  bool obscureText = true;

  void toggleVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  String? _validator(String? value) {
    String fieldName = widget.labelText ?? widget.hintText;

    if (widget.isRequired) {
      final requiredCheck = requiredField(value, fieldName: fieldName);
      if (requiredCheck != null) return requiredCheck;
    } else {
      if (value == null || value.trim().isEmpty) return null;
    }

    if (widget.minimumCharacters != null) {
      final minCheck = minLength(
        value,
        widget.minimumCharacters!,
        fieldName: fieldName,
      );
      if (minCheck != null) return minCheck;
    }

    if (widget.isEmail) {
      final emailCheck = emailValidator(value, fieldName: fieldName);
      if (emailCheck != null) return emailCheck;
    }

    if (widget.isPassword) {
      final passCheck = passwordValidator(value, fieldName: fieldName);
      if (passCheck != null) return passCheck;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.isEmail
          ? TextInputType.emailAddress
          : widget.keyboardType,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      controller: widget.controller,
      focusNode: widget.focusNode,
      readOnly: widget.isLoading,
      obscureText: widget.isPassword ? obscureText : false,
      textInputAction: widget.nextFocusNode != null
          ? TextInputAction.next
          : TextInputAction.done,
      style: Theme.of(context).textTheme.labelSmall,
      validator: _validator,
      onFieldSubmitted: (_) {
        if (widget.nextFocusNode != null) {
          FocusScope.of(context).requestFocus(widget.nextFocusNode);
        } else {
          FocusScope.of(context).unfocus();
        }
      },
      cursorColor: Theme.of(context).primaryColor,
      decoration: InputDecoration(
        prefixIcon: widget.isPassword
            ? Icon(
                Icons.lock_outline,
                size: 20,
                color: Theme.of(context).cardColor,
              )
            : widget.isEmail
            ? Icon(
                Icons.email_outlined,
                size: 20,
                color: Theme.of(context).cardColor,
              )
            : widget.isUsername
            ? Icon(
                Icons.person_outline_outlined,
                size: 20,
                color: Theme.of(context).cardColor,
              )
            : null,
        suffixIcon: widget.isPassword
            ? GestureDetector(
                onTap: toggleVisibility,
                child: Icon(
                  obscureText ? Iconsax.eye_outline : Iconsax.eye_slash_outline,
                  color: Theme.of(context).cardColor,
                ),
              )
            : null,

        hintText: widget.hintText,
        hintStyle: Theme.of(context).textTheme.labelSmall,
        labelStyle: Theme.of(
          context,
        ).textTheme.labelSmall!.copyWith(color: Theme.of(context).primaryColor),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.0),
          borderSide: BorderSide(
            width: 0.5,
            color: Theme.of(context).primaryColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.0),
          borderSide: BorderSide(
            width: 0.5,
            color: Theme.of(context).cardColor,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.0),
          borderSide: BorderSide(
            width: 0.5,
            color: Theme.of(context).colorScheme.error,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.0),
          borderSide: BorderSide(
            width: 0.5,
            color: Theme.of(context).colorScheme.error,
          ),
        ),
      ),
    );
  }
}
