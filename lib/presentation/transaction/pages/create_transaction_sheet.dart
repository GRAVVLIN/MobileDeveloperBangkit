import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../core/components/spaces.dart';
import '../../../core/constants/colors.dart';
import '../../../core/utils/show_alert.dart';
import '../../../data/datasources/auth_local_datasource.dart';
import '../../../data/models/requests/transaction_request_model.dart';
import '../../dashboard/bloc/transaction_list/transaction_list_bloc.dart';
import '../bloc/transaction/transaction_bloc.dart';

class CreateTransactionSheet extends StatefulWidget {
  const CreateTransactionSheet({Key? key}) : super(key: key);

  @override
  State<CreateTransactionSheet> createState() => _CreateTransactionSheetState();
}

class _CreateTransactionSheetState extends State<CreateTransactionSheet>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  String selectedType = 'income';
  String? selectedCategory;
  final categoryOtherController = TextEditingController();
  final subCategoryController = TextEditingController();
  final amountController = TextEditingController();
  final noteController = TextEditingController();

  final Map<String, List<String>> categories = {
    'income': ['Passive', 'Aktif', 'Lain-Lain'],
    'expenses': ['Utilitas', 'Hiburan', 'Lain-Lain'],
  };

  @override
  void dispose() {
    categoryOtherController.dispose();
    subCategoryController.dispose();
    amountController.dispose();
    noteController.dispose();
    super.dispose();
  }

  String? _validateAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nominal tidak boleh kosong';
    }
    if (int.tryParse(value.replaceAll('.', '')) == null) {
      return 'Nominal harus berupa angka';
    }
    if (int.parse(value.replaceAll('.', '')) <= 0) {
      return 'Nominal harus lebih dari 0';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? AppColors.white : AppColors.primary;
    final backgroundColor = isDarkMode ? AppColors.black : AppColors.white;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Handle dan Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tambah Transaksi',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.close, color: textColor),
                      ),
                    ],
                  ),
                  const SpaceHeight(24.0),

                  // Jenis Transaksi dengan Card Selection
                  const Text(
                    'Jenis Transaksi',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SpaceHeight(8.0),
                  Row(
                    children: [
                      Expanded(
                        child: _TransactionTypeCard(
                          title: 'Pemasukan',
                          icon: Icons.arrow_upward,
                          isSelected: selectedType == 'income',
                          onTap: () => setState(() {
                            selectedType = 'income';
                            selectedCategory = null;
                          }),
                        ),
                      ),
                      const SpaceWidth(8.0),
                      Expanded(
                        child: _TransactionTypeCard(
                          title: 'Pengeluaran',
                          icon: Icons.arrow_downward,
                          isSelected: selectedType == 'expenses',
                          onTap: () => setState(() {
                            selectedType = 'expenses';
                            selectedCategory = null;
                          }),
                        ),
                      ),
                    ],
                  ),
                  const SpaceHeight(16.0),

                  // Dropdown Kategori dengan Style yang Lebih Baik
                  const Text(
                    'Kategori',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SpaceHeight(8.0),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isDarkMode
                            ? Colors.white.withOpacity(0.1)
                            : Colors.grey.shade300,
                      ),
                    ),
                    child: DropdownButtonFormField<String>(
                      value: selectedCategory,
                      decoration: InputDecoration(
                        hintText: 'Pilih kategori',
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        alignLabelWithHint: true,
                        isDense: true,
                      ),
                      hint: Text(
                        'Pilih kategori',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                      isExpanded: true,
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.grey[600],
                      ),
                      items: categories[selectedType]?.map((category) {
                        return DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        );
                      }).toList(),
                      validator: (value) =>
                          value == null ? 'Kategori harus dipilih' : null,
                      onChanged: (value) {
                        setState(() {
                          selectedCategory = value;
                          if (value != 'Lain-Lain') {
                            categoryOtherController.clear();
                          }
                        });
                      },
                    ),
                  ),
                  const SpaceHeight(16.0),

                  if (selectedCategory == 'Lain-Lain') ...[
                    const Text(
                      'Kategori Lainnya',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SpaceHeight(8.0),
                    _CustomTextField(
                      controller: categoryOtherController,
                      hintText: 'Masukkan kategori lainnya',
                      validator: (value) => (value?.isEmpty ?? true)
                          ? 'Kategori lainnya harus diisi'
                          : null,
                    ),
                    const SpaceHeight(16.0),
                  ],

                  // Tambahkan input Sub Kategori setelah Kategori
                  const SpaceHeight(16.0),
                  const Text(
                    'Sub Kategori (Opsional)',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SpaceHeight(8.0),
                  _CustomTextField(
                    controller: subCategoryController,
                    hintText: 'Masukkan sub kategori...',
                  ),

                  // Input Nominal dengan Format Rupiah yang Lebih Baik
                  const Text(
                    'Nominal',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SpaceHeight(8.0),
                  _CustomTextField(
                    controller: amountController,
                    hintText: 'Contoh: 50.000',
                    prefixText: 'Rp ',
                    keyboardType: TextInputType.number,
                    validator: _validateAmount,
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        // Hapus semua karakter non-digit
                        String cleanValue =
                            value.replaceAll(RegExp(r'[^\d]'), '');

                        if (cleanValue.isNotEmpty) {
                          // Parse ke number
                          final number = int.tryParse(cleanValue);
                          if (number != null) {
                            // Format number
                            final formatted = NumberFormat.currency(
                              locale: 'id',
                              symbol: '',
                              decimalDigits: 0,
                            ).format(number);

                            // Hapus spasi di awal dan 'Rp'
                            final finalText =
                                formatted.replaceAll('Rp', '').trim();

                            // Hitung posisi kursor yang benar
                            final cursorPosition = finalText.length;

                            // Update text field dengan mempertahankan posisi kursor
                            amountController.value = TextEditingValue(
                              text: finalText,
                              selection: TextSelection.collapsed(
                                offset: cursorPosition,
                              ),
                            );
                          }
                        }
                      }
                    },
                  ),
                  const SpaceHeight(16.0),

                  // Input Catatan yang Lebih Baik
                  const Text(
                    'Catatan (Opsional)',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SpaceHeight(8.0),
                  _CustomTextField(
                    controller: noteController,
                    hintText: 'Tambahkan catatan...',
                    maxLines: 3,
                  ),
                  const SpaceHeight(24.0),

                  // Tombol Submit yang Lebih Baik
                  BlocConsumer<TransactionBloc, TransactionState>(
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
                        loaded: (data) async {
                          // Close bottom sheet first
                          Navigator.pop(context);

                          // Show success alert
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  const Text('Transaksi berhasil ditambahkan'),
                              backgroundColor: Colors.green,
                              behavior: SnackBarBehavior.fixed,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16),
                                ),
                              ),
                            ),
                          );
                          // Refresh transaction list after alert is closed
                          final authData =
                              await AuthLocalDatasource().getAuthData();
                          if (authData?.userId != null && context.mounted) {
                            context.read<TransactionListBloc>().add(
                                  TransactionListEvent.getTransactions(
                                    userId: authData!.userId!,
                                    month: DateFormat('yyyy-MM')
                                        .format(DateTime.now()),
                                  ),
                                );
                          }
                        },
                      );
                    },
                    builder: (context, state) {
                      return SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: state.maybeWhen(
                            orElse: () => () async {
                              if (_formKey.currentState!.validate()) {
                                final authData =
                                    await AuthLocalDatasource().getAuthData();
                                if (authData?.userId == null) return;

                                final amount = int.parse(
                                  amountController.text.replaceAll('.', ''),
                                );

                                final request = TransactionRequestModel(
                                  type: selectedType,
                                  category: selectedCategory == 'Lain-Lain'
                                      ? categoryOtherController.text
                                      : selectedCategory!,
                                  subCategory:
                                      subCategoryController.text.isNotEmpty
                                          ? subCategoryController.text
                                          : null,
                                  amount: amount,
                                  note: noteController.text,
                                );

                                if (context.mounted) {
                                  context.read<TransactionBloc>().add(
                                        TransactionEvent.createTransaction(
                                          userId: authData!.userId!,
                                          request: request,
                                          context: context,
                                        ),
                                      );
                                }
                              }
                            },
                            loading: () => null,
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: state.maybeWhen(
                            orElse: () => const Text(
                              'Simpan',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
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
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Widget untuk Card Jenis Transaksi
class _TransactionTypeCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _TransactionTypeCard({
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withOpacity(0.1)
              : isDarkMode
                  ? Colors.white.withOpacity(0.05)
                  : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : isDarkMode
                    ? Colors.white.withOpacity(0.1)
                    : Colors.grey.shade300,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.primary : Colors.grey,
            ),
            const SpaceHeight(4),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? AppColors.primary : Colors.grey,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget untuk TextField yang Konsisten
class _CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? prefixText;
  final TextInputType? keyboardType;
  final int? maxLines;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const _CustomTextField({
    required this.controller,
    required this.hintText,
    this.prefixText,
    this.keyboardType,
    this.maxLines = 1,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        prefixText: prefixText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: isDarkMode
                ? Colors.white.withOpacity(0.1)
                : Colors.grey.shade300,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: isDarkMode
                ? Colors.white.withOpacity(0.1)
                : Colors.grey.shade300,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
    );
  }
}
