import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String? title;
  final String? message;
  final String? confirmText;
  final String? cancelText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;

  const ErrorDialog({
    super.key,
    this.title,
    this.message,
    this.confirmText,
    this.cancelText,
    this.onConfirm,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: Colors.white, // Arka plan rengi
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// **Başlık**
            if (title != null)
              Text(
                title!,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),

            const SizedBox(height: 10),

            /// **Mesaj**
            Text(
              message ?? 'safsgsa',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),

            /// **Butonlar**
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (cancelText != null)
                  TextButton(
                    onPressed: onCancel ?? () => Navigator.pop(context),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.redAccent,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                    ),
                    child: Text(cancelText!),
                  ),
                const SizedBox(width: 10),
                TextButton(
                  onPressed: onConfirm ?? () => Navigator.pop(context),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(confirmText ?? "Tamam"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
