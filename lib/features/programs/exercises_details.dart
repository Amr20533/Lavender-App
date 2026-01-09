import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lavender/core/widget/alex_text.dart';
import 'package:lavender/core/widget/custom_botton.dart';
import '../../core/themes/app_colors.dart';
import 'dart:async';

import '../../core/widget/back_icon.dart';

class ExercisesDetails extends StatefulWidget {
  final Map<String, dynamic> exerciseData; // Pass the map from the list

  const ExercisesDetails({super.key, required this.exerciseData});

  @override
  State<ExercisesDetails> createState() => _ExercisesDetailsState();
}

class _ExercisesDetailsState extends State<ExercisesDetails> with TickerProviderStateMixin {
  late AnimationController _waveController;
  int _currentStepIndex = 0;
  bool _isStarted = false;
  Timer? _timer;
  int _remainingSeconds = 0;

  @override
  void initState() {
    super.initState();
    // Controller for the pulsing/wave effect
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  void _startExercise() {
    setState(() {
      _isStarted = true;
      _currentStepIndex = 0;
    });
    _runStep();
  }

  void _runStep() {
    final steps = widget.exerciseData['steps'] as List;
    final step = steps[_currentStepIndex];
    _remainingSeconds = step['duration'];

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 1) {
          _remainingSeconds--;
        } else {
          _timer?.cancel();
          _nextStep();
        }
      });
    });
  }

  void _nextStep() {
    final steps = widget.exerciseData['steps'] as List;
    setState(() {
      _currentStepIndex = (_currentStepIndex + 1) % steps.length;
    });
    _runStep();
  }

  @override
  void dispose() {
    _waveController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final steps = widget.exerciseData['steps'] as List;
    final currentStep = steps[_currentStepIndex];

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.white,
        leading: BackIcon(),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 24),
            // Dynamic Data from Constructor
            AlexText(text: widget.exerciseData['title'], fontWeight: FontWeight.w700),
            const SizedBox(height: 12),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: AlexText(
                text: widget.exerciseData['description'],
                fontWeight: FontWeight.w400,
                color: AppColors.subtitleColor,
                fontSize: 14,
                textAlign: TextAlign.center,
              ),
            ),

            const Spacer(),

            // Wave/Glow Animation logic
            Stack(
              alignment: Alignment.center,
              children: [
                if (_isStarted) ...[
                  // Outer Wave 1
                  _buildPulseCircle(0.0),
                  // Outer Wave 2
                  _buildPulseCircle(0.5),
                ],
                // Main Static Circle
                Container(
                  width: 160.w,
                  height: 160.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColorLavenderLangAndText,
                    shape: BoxShape.circle,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AlexText(
                        text: _isStarted ? currentStep['action'] : 'ابدأ',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                      if (_isStarted)
                        AlexText(
                          text: "$_remainingSeconds",
                          color: Colors.white,
                          fontSize: 20,
                        ),
                    ],
                  ),
                ),
              ],
            ),

            const Spacer(),

            CustomButton(
              onPressed: _isStarted ? () => Navigator.pop(context) : _startExercise,
              text: _isStarted ? "إنهاء" : "بدء التمرين",
              backgroundColor: _isStarted ? Colors.grey : AppColors.primaryColorLavenderLangAndText,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // Helper widget to build the "Waves"
  Widget _buildPulseCircle(double delay) {
    return AnimatedBuilder(
      animation: _waveController,
      builder: (context, child) {
        double progress = (_waveController.value + delay) % 1.0;
        return Container(
          width: 160.w + (progress * 100), // Grows up to +100 width
          height: 160.w + (progress * 100),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primaryColorLavenderLangAndText.withOpacity(1.0 - progress),
          ),
        );
      },
    );
  }
}