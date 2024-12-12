import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/app_router.dart';
import '../../../data/models/requests/transaction_request_model.dart';
import '../../../data/datasources/auth_local_datasource.dart';
import '../bloc/transaction/transaction_bloc.dart';
import '../../../core/components/spaces.dart';
import '../../../core/constants/colors.dart';
import '../../../core/utils/show_alert.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class SavingSelectionPage extends StatefulWidget {
  final int amount;

  const SavingSelectionPage({
    Key? key,
    required this.amount,
  }) : super(key: key);

  @override
  State<SavingSelectionPage> createState() => _SavingSelectionPageState();
}

class _SavingSelectionPageState extends State<SavingSelectionPage> {
  int? selectedSavingPercentage;

  final List<Map<String, dynamic>> savingPlans = [
    {
      'title': 'Ringan',
      'percentage': 30,
      'color': const Color(0xFF68B984),
      'description': 'Prioritaskan kebutuhan dengan sedikit menabung',
    },
    {
      'title': 'Normal',
      'percentage': 50,
      'color': const Color(0xFFB4B83B),
      'description': 'Seimbangkan antara menabung dan pengeluaran',
    },
    {
      'title': 'Luar Biasa',
      'percentage': 80,
      'color': const Color(0xFFBE8C63),
      'description': 'Fokus pada tabungan dengan pengeluaran minimal',
    },
  ];

  void _handleContinue() async {
    if (selectedSavingPercentage == null) {
      showAlert(
        context: context,
        message: 'Silakan pilih rencana tabungan terlebih dahulu',
        dialogType: DialogType.warning,
        autoDismiss: true,
      );
      return;
    }

    final authData = await AuthLocalDatasource().getAuthData();
    if (authData?.userId != null) {
      final request = TransactionRequestModel(
        type: 'income',
        category: 'Aktif',
        amount: widget.amount,
        saving: selectedSavingPercentage!,
      );
      
      if (mounted) {
        context.read<TransactionBloc>().add(
          TransactionEvent.createTransaction(
            userId: authData!.userId!,
            request: request,
            context: context,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilih Rencana Tabungan'),
      ),
      body: BlocListener<TransactionBloc, TransactionState>(
        listener: (context, state) {
          state.maybeWhen(
            orElse: () {},
            loaded: (data) {
              context.goNamed(RouteConstants.root, pathParameters: {'root_tab': '0'});
              showAlert(
                context: context,
                message: 'Saldo awal berhasil disimpan',
                dialogType: DialogType.success,
                autoDismiss: true,
              );
            },
            error: (message) {
              showAlert(
                context: context,
                message: message,
                dialogType: DialogType.error,
                autoDismiss: true,
              );
            },
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Pilih rencana\ntabunganmu!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
              const SpaceHeight(24.0),
              Expanded(
                child: ListView.builder(
                  itemCount: savingPlans.length,
                  itemBuilder: (context, index) {
                    final plan = savingPlans[index];
                    final isSelected = selectedSavingPercentage == plan['percentage'];
                    
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            selectedSavingPercentage = plan['percentage'];
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.white,
                            border: Border.all(
                              color: isSelected ? plan['color'] : Colors.grey[300]!,
                              width: 2.5,
                            ),
                            boxShadow: [
                              if (isSelected)
                                BoxShadow(
                                  color: plan['color'].withOpacity(0.15),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 64,
                                height: 64,
                                decoration: BoxDecoration(
                                  color: plan['color'],
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: plan['color'].withOpacity(0.3),
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    plan['title'],
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      height: 1.2,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          '${plan['percentage']}%',
                                          style: TextStyle(
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold,
                                            color: plan['color'],
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          'TABUNGAN',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey[600],
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      plan['description'],
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey[600],
                                        height: 1.3,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (isSelected)
                                Icon(
                                  Icons.check_circle,
                                  color: plan['color'],
                                  size: 28,
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
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
                  'Pilih Rencana',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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