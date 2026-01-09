class BreathingStep {
  final String action;
  final int duration;
  final bool? isExpanding; // true: inhale, false: exhale, null: hold

  BreathingStep({required this.action, required this.duration, this.isExpanding});
}