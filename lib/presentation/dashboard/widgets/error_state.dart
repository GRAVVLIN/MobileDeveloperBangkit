import 'package:flutter/material.dart';
import '../../../core/components/spaces.dart';
import '../../../core/constants/colors.dart';

class ErrorStateWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const ErrorStateWidget({
    Key? key,
    required this.message,
    required this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: Colors.red[300],
            ),
            const SpaceHeight(16.0),
            Text(
              'Oops! Terjadi Kesalahan',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SpaceHeight(8.0),
            Text(
              _getErrorMessage(message),
              style: TextStyle(
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            const SpaceHeight(24.0),
            ElevatedButton.icon(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
              icon: const Icon(Icons.refresh, color: Colors.white),
              label: const Text(
                'Coba Lagi',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getErrorMessage(String error) {
    if (error.contains('Connection closed') || 
        error.contains('Failed host lookup') ||
        error.contains('Connection refused')) {
      return 'Koneksi internet bermasalah.\nPastikan internet Anda aktif dan stabil.';
    }
    if (error.contains('Unauthorized')) {
      return 'Sesi Anda telah berakhir.\nSilakan login kembali.';
    }
    return 'Terjadi kesalahan sistem.\nSilakan coba beberapa saat lagi.';
  }
} 