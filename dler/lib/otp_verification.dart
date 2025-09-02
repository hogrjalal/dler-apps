import 'dart:async';
import 'dart:ui' show FontFeature;
import 'package:flutter/material.dart';
import 'new_password.dart';
class OtpVerificationScreen extends StatefulWidget {
  final String via;        // 'WhatsApp' یان 'Email'
  final String maskedTo;   // بۆ نموونە: '+964 750 ...' یان 'r***@mail.com'

  const OtpVerificationScreen({
    super.key,
    this.via = 'WhatsApp',
    required this.maskedTo,
  });

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  static const primary = Color(0xFFFF5A36);

  final _nodes = List.generate(6, (_) => FocusNode());
  final _ctls  = List.generate(6, (_) => TextEditingController());

  Timer? _tick;
  int _seconds = 59;
  bool get _isFilled => _ctls.every((c) => c.text.trim().isNotEmpty);
  String get _code => _ctls.map((e) => e.text).join();

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _tick?.cancel();
    for (final n in _nodes) n.dispose();
    for (final c in _ctls) c.dispose();
    super.dispose();
  }

  void _startTimer() {
    _tick?.cancel();
    setState(() => _seconds = 59);
    _tick = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_seconds == 0) {
        setState(() {}); // بۆ نوێکردنەوەی ڕەنگی دوکمە لە 0
        t.cancel();
      } else {
        setState(() => _seconds--);
      }
    });
  }

  void _onChanged(int i, String v) {
    // تەنیا ژمارە ڕێگەبدە
    if (v.isNotEmpty && !RegExp(r'^\d$').hasMatch(v)) {
      _ctls[i].text = '';
      return;
    }
    if (v.isNotEmpty && i < 5) {
      _nodes[i + 1].requestFocus();
    }
    if (v.isEmpty && i > 0) {
      _nodes[i - 1].requestFocus();
      _ctls[i - 1].selection =
          TextSelection.collapsed(offset: _ctls[i - 1].text.length);
    }
    setState(() {});
  }

 void _verify() {
  if (!_isFilled) return;
  // TODO: verify with server
  Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => const NewPasswordScreen()),
  );
}

  void _resend() {
    for (final c in _ctls) c.clear();
    _nodes.first.requestFocus();
    _startTimer();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('OTP resent via ${widget.via}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final time =
        '${(_seconds ~/ 60).toString().padLeft(2, '0')}:${(_seconds % 60).toString().padLeft(2, '0')}';

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
          child: Column(
            children: [
              const SizedBox(width: 18),
              // هێڵی سەرەوە: بازنەی بچووک + لوگۆ
              Row(
                children: [
                  
                  Container(
                    
                    width: 34,
                    height: 34,
                    decoration: const BoxDecoration(
                      color: primary,
                      shape: BoxShape.circle,
                    ),
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
                    height: 46,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => const SizedBox(height: 46),
                  ),
                  const Spacer(),
                  const SizedBox(width: 48),
                ],
              ),

              const SizedBox(height: 14),

              // کارتەی گرادیەنت
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
                          'OTP Verification',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      const SizedBox(height: 46),

                      Text(
                        'OTP has been sent to your ${widget.via}  ${widget.maskedTo} …',
                        style: const TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 24),

                      const Text(
                        'Enter the code below to continue',
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),

                      // خانەکانی OTP
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(6, (i) => _otpBox(i)),
                      ),

                      const SizedBox(height: 18),

                      // کۆنتاوداون + Resend
                      Center(
                        child: Column(
                          children: [
                            Text(
                              time,
                              style: const TextStyle(
                                fontFeatures: [FontFeature.tabularFigures()],
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  "Didn't receive code?  ",
                                  style: TextStyle(
                                    color: Color.fromARGB(76, 0, 0, 0),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: _seconds == 0 ? _resend : null,
                                  child: Text(
                                    'Resend',
                                    style: TextStyle(
                                      color: _seconds == 0
                                          ? const Color.fromARGB(255, 1, 1, 1)
                                          : Colors.black38,
                                      fontWeight: FontWeight.w500,
                                     
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 18),

                      // دوکمەی Verify — ڕەنگی تایبەت لە 0:00
                      Center(
                        child: SizedBox(
                          width: 220,
                          child: ElevatedButton(
                            onPressed: _isFilled ? _verify : null,
                            style: ButtonStyle(
                              // Background
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>((states) {
                                if (_seconds == 0) return Colors.white; // ⬅️ کات تەواو بوو
                                if (states.contains(MaterialState.disabled)) {
                                  return const Color(0xFFE0E0E0);
                                }
                                return primary;
                              }),
                              // Foreground (text/icon)
                              foregroundColor:
                                  MaterialStateProperty.resolveWith<Color>((states) {
                                if (_seconds == 0) return primary; // ⬅️ کات تەواو بوو
                                if (states.contains(MaterialState.disabled)) {
                                  return const Color(0xFF999999);
                                }
                                return Colors.white;
                              }),
                              // Border only when white bg
                              side: MaterialStateProperty.resolveWith<BorderSide?>((states) {
                                if (_seconds == 0) {
                                  return const BorderSide(color: primary, width: 1.6);
                                }
                                return null;
                              }),
                              minimumSize:
                                  MaterialStateProperty.all(const Size.fromHeight(48)),
                              shape: MaterialStateProperty.all(const StadiumBorder()),
                              elevation: MaterialStateProperty.all(0),
                              textStyle: MaterialStateProperty.all(
                                const TextStyle(fontWeight: FontWeight.w800),
                              ),
                            ),
                            child: const Text('Verify'),
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

  // ————— خانەی تاقەی OTP —————
  Widget _otpBox(int i) {
    return SizedBox(
      width: 42,
      height: 48,
      child: TextField(
        controller: _ctls[i],
        focusNode: _nodes[i],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        onChanged: (v) => _onChanged(i, v),
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: Colors.white.withOpacity(.75),
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.black45, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color.fromARGB(255, 54, 134, 255), width: 1.6),
          ),
        ),
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
    );
  }
}
