class Intake {
  final int recommended;
  final int consumed;

  Intake({required this.recommended, required this.consumed});

  factory Intake.fromJson(Map<String, dynamic> json) {
    return Intake(
      recommended: json['total_recommended_calories'],
      consumed: json['total_consumed_calories'],
    );
  }
}