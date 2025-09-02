import 'package:flutter/material.dart';
import 'register.dart';
import 'forgotpassword.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static const primary = Color(0xFFFF5A36);

  final _email = TextEditingController();
  final _pass  = TextEditingController();
  final _passFocus = FocusNode();

  bool _showPass = false;
  bool _remember = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    // بۆ ئەوەی کاتێک فوکۆس دەکەیت لە پاسوۆرد، ئایکۆن نوێ بێت
    _passFocus.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _email.dispose();
    _pass.dispose();
    _passFocus.dispose();
    super.dispose();
  }

  void _submit() {
    setState(() => _error = null);
    if (_email.text.trim().isEmpty || _pass.text.isEmpty) {
      setState(() => _error = 'Please fill all fields.');
      return;
    }
    // Demo: هەڵەنامەی پاسوۆرد
    setState(() => _error = 'Wrong password, try again.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
          child: Column(
            children: [
              // لۆگۆ لەسەرەوە
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 20),
                child: Image.asset(
                  'assets/img/logo.png', // لۆگۆی خۆت
                  height: 52,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => const SizedBox(height: 52),
                ),
              ),

              // کارتەی گرادیەنت
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
                      'Login',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Email (ئایکۆن لە راست، ڕەنگی پرایمەری)
                    _InputField(
                      controller: _email,
                      hint: 'Mobile number or email',
                      keyboardType: TextInputType.emailAddress,
                      suffix: const Icon(Icons.person_outline, color: primary, size: 22),
                    ),
                    const SizedBox(height: 12),

                    // Password (focus: lock→eye ، toggle: eye/eye_off)
                    _InputField(
                      controller: _pass,
                      hint: 'Password',
                      focusNode: _passFocus,
                      obscure: _showPass,
                      suffix: IconButton(
                        icon: Icon(
                          _showPass
                              ? Icons.visibility_off
                              : (_passFocus.hasFocus ? Icons.visibility : Icons.lock_outline),
                          color: primary,
                          size: 22,
                        ),
                        onPressed: () => setState(() => _showPass = !_showPass),
                        tooltip: _showPass ? 'Hide' : 'Show',
                      ),
                    ),

                    // هەوالنامەی هەڵە یان Remember/Forgot
                    if (_error != null) ...[
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(Icons.error_outline, size: 16, color: Color.fromARGB(255, 255, 0, 0)),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              _error!,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 255, 0, 0),
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          TextButton(
                                              onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ForgotPasswordScreen()),
        );
      },
                            child: const Text(
                              'Forgot password ?',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ] else ...[
                      
                      Row(
                        children: [
                          Checkbox(
                            value: _remember,
                            onChanged: (v) => setState(() => _remember = v ?? false),
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            visualDensity: VisualDensity.compact,
                            side: const BorderSide(color: Colors.black54),
                            activeColor: primary,
                          ),
                          const Text('Remember me',
                              style: TextStyle(fontSize: 13.5, color: Colors.black87)),
                          const Spacer(),
                          TextButton(
                             onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ForgotPasswordScreen()),
        );
      },
                            child: const Text(
                              'Forgot password ?',
                              style: TextStyle(
                                fontSize: 13,
                                color: Color.fromARGB(255, 50, 124, 252),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],

                    const SizedBox(height: 8),

                    // دوکمەی Login
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
        Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (_) => HomeScreen()),
);

      },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primary,
                          foregroundColor: Colors.white,
                          minimumSize: const Size.fromHeight(40),
                          shape: const StadiumBorder(),
                          elevation: 0,
                        ),
                        child: const Text('Login',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                      ),
                    ),

                    const SizedBox(height: 14),

                    // هێڵەکانی "Or login in with"
                    Row(
                      children: const [
                        Expanded(child: Divider(color: Colors.black26, thickness: .8)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            'Or login in with',
                            style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Expanded(child: Divider(color: Colors.black26, thickness: .8)),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // سۆشیال بەتنەکان: transparent + black border + color logos
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        _SocialNet(
                          url: 'https://upload.wikimedia.org/wikipedia/commons/5/53/Google_%22G%22_Logo.svg',
                          tooltip: 'Google',
                        ),
                        SizedBox(width: 12),
                        _SocialNet(
                          url: 'https://upload.wikimedia.org/wikipedia/commons/0/05/Facebook_Logo_%282019%29.png',
                          tooltip: 'Facebook',
                        ),
                        SizedBox(width: 12),
                        _SocialNet(
                          url: 'https://upload.wikimedia.org/wikipedia/commons/f/fa/Apple_logo_black.svg',
                          tooltip: 'Apple',
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // لینکى تۆمارکردن
                    Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    const Text('New? ',
        style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w400)),
    TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const RegisterScreen()),
        );
      },
      child: const Text(
        'Register',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
      ),
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

/// ـــــــــــــــــــ Input Field (suffix icon on right) ـــــــــــــــــــ
class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final Widget suffix;
  final bool obscure;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;

  const _InputField({
    required this.controller,
    required this.hint,
    required this.suffix,
    this.obscure = false,
    this.keyboardType,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
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
          borderSide: const BorderSide(color: _LoginScreenState.primary, width: 1.4),
        ),
      ),
    );
  }
}

/// ـــــــــــــــــــ Social Buttons (transparent + black border + color logo) ـــــــــــــــــــ
class _SocialNet extends StatelessWidget {
  final String url;
  final String tooltip;
  const _SocialNet({required this.url, required this.tooltip});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
          border: Border.all(color: Colors.black, width: 1.2),
        ),
        alignment: Alignment.center,
        child: url.endsWith('.svg')
            ? SvgPicture.network(
                url,
                width: 22,
                height: 22,
              )
            : Image.network(
                url,
                width: 22,
                height: 22,
                fit: BoxFit.contain,
              ),
      ),
    );
  }
}

 
