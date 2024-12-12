import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart'; 
import '../../../data/models/responses/transaction_list_response_model.dart';
import '../../dashboard/bloc/transaction_list/transaction_list_bloc.dart';

class TransactionDetailDialog extends StatelessWidget {
  final Transaction transaction;
  final int summarySaving;

  const TransactionDetailDialog({
    Key? key,
    required this.transaction,
    required this.summarySaving,
  }) : super(key: key);

  void _handleDelete(BuildContext context) {
    // Simpan reference ke bloc
    final bloc = context.read<TransactionListBloc>();
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    
    // Tutup dialog detail
    Navigator.pop(context);

    // Tampilkan dialog konfirmasi
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Konfirmasi Hapus'),
        content: const Text('Apakah Anda yakin ingin menghapus transaksi ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(
              'Batal',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
          TextButton(
            onPressed: () {
              // Tutup dialog konfirmasi
              Navigator.pop(dialogContext);
              
              // Lakukan delete
              bloc.add(
                TransactionListEvent.deleteTransaction(
                  transactionId: transaction.id,
                  month: DateFormat('yyyy-MM').format(transaction.date),
                ),
              );

              // Tampilkan snackbar menggunakan reference yang disimpan
              scaffoldMessenger.showSnackBar(
                SnackBar(
                  content: const Text('Transaksi berhasil dihapus'),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.fixed,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                  ),
                ),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with amount
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: transaction.type == 'income'
                      ? Colors.green.withOpacity(0.1)
                      : Colors.red.withOpacity(0.1),
                  child: Icon(
                    transaction.type == 'income'
                        ? Icons.arrow_upward
                        : Icons.arrow_downward,
                    color: transaction.type == 'income'
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transaction.type == 'income'
                            ? 'Pemasukan'
                            : 'Pengeluaran',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        NumberFormat.currency(
                          locale: 'id',
                          symbol: 'Rp ',
                          decimalDigits: 0,
                        ).format(transaction.amount),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: transaction.type == 'income'
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            // Transaction Details
            _buildDetailRow('Kategori', transaction.category),
            if (transaction.subCategory?.isNotEmpty ?? false)
              _buildDetailRow('Sub Kategori', transaction.subCategory!),
            if (transaction.note?.isNotEmpty ?? false)
              _buildDetailRow('Catatan', transaction.note!),
            _buildDetailRow(
              'Tanggal',
              DateFormat('dd MMMM yyyy, HH:mm').format(transaction.date),
            ),
            _buildDetailRow('Saving', '$summarySaving%'),
            const SizedBox(height: 24),
            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                    label: const Text('Tutup'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _handleDelete(context),
                    icon: const Icon(Icons.delete_outline),
                    label: const Text('Hapus'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          const Text(': '),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
