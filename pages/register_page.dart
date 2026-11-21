import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../widgets/text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  final _nameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _confirmFocus = FocusNode();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    _nameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _confirmFocus.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      FocusScope.of(context).unfocus();
      final user = AppUser(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
      if (!AuthService.register(user)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Пользователь с таким email уже зарегистрирован'),
          ),
        );
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Регистрация выполнена. Войдите в аккаунт')),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 56),
                        const Text(
                          'Регистрация',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 32),
                        CustomTextFormField(
                          inputType: InputFieldType.name,
                          labelText: 'ФИО',
                          hintText: 'Иванов Иван Иванович',
                          prefixIcon: const Icon(
                            Icons.person_outline,
                            color: Colors.black,
                          ),
                          controller: _nameController,
                          focusNode: _nameFocus,
                          textInputAction: TextInputAction.next,
                          onSubmitted: () => _emailFocus.requestFocus(),
                        ),
                        const SizedBox(height: 16),
                        CustomTextFormField(
                          inputType: InputFieldType.email,
                          labelText: 'Email',
                          hintText: 'example@mail.com',
                          prefixIcon: const Icon(
                            Icons.mail_outline,
                            color: Colors.black,
                          ),
                          controller: _emailController,
                          focusNode: _emailFocus,
                          textInputAction: TextInputAction.next,
                          onSubmitted: () => _passwordFocus.requestFocus(),
                        ),
                        const SizedBox(height: 16),
                        CustomTextFormField(
                          inputType: InputFieldType.password,
                          labelText: 'Пароль',
                          hintText: 'Не менее 6 символов, буквы, цифры, + _ -',
                          prefixIcon: const Icon(
                            Icons.security,
                            color: Colors.black,
                          ),
                          controller: _passwordController,
                          focusNode: _passwordFocus,
                          textInputAction: TextInputAction.next,
                          onSubmitted: () => _confirmFocus.requestFocus(),
                        ),
                        const SizedBox(height: 16),
                        CustomTextFormField(
                          inputType: InputFieldType.confirmPassword,
                          labelText: 'Повторите пароль',
                          hintText: 'Повторите пароль',
                          prefixIcon: const Icon(
                            Icons.security,
                            color: Colors.black,
                          ),
                          controller: _confirmController,
                          passwordController: _passwordController,
                          focusNode: _confirmFocus,
                          textInputAction: TextInputAction.done,
                          onSubmitted: _submit,
                        ),
                        const SizedBox(height: 32),
                        Center(
                          child: SizedBox(
                            width: 220,
                            height: 48,
                            child: ElevatedButton(
                              onPressed: _submit,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                              ),
                              child: const Text(
                                'Зарегистрироваться',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Уже есть аккаунт? ',
                              style: TextStyle(fontSize: 13),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.of(context).pop(),
                              child: const Text(
                                'Войдите',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}