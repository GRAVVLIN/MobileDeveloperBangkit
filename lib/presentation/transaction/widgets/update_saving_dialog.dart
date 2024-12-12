import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/components/spaces.dart';
import '../../../core/constants/colors.dart';
import '../../../core/utils/show_alert.dart';
import '../../dashboard/bloc/transaction_list/transaction_list_bloc.dart'; 

class UpdateSavingDialog extends StatefulWidget {
  final int currentSaving;
  final String currentMonth;
  final String userId;

  const UpdateSavingDialog({
    Key? key,
    required this.currentSaving,
    required this.currentMonth,
    required this.userId,
  }) : super(key: key);

  @override
  State<UpdateSavingDialog> createState() => _UpdateSavingDialogState();
}

class _UpdateSavingDialogState extends State<UpdateSavingDialog> {
  late double _selectedSaving;
  final List<int> _savingOptions = [30, 50, 80];

  @override
  void initState() {
    super.initState();
    _selectedSaving =
        widget.currentSaving < 30 ? 30.0 : widget.currentSaving.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: BlocListener<TransactionListBloc, TransactionListState>(
        listener: (context, state) {
          state.maybeWhen(
            orElse: () {},
            error: (message) {
              showAlert(
                context: context,
                message: message,
                dialogType: DialogType.error,
                autoDismiss: true,
              );
            },
            loaded: (data) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Progress tabungan berhasil diupdate'),
                  backgroundColor: Colors.green,
                  duration: const Duration(seconds: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              );
            },
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Update Progress Tabungan',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SpaceHeight(24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: _savingOptions.map((saving) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedSaving = saving.toDouble();
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: _selectedSaving == saving
                            ? isDarkMode
                                ? AppColors.white
                                : AppColors.primary
                            : AppColors.primary.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '$saving%',
                        style: TextStyle(
                          color: _selectedSaving == saving
                              ? isDarkMode
                                  ? AppColors.black
                                  : AppColors.white
                              : AppColors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SpaceHeight(16.0),
              if (widget.currentSaving < 30) ...[
                const SpaceHeight(8.0),
                Text(
                  'Saving awal Anda 0%, akan diset ke minimum 30%',
                  style: TextStyle(
                    color: Colors.orange[700],
                    fontSize: 12,
                  ),
                ),
              ],
              const SpaceHeight(16.0),
              SliderTheme(
                data: SliderThemeData(
                  activeTrackColor:
                      isDarkMode ? AppColors.white : AppColors.primary,
                  inactiveTrackColor:
                      isDarkMode ? Colors.grey[800] : Colors.grey[200],
                  thumbColor: isDarkMode ? AppColors.white : AppColors.primary,
                  valueIndicatorColor:
                      isDarkMode ? AppColors.white : AppColors.primary,
                  showValueIndicator: ShowValueIndicator.always,
                ),
                child: Slider(
                  value: _selectedSaving,
                  min: 30,
                  max: 80,
                  divisions: 2, // Ini yang menyebabkan nilai tidak tepat
                  label: '${_selectedSaving.toInt()}%',
                  onChanged: (value) {
                    // Tambahkan logic untuk memastikan nilai sesuai opsi
                    final nearestValue = _savingOptions.reduce((a, b) {
                      return (value - a).abs() < (value - b).abs() ? a : b;
                    });
                    setState(() {
                      _selectedSaving = nearestValue.toDouble();
                    });
                  },
                ),
              ),
              const SpaceHeight(24.0),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Batal'),
                    ),
                  ),
                  const SpaceWidth(16.0),
                  Expanded(
                    child:
                        BlocBuilder<TransactionListBloc, TransactionListState>(
                      builder: (context, state) {
                        final isLoading = state.maybeWhen(
                          orElse: () => false,
                          loading: () => true,
                        );

                        return ElevatedButton(
                          onPressed: isLoading
                              ? null
                              : () {
                                  context.read<TransactionListBloc>().add(
                                        TransactionListEvent.updateSaving(
                                          userId: widget.userId,
                                          saving: _selectedSaving.toInt(),
                                          month: widget.currentMonth,
                                        ),
                                      );
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: state.maybeWhen(
                            orElse: () => const Text(
                              'Simpan',
                              style: TextStyle(color: Colors.white),
                            ),
                            loading: () => const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
