import 'package:flutter/material.dart';

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
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    // Firebase Authentication導入後はここを書き換える
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    setState(() => _isLoading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("登録成功！（現在はデモ版です）"),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("新規登録"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 450),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [

                    const Icon(
                      Icons.person_add_alt_1,
                      size: 90,
                    ),

                    const SizedBox(height: 20),

                    Text(
                      "StudyAI",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      "アカウントを作成",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),
                    ),

                    const SizedBox(height: 35),

                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: "名前",
                        prefixIcon: Icon(Icons.person_outline),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "名前を入力してください";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 18),

                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: "メールアドレス",
                        prefixIcon: Icon(Icons.email_outlined),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "メールアドレスを入力してください";
                        }

                        if (!value.contains("@")) {
                          return "メールアドレスの形式が正しくありません";
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 18),

                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        labelText: "パスワード",
                        prefixIcon: const Icon(Icons.lock_outline),
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword =
                                  !_obscurePassword;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.length < 8) {
                          return "8文字以上入力してください";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 18),

                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: _obscureConfirmPassword,
                      decoration: InputDecoration(
                        labelText: "パスワード（確認）",
                        prefixIcon: const Icon(Icons.lock_reset),
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureConfirmPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureConfirmPassword =
                                  !_obscureConfirmPassword;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value != _passwordController.text) {
                          return "パスワードが一致しません";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 30),

                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: FilledButton(
                        onPressed:
                            _isLoading ? null : _register,
                        child: _isLoading
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(
                                "アカウントを作成",
                                style: TextStyle(fontSize: 18),
                              ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    Divider(color: color.outlineVariant),

                    const SizedBox(height: 18),

                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.login),
                      label: const Text("Googleで登録"),
                    ),

                    const SizedBox(height: 10),

                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.apple),
                      label: const Text("Appleで登録"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
