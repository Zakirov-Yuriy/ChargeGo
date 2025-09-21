import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  Future<void> _openAppStore() async {
    final uri = Uri.parse('https://play.google.com/store/apps/details?id=com.recharge.city&hl=ru');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _openSupport() async {
    final uri = Uri.parse('https://play.google.com/store/apps/details?id=com.recharge.city&hl=ru');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    const black = Colors.black;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
        
            

            // ---- Лого + recharge.city ----
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 27, 24, 0),
              child: Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFFF9FD57), // 0%
                          Color(0xFFD0FF1D), // 28%
                          Color(0xFF9DFF10), // 62%
                          Color(0xFF70FF02), // 100%
                        ],
                        stops: [0.0, 0.28, 0.62, 1.0],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Transform(
  transform: Matrix4.identity()..setEntry(0, 1, -0.15),
  alignment: Alignment.centerLeft,
  child: const Text(
    'recharge.city',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1EE300),
                        letterSpacing: 0.2,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ---- Контент ----
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(36, 176, 24, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // центрируем блок
                  children: [
                    // Заголовок по центру
                    const Text(
                      'Stay Powered Anytime',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                        color: black,
                        height: 1.15,
                        fontFamily: 'Inter-Regular',
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Абзац по центру, переносы как на макете
                    const Text(
                      'To return your power bank\n'
                      'and keep enjoying our\n'
                      'service for free, simply\n'
                      'download the app!',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 20,
                        height: 1.35,
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'Inter-Light',                   
                        color: Color.fromARGB(221, 41, 40, 40),                        
                      ),
                    ),
                    const Spacer(),

                    // Большая градиентная кнопка
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: GestureDetector(
                        onTap: _openAppStore,
                        child: Container(
                          height: 64,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [Color(0xFFD9FFC4), Color(0xFF88FF61)],
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Center(
                            child: Text(
                              'Download App',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                                color: black,
                                letterSpacing: 2.0,
                                fontFamily: 'Inter-Light',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // "Nothing happened? Contact support" —
                    // подчёркнут ТОЛЬКО "Contact support"
                    const SizedBox(height: 34),
                    Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey.shade600,
                            height: 1.4,
                            letterSpacing: 2.0,
                            fontFamily: 'Inter-Regular',
                          ),
                          children: [
                            const TextSpan(text: 'Nothing happened? '),
                            TextSpan(
                              text: 'Contact support',
                              style: const TextStyle(
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Inter',
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = _openSupport,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 144
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
