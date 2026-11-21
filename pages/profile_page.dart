import 'package:flutter/material.dart';
import '../routes.dart';
import '../services/auth_service.dart';
import '../widgets/text_field.dart';

class ProfilePage extends StatefulWidget {
  final AppUser user;
  final VoidCallback? onBack;

  const ProfilePage({super.key, required this.user, this.onBack});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late AppUser _user;
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmController;
  final _nameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _confirmFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _user = widget.user;
    _nameController = TextEditingController(text: _user.name);
    _emailController = TextEditingController(text: _user.email);
    _passwordController = TextEditingController(text: _user.password);
    _confirmController = TextEditingController(text: _user.password);
  }

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
      final updated = AppUser(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
      if (!AuthService.update(_user.email, updated)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Пользователь с таким email уже зарегистрирован'),
          ),
        );
        return;
      }
      _user = updated;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Данные профиля сохранены')),
      );
    }
  }

  void _logout() {
    Navigator.of(context).pushNamedAndRemoveUntil(
      Routes.login,
          (route) => false,
    );
  }

  void _goBack() {
    if (widget.onBack != null) {
      widget.onBack!();
    } else {
      _logout();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: _goBack,
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.chevron_left,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                      ),
                    ),
                    const Text(
                      'Профиль',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Center(
                  child: Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Icon(
                      Icons.photo_camera_outlined,
                      size: 44,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
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
                const SizedBox(height: 24),
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
                        'Сохранить',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: TextButton(
                    onPressed: _logout,
                    style: TextButton.styleFrom(foregroundColor: Colors.black),
                    child: const Text('Выйти из аккаунта'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}