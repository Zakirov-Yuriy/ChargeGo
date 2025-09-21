import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/station.dart';
import '../providers/payment_provider.dart';
import 'success_screen.dart';

class PaymentScreen extends StatefulWidget {
  final Station station;

  const PaymentScreen({super.key, required this.station});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final bool _isLoading = false;
  bool _cardExpanded = false;

  final _cardNumber = TextEditingController();
  final _cardExpiry = TextEditingController();
  final _cardCvc = TextEditingController();
  final _cardHolder = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PaymentProvider>().initializePayment();
    });
  }

  @override
  void dispose() {
    _cardNumber.dispose();
    _cardExpiry.dispose();
    _cardCvc.dispose();
    _cardHolder.dispose();
    super.dispose();
  }

  // ⬇️ Показываем лист сразу — это исправляет "кнопка не работает"
  Future<void> _handleApplePay() async {
    if (_isLoading) return;
    _showApplePaySheet(
      amount: 4.99,
      email: 'username@icloud.com',
      // Все серверные вызовы делаем при подтверждении
      onConfirm: () async {
        // Имитируем задержку для демонстрации
        await Future.delayed(const Duration(seconds: 2));

        // Имитируем успешную оплату для тестирования
        // В будущем здесь будут реальные API вызовы:
        // 1) Создать аккаунт
        // final accountResp = await ApiService.createAppleAccount();
        // if (!accountResp.success) {
        //   throw 'Не удалось создать аккаунт';
        // }
        // 2) Получить Braintree clientToken
        // final clientToken = await ApiService.getBraintreeClientToken();
        // if (clientToken == null) {
        //   throw 'Не удалось получить токен оплаты';
        // }
        // 3) Арендовать павербанк
        // final rentResp = await ApiService.rentPowerBank(widget.station.id);
        // if (!rentResp.success) {
        //   throw rentResp.message.isNotEmpty
        //       ? rentResp.message
        //       : 'Не удалось провести оплату';
        // }
      },
    );
  }

  void _toggleCard() => setState(() => _cardExpanded = !_cardExpanded);

  void _toast(String m) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(m)));

  @override
  Widget build(BuildContext context) {
    const black = Colors.black;
    final grey300 = Colors.grey.shade300;
    final grey500 = Colors.grey.shade600;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
          
            // ===== Лого + recharge.city =====
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 27, 24, 48),
              child: Row(
                children: [
                  // Градиент по твоим стопам
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
                    transform: Matrix4.identity()..setEntry(0, 1, -0.06),
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

            // ===== Контент =====
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 6),
                    const Text(
                      'Monthly Subscription',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 2.0,
                        color: black,
                        height: 1.15,
                        fontFamily: 'Inter-Regular',
                      ),
                    ),
                    const SizedBox(height: 13),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          '\$4.99',
                          style: TextStyle(
                            fontSize: 38,
                            fontWeight: FontWeight.w400,
                            color: black,
                            height: 1.0,
                            fontFamily: 'Inter-Regular',
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          '\$9.99',
                          style: TextStyle(
                            fontSize: 26,
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey.shade400,                                                       
                            decorationThickness: 2,
                            
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'First month only',
                      style: TextStyle(fontSize: 12, color: grey500, height: 1.25, fontFamily: 'nter-Regular'),
                    ),

                    const SizedBox(height: 13),
                    Divider(height: 1, color: grey300),

                    // ===== Apple Pay =====
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: _handleApplePay,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: black,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.apple, size: 22, color: Colors.white),
                            SizedBox(width: 8),
                            Text(
                              'Pay',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.2,
                                fontFamily: 'Inter-Regular',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),
                    Divider(height: 1, color: grey300),

                    // ===== Раскрывающаяся "Debit or credit card" =====
                    const SizedBox(height: 18),
                    _CardExpandable(
                      expanded: _cardExpanded,
                      onTapHeader: _toggleCard,
                      cardNumber: _cardNumber,
                      cardExpiry: _cardExpiry,
                      cardCvc: _cardCvc,
                      cardHolder: _cardHolder,
                      onSubmit: () => _toast('Оплата картой будет позже'),
                    ),
                    const SizedBox(height: 18),
                    Divider(height: 1, color: grey300),

                    const Spacer(),

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
                               
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 148),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // === Apple Pay bottom sheet ===
  Future<void> _showApplePaySheet({
    required double amount,
    required String email,
    required Future<void> Function() onConfirm,
  }) async {
    await showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Apple Pay',
      barrierColor: Colors.black.withValues(alpha: 0.55),
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (_, __, ___) {
        return SafeArea(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: _ApplePaySheet(
                  amount: amount,
                  email: email,
                  onSuccess: () async {
                    Navigator.of(context).pop(); // закрыть лист
                    if (!mounted) return;
                    // Переход на экран успеха
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const SuccessScreen()),
                    );
                  },
                  onError: (msg) async {
                    Navigator.of(context).pop();
                    if (!mounted) return;
                    _toast(msg);
                  },
                  confirmAction: onConfirm,
                ),
              ),
            ],
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        final tween = Tween(begin: const Offset(0, 1), end: Offset.zero)
            .chain(CurveTween(curve: Curves.easeOutCubic));
        return SlideTransition(position: anim.drive(tween), child: child);
      },
    );
  }
}



// ===== Bottom sheet (Stateful, показывает лоадер при подтверждении) =====
class _ApplePaySheet extends StatefulWidget {
  final double amount;
  final String email;
  final Future<void> Function() confirmAction;
  final Future<void> Function() onSuccess;
  final Future<void> Function(String message) onError;

  const _ApplePaySheet({
   
    required this.amount,
    required this.email,
    required this.confirmAction,
    required this.onSuccess,
    required this.onError,
  });

  @override
  State<_ApplePaySheet> createState() => _ApplePaySheetState();
}

class _ApplePaySheetState extends State<_ApplePaySheet> {
  bool _confirming = false;

  Future<void> _confirm() async {
    if (_confirming) return;
    setState(() => _confirming = true);

    try {
      // Выполняем оплату
      await widget.confirmAction();

      // Показываем успех
      await widget.onSuccess();
    } catch (e) {
      // Показываем ошибку
      await widget.onError(e.toString());
    } finally {
      if (mounted) setState(() => _confirming = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final radius = const Radius.circular(18);
    final divider = Divider(color: Colors.grey.shade300, height: 1);

    return Material(
      color: Colors.transparent,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFFF6F6F8),
          borderRadius: BorderRadius.only(topLeft: radius, topRight: radius),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header:  Pay + close
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 12, 8),
              child: Row(
                children: [
                  const Icon(Icons.apple, size: 28, color: Colors.black),
                  const SizedBox(width: 6),
                  const Text('Pay',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
                  const Spacer(),
                  const SizedBox(width: 8),
                ],
              ),
            ),

            // Apple Card cell
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: _iOSCell(
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 24,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFFFAD961), Color(0xFFF76B1C)],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Apple Card',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600)),
                          SizedBox(height: 4),
                          Text('10880 Malibu Point Malibu Cal...',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black54)),
                          SizedBox(height: 4),
                          Text('•••• 1234',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black54)),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios,
                        size: 18, color: Colors.black26),
                  ],
                ),
              ),
            ),

            // Amount
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: _iOSCell(
                child: Text('\$${widget.amount.toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600)),
              ),
            ),

            // Email
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: _iOSCell(
                child: Text('Account: ${widget.email}',
                    style:
                        const TextStyle(fontSize: 16, color: Colors.black54)),
              ),
            ),

            const SizedBox(height: 6),
            divider,

            // Summary
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Pay Recharge',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                          fontWeight: FontWeight.w500)),
                  const SizedBox(height: 6),
                  Text('\$${widget.amount.toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontSize: 36, fontWeight: FontWeight.w800)),
                ],
              ),
            ),

            divider,

            // Confirm with Side Button
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: _confirm,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 8),
                child: Column(
                  children: [
                    if (_confirming)
                      const Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child:
                            SizedBox(height: 24, width: 24, child: CircularProgressIndicator(strokeWidth: 2)),
                      )
                    else
                      Image.asset(
                        'assets/icons/card_icon.png',
                        width: 32,
                        height: 32,
                      ),
                    const SizedBox(height: 8),
                    const Text(
                      'Confirm with Side Button',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),

            // Home indicator
            const SizedBox(height: 8),
            Container(
              width: 140,
              height: 5,
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _iOSCell({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black12),
      ),
      child: child,
    );
  }
}

// ====== Раскрывающийся блок карты ======
class _CardExpandable extends StatelessWidget {
  final bool expanded;
  final VoidCallback? onTapHeader;
  final TextEditingController cardNumber;
  final TextEditingController cardExpiry;
  final TextEditingController cardCvc;
  final TextEditingController cardHolder;
  final VoidCallback onSubmit;

  const _CardExpandable({
    
    required this.expanded,
    required this.onTapHeader,
    required this.cardNumber,
    required this.cardExpiry,
    required this.cardCvc,
    required this.cardHolder,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final black = Colors.black;
    final chevronColor = Colors.grey.shade400;

    return Column(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTapHeader,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Container(
            height: 56,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                 Icon(Icons.credit_card, size: 22, color: black),
                const SizedBox(width: 12),
                 Expanded(
                  child: Text(
                    'Debit or credit card',
                    style: TextStyle(fontSize: 18, color: black),
                  ),
                ),
                AnimatedRotation(
                  turns: expanded ? 0.25 : 0.0,
                  duration: const Duration(milliseconds: 200),
                  child: Icon(Icons.arrow_forward_ios,
                      size: 16, color: chevronColor),
                ),
              ],
            ),
          ),
        ),
        AnimatedCrossFade(
          firstChild: const SizedBox.shrink(),
          secondChild: _CardForm(
            cardNumber: cardNumber,
            cardExpiry: cardExpiry,
            cardCvc: cardCvc,
            cardHolder: cardHolder,
            onSubmit: onSubmit,
          ),
          crossFadeState:
              expanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 220),
        ),
      ],
    );
  }
}

class _CardForm extends StatelessWidget {
  final TextEditingController cardNumber;
  final TextEditingController cardExpiry;
  final TextEditingController cardCvc;
  final TextEditingController cardHolder;
  final VoidCallback onSubmit;

  const _CardForm({
    Key? key,
    required this.cardNumber,
    required this.cardExpiry,
    required this.cardCvc,
    required this.cardHolder,
    required this.onSubmit,
  }) : super(key: key);

  InputDecoration _dec(String hint) => InputDecoration(
        hintText: hint,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 12, 4, 0),
      child: Column(
        children: [
          TextField(
            controller: cardNumber,
            keyboardType: TextInputType.number,
            decoration: _dec('Card number'),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: cardExpiry,
                  keyboardType: TextInputType.datetime,
                  decoration: _dec('MM/YY'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: cardCvc,
                  keyboardType: TextInputType.number,
                  decoration: _dec('CVC'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          TextField(
            controller: cardHolder,
            textCapitalization: TextCapitalization.words,
            decoration: _dec('Cardholder name'),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: onSubmit,
              child: const Text('Continue'),
            ),
          ),
        ],
      ),
    );
  }
}
