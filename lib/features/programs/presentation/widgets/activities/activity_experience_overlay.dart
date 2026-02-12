import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lavender/core/widget/alex_text.dart';

class ActivityExperienceOverlay extends StatefulWidget {
  final String title;
  final Widget content;
  final Color bgColor;
  final VoidCallback onComplete;

  const ActivityExperienceOverlay({
    super.key,
    required this.title,
    required this.content,
    required this.bgColor,
    required this.onComplete,
  });

  @override
  State<ActivityExperienceOverlay> createState() =>
      _ActivityExperienceOverlayState();
}

class _ActivityExperienceOverlayState extends State<ActivityExperienceOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [widget.bgColor, Colors.white],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    padding: EdgeInsets.all(20.w),
                    icon: const Icon(Icons.close, color: Colors.black54),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                SizedBox(height: 20.h),
                AlexText(
                  text: widget.title,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                const Expanded(child: SizedBox()),
                widget.content,
                const Expanded(child: SizedBox()),
                Padding(
                  padding: EdgeInsets.only(bottom: 60.h),
                  child: AlexText(
                    text: "تنفس بعمق.. استرخي..",
                    fontSize: 16,
                    color: Colors.black45,
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
