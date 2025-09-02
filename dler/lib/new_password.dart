import 'package:flutter/material.dart';
import 'password_updated_success.dart';
class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  static const primary = Color(0xFFFF5A36);

  final _pass = TextEditingController();
  final _confirm = TextEditingController();

  bool _obscure1 = true;
  bool _obscure2 = true;
  String? _error;

  @override
  void dispose() {
    _pass.dispose();
    _confirm.dispose();
    super.dispose();
  }

  void _submit() {
    setState(() => _error = null);

    final p1 = _pass.text;
    final p2 = _confirm.text;

    if (p1.isEmpty || p2.isEmpty) {
      _error = 'Please fill both fields.';
    } else if (p1.length < 6) {
      _error = 'Password must be at least 6 characters.';
    } else if (p1 != p2) {
      _error = 'Passwords do not match.';
    }

    if (_error != null) {
      setState(() {});
      return;
    }

    // TODO: بانگەواز بە API بۆ گۆڕینی پاسوۆرد
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Password changed successfully!')),
    );

    // لەوێ دەتوانیت بگەڕێیتەوە بۆ Login یان Home
    Navigator.pop(context); // یان Navigator.of(context).popUntil(...)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
          child: Column(
            children: [
              // سەری پەڕە: بازنەی بچووک + لوگۆ ناوەڕاست
              Row(
                children: [
                  Container(
                    width: 34, height: 34,
                    decoration: const BoxDecoration(color: primary, shape: BoxShape.circle),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(Icons.close, color: Colors.white, size: 18),
                      onPressed: () => Navigator.pop(context),
                      tooltip: 'Close',
                    ),
                  ),
                  const Spacer(),
                  Image.asset(
                    'assets/img/logo.png',
                    height: 36,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => const SizedBox(height: 36),
                  ),
                  const Spacer(),
                  const SizedBox(width: 48),
                ],
              ),

              const SizedBox(height: 14),

              // کارتەی گرادیەنت (تا خوارەوە)
              Expanded(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(18, 22, 18, 22),
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
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          'Set new password',
                          style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w800, color: Colors.black87),
                        ),
                        ),
                      
                      const SizedBox(height: 76),
                       const Center(

                        child:  Text(
                        'Set new password for your account',
                        style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w400),
                         ),
                       ),

                      const SizedBox(height: 22),

                      // Password
                      _Input(
                        controller: _pass,
                        hint: 'Password',
                        obscure: _obscure1,
                        suffix: IconButton(
                          icon: Icon(
                            _obscure1 ? Icons.visibility_off : Icons.visibility,
                            color: _NewPasswordScreenState.primary,
                            size: 20,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscure1 = !_obscure1;
                            });
                          },
                          tooltip: _obscure1 ? 'Show password' : 'Hide password',
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Confirm password
                      _Input(
                        controller: _confirm,
                        hint: 'Confirm password',
                        obscure: _obscure2,
                        suffix: IconButton(
                          icon: Icon(
                            _obscure2 ? Icons.visibility_off : Icons.visibility,
                            color: _NewPasswordScreenState.primary,
                            size: 20,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscure2 = !_obscure2;
                            });
                          },
                          tooltip: _obscure2 ? 'Show password' : 'Hide password',
                        ),
                      ),

                      if (_error != null) ...[
                        const SizedBox(height: 18),
                        Row(
                          children: [
                            const Icon(Icons.error_outline, color: Colors.redAccent, size: 16),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                _error!,
                                style: const TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],

                      const SizedBox(height: 38),

                      // Continue (سپی + دەق/بۆردەر پرایمەری)
                      Center(
                        child: SizedBox(
                          width: 220,
                          child: OutlinedButton(
                            onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const PasswordUpdatedSuccessScreen()),
        );
      },
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: primary,
                              side: const BorderSide(color: primary, width: 1.6),
                              minimumSize: const Size.fromHeight(48),
                              shape: const StadiumBorder(),
                              textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                            ),
                            child: const Text('Continue'),
                          ),
                        ),
                      ),

                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ——— خانەی ئینپوت بە ئایکۆنی لای راست و ڕەنگی پرایمەری ———
class _Input extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool obscure;
  final Widget suffix;

  const _Input({
    required this.controller,
    required this.hint,
    required this.obscure,
    required this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    const primary = _NewPasswordScreenState.primary;
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFF8A8A8A)),
        filled: true,
        fillColor: const Color(0x0FFFFFFF),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            
            const SizedBox(width: 6),
            suffix, // 👁/👁‍🗨️ toggle
          ],
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.black45, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primary, width: 1.4),
        ),
      ),
    );
  }
}
