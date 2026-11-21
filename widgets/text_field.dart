import 'package:flutter/material.dart';

enum InputFieldType { name, email, password, confirmPassword }

class CustomTextFormField extends StatefulWidget {
  final InputFieldType inputType;
  final String labelText;
  final String hintText;
  final Widget prefixIcon;
  final TextEditingController controller;
  final TextEditingController? passwordController;
  final TextInputAction textInputAction;
  final FocusNode? focusNode;
  final VoidCallback? onSubmitted;

  const CustomTextFormField({
    super.key,
    required this.inputType,
    required this.labelText,
    required this.hintText,
    required this.prefixIcon,
    required this.controller,
    this.passwordController,
    this.textInputAction = TextInputAction.next,
    this.focusNode,
    this.onSubmitted,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _hidePassword = true;

  bool get _isPassword =>
      widget.inputType == InputFieldType.password ||
          widget.inputType == InputFieldType.confirmPassword;

  String? _validator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Поле не может быть пустым';
    }

    switch (widget.inputType) {
      case InputFieldType.name:
        final reg = RegExp(r'^[A-Za-zА-Яа-яЁё\s]+$');
        if (!reg.hasMatch(value)) {
          return 'Имя должно содержать только буквы и пробелы';
        }
        return null;

      case InputFieldType.email:
        final reg = RegExp(r'^[^@\s]+@[^@\s.]+(\.[^@\s.]+)+$');
        if (!reg.hasMatch(value.trim())) {
          return 'Введите корректный email, например example@mail.com';
        }
        return null;

      case InputFieldType.password:
        if (value.length < 6) {
          return 'Пароль должен содержать не менее 6 символов';
        }
        if (!RegExp(r'[A-Za-zА-Яа-яЁё]').hasMatch(value)) {
          return 'Пароль должен содержать хотя бы одну букву';
        }
        if (!RegExp(r'\d').hasMatch(value)) {
          return 'Пароль должен содержать хотя бы одну цифру';
        }
        if (!RegExp(r'[+_\-]').hasMatch(value)) {
          return 'Пароль должен содержать хотя бы один символ: +, _ или -';
        }
        return null;

      case InputFieldType.confirmPassword:
        if (value != widget.passwordController?.text) {
          return 'Пароли не совпадают';
        }
        return null;
    }
  }

  OutlineInputBorder _border(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(24),
      borderSide: BorderSide(color: color, width: 1.5),
    );
  }

  TextInputType get _keyboardType {
    return widget.inputType == InputFieldType.email
        ? TextInputType.emailAddress
        : TextInputType.text;
  }

  void _handleSubmitted(String _) {
    if (widget.onSubmitted != null) {
      widget.onSubmitted!();
    } else {
      FocusScope.of(context).nextFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      obscureText: _isPassword && _hidePassword,
      keyboardType: _keyboardType,
      textInputAction: widget.textInputAction,
      onFieldSubmitted: _handleSubmitted,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: _validator,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: const TextStyle(color: Colors.black54, fontSize: 15),
        hintText: widget.hintText,
        hintStyle: const TextStyle(color: Colors.black38, fontSize: 14),
        prefixIcon: widget.prefixIcon,
        suffixIcon: _isPassword
            ? IconButton(
          icon: Icon(
            _hidePassword
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            color: Colors.black54,
          ),
          onPressed: () {
            setState(() => _hidePassword = !_hidePassword);
          },
        )
            : null,
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: _border(Colors.black),
        enabledBorder: _border(Colors.black),
        focusedBorder: _border(Colors.black),
        errorBorder: _border(Colors.red),
        focusedErrorBorder: _border(Colors.red),
        errorMaxLines: 2,
      ),
    );
  }
}