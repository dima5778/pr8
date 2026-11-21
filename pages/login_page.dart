import 'package:flutter/material.dart';
import '../routes.dart';
import '../services/auth_service.dart';
import '../widgets/text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      FocusScope.of(context).unfocus();
      final user = AuthService.login(
        _emailController.text,
        _passwordController.text,
      );
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Неверный email или пароль')),
        );
        return;
      }
      Navigator.of(context).pushReplacementNamed(
        Routes.home,
        arguments: user,
      );
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
                        const SizedBox(height: 72),
                        const Text(
                          'Добро пожаловать!\nВойдите в свой аккаунт\nИли создайте новый',
                          style: TextStyle(
                            fontSize: 18,
                            height: 1.3,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 48),
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
                          hintText: 'Введите пароль',
                          prefixIcon: const Icon(
                            Icons.security,
                            color: Colors.black,
                          ),
                          controller: _passwordController,
                          focusNode: _passwordFocus,
                          textInputAction: TextInputAction.done,
                          onSubmitted: _submit,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                                vertical: 8,
                              ),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: const Text(
                              'Забыли пароль?',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        Center(
                          child: SizedBox(
                            width: 180,
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
                                'Войти',
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
                              'Нет аккаунта? ',
                              style: TextStyle(fontSize: 13),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed(Routes.register);
                              },
                              child: const Text(
                                'Зарегистрируйтесь',
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