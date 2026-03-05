import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:whale_staff/core/constants/app_colors.dart';

enum ToastType { success, error, info, warning }

class WhaleToast extends StatelessWidget {
  final String message;
  final ToastType type;

  const WhaleToast({
    super.key,
    required this.message,
    this.type = ToastType.info,
  });

  static void show(
    BuildContext context,
    String message, {
    ToastType type = ToastType.info,
  }) {
    final overlayState = Overlay.of(context);
    bool isRemoved = false;
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          bottom: 50,
          left: 20,
          right: 20,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child:
                  Material(
                        color: Colors.transparent,
                        child: WhaleToast(message: message, type: type),
                      )
                      .animate()
                      .fadeIn()
                      .slideY(begin: 1, end: 0, curve: Curves.easeOutBack)
                      .then(delay: 3.seconds)
                      .fadeOut()
                      .callback(
                        callback: (_) {
                          if (!isRemoved) {
                            isRemoved = true;
                            overlayEntry.remove();
                          }
                        },
                      ),
            ),
          ),
        );
      },
    );

    overlayState.insert(overlayEntry);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    Color color;
    IconData icon;

    switch (type) {
      case ToastType.success:
        color = AppColors.success;
        icon = Icons.check_circle_outline;
      case ToastType.error:
        color = AppColors.error;
        icon = Icons.error_outline;
      case ToastType.warning:
        color = AppColors.warning;
        icon = Icons.warning_amber_outlined;
      case ToastType.info:
        color = AppColors.info;
        icon = Icons.info_outline;
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: (isDark ? Colors.black : Colors.white).withValues(
              alpha: 0.1,
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color.withValues(alpha: 0.2), width: 1.5),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  message,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : Colors.black87,
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
