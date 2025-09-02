import 'package:flutter/material.dart';
import 'login.dart';
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  static const primary = Color(0xFFFF5A36);

  final _name     = TextEditingController();
  final _mobile   = TextEditingController(); // ✅ مۆبایل نوێ
  final _email    = TextEditingController();
  final _pass     = TextEditingController();
  final _confirm  = TextEditingController();

  bool _obscurePass = true;
  bool _obscureConfirm = true;
  String? _error;

  void _submit() {
    setState(() => _error = null);

    // ڕاستکردنەوەی سادە
    if (_name.text.trim().isEmpty ||
        _mobile.text.trim().isEmpty ||
        _email.text.trim().isEmpty ||
        _pass.text.isEmpty ||
        _confirm.text.isEmpty) {
      setState(() => _error = 'Please fill all fields.');
      return;
    }
    if (_mobile.text.trim().length < 7) {
      setState(() => _error = 'Enter a valid mobile number.');
      return;
    }
    if (_pass.text.length < 6) {
      setState(() => _error = 'Password must be at least 6 characters.');
      return;
    }
    if (_pass.text != _confirm.text) {
      setState(() => _error = 'Passwords do not match.');
      return;
    }

    // TODO: API ـەکەت لێرە بانگ بکە
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Registered successfully!')),
    );

    // گەڕانەوە بۆ لۆگین دوای سەرکەوتن
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back circular button (primary bg, white icon)
             
              const SizedBox(height: 16),

              // Logo (optional)
              Center(
                child: Image.asset(
                  'assets/img/logo.png',
                  height: 44,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => const SizedBox(height: 44),
                ),
              ),
              const SizedBox(height: 14),

              // Gradient card
              Container(
                padding: const EdgeInsets.fromLTRB(18, 22, 18, 18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [primary.withOpacity(.35), primary],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.06),
                      blurRadius: 14,
                      offset: const Offset(0, 8),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Full name
                    _InputField(
                      controller: _name,
                      hint: 'Full name',
                      suffix: const Icon(Icons.person_outline, color: primary, size: 22),
                    ),
                    const SizedBox(height: 12),

                    // ✅ Mobile number (نوێ)
                    _InputField(
                      controller: _mobile,
                      hint: 'Mobile number',
                      keyboardType: TextInputType.phone,
                      suffix: const Icon(Icons.phone_outlined, color: primary, size: 22),
                    ),
                    const SizedBox(height: 12),

                    // Email
                    _InputField(
                      controller: _email,
                      hint: 'Email address',
                      keyboardType: TextInputType.emailAddress,
                      suffix: const Icon(Icons.email_outlined, color: primary, size: 22),
                    ),
                    const SizedBox(height: 12),

                    // Password
                    _InputField(
                      controller: _pass,
                      hint: 'Password',
                      obscure: !_obscurePass,
                      suffix: IconButton(
                        icon: Icon(
                          _obscurePass ? Icons.visibility : Icons.visibility_off,
                          color: primary, size: 22,
                        ),
                        onPressed: () => setState(() => _obscurePass = !_obscurePass),
                        tooltip: _obscurePass ? 'Show password' : 'Hide password',
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Confirm password
                    _InputField(
                      controller: _confirm,
                      hint: 'Confirm password',
                      obscure: !_obscureConfirm,
                      suffix: IconButton(
                        icon: Icon(
                          _obscureConfirm ? Icons.visibility : Icons.visibility_off,
                          color: primary, size: 22,
                        ),
                        onPressed: () => setState(() => _obscureConfirm = !_obscureConfirm),
                        tooltip: _obscureConfirm ? 'Show password' : 'Hide password',
                      ),
                    ),

                    if (_error != null) ...[
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.error_outline, size: 16, color: Colors.redAccent),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              _error!,
                              style: const TextStyle(
                                color: Colors.redAccent,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],

                    const SizedBox(height: 12),

                    // Create account
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _submit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 255, 253, 253),
                          foregroundColor: const Color.fromARGB(255, 245, 84, 84),
                          minimumSize: const Size.fromHeight(50),
                          shape: const StadiumBorder(),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Register',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // ✅ Go back to Login (at bottom)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account? ',
                            style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600)),
                        TextButton(
                          onPressed: () {
                        // لە سەرەوەی فایلەکە زیاد بکە

// ...
Navigator.push(context,
  MaterialPageRoute(builder: (_) => const LoginScreen()));
                        }, // گەڕانەوە بۆ لۆگین
                          child: const Text('Login',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// همان ستایلەی خانەکانی لۆگین
class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final Widget suffix;
  final bool obscure;
  final TextInputType? keyboardType;

  const _InputField({
    required this.controller,
    required this.hint,
    required this.suffix,
    this.obscure = false,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    const primary = _RegisterScreenState.primary;
    return TextField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white.withOpacity(.6),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        suffixIcon: suffix, // ئایکۆنی لای راست
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.black26, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primary, width: 1.4),
        ),
      ),
    );
  }
}
