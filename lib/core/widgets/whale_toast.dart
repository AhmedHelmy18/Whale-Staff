import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:whale_staff/core/constants/app_colors.dart';

enum ToastType { success, error, info, warning }

class WhaleToast extends StatefulWidget {
  final String message;
  final ToastType type;
  final VoidCallback? onDismiss;

  const WhaleToast({
    super.key,
    required this.message,
    this.type = ToastType.info,
    this.onDismiss,
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
              child: Material(
                color: Colors.transparent,
                child: WhaleToast(
                  message: message,
                  type: type,
                  onDismiss: () {
                    if (!isRemoved) {
                      isRemoved = true;
                      overlayEntry.remove();
                    }
                  },
                ),
              ),
            ),
          ),
        );
      },
    );

    overlayState.insert(overlayEntry);
  }

  @override
  State<WhaleToast> createState() => _WhaleToastState();
}

class _WhaleToastState extends State<WhaleToast>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _slideAnimation = Tween<double>(
      begin: 40,
      end: 0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _controller.forward().then((_) {
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          _controller.reverse().then((_) {
            if (mounted) {
              widget.onDismiss?.call();
            }
          });
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    Color color;
    IconData icon;

    switch (widget.type) {
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

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _slideAnimation.value),
          child: Opacity(opacity: _fadeAnimation.value, child: child),
        );
      },
      child: ClipRRect(
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
              border: Border.all(
                color: color.withValues(alpha: 0.2),
                width: 1.5,
              ),
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
                    widget.message,
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
      ),
    );
  }
}
