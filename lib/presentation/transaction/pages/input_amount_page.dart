import 'package:ez_money_app/core/assets/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../core/components/spaces.dart';
import '../../../core/constants/colors.dart';
import '../../../core/router/app_router.dart';
import '../../../core/utils/show_alert.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class InputAmountPage extends StatefulWidget {
  const InputAmountPage({Key? key}) : super(key: key);

  @override
  State<InputAmountPage> createState() => _InputAmountPageState();
}

class _InputAmountPageState extends State<InputAmountPage> {
  final amountController = TextEditingController();
  final FocusNode amountFocusNode = FocusNode();
  final formatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  String _formatNumber(String value) {
    if (value.isEmpty) return '';

    // Hapus semua karakter non-digit
    final number = int.tryParse(value.replaceAll(RegExp(r'[^\d]'), '')) ?? 0;
    return formatter.format(number);
  }

  void _handleContinue() {
    if (amountController.text.isEmpty) {
      showAlert(
        context: context,
       message: 'Silakan masukkan jumlah pemasukan',
        dialogType: DialogType.warning,
        autoDismiss: true,
      );
      return;
    }

    final amount = int.parse(
      amountController.text.replaceAll(RegExp(r'[^\d]'), ''),
    );
    context.pushNamed(
      RouteConstants.savingSelection,
      extra: amount,
    );
  }

  @override
  void dispose() {
    amountController.dispose();
    amountFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SpaceHeight(16.0),
                  Text(
                    'Berapa Rata-Rata\nPemasukan Bulanan mu?',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).textScaler.scale(24),
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                  const SpaceHeight(8.0),
                  Text(
                    'Masukkan rata-rata pemasukan bulanan kamu untuk membantu kami memberikan rekomendasi yang lebih baik',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SpaceHeight(24.0),
                  Center(
                    child: Assets.images.chart.image(
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SpaceHeight(32.0),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: amountController,
                      focusNode: amountFocusNode,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Rp 0',
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      onChanged: (value) {
                        final formatted = _formatNumber(value);
                        amountController.value = TextEditingValue(
                          text: formatted,
                          selection:
                              TextSelection.collapsed(offset: formatted.length),
                        );
                      },
                      onSubmitted: (_) => _handleContinue(),
                    ),
                  ),
                  const SpaceHeight(32.0),
                  ElevatedButton(
                    onPressed: _handleContinue,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Lanjutkan',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SpaceHeight(16.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
