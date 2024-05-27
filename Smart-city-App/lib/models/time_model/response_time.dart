class WorkTime {
  final DateTime? workTimeEnd;
  final int? workTimeId;
  final DateTime? workTimeStart;

  WorkTime({
    this.workTimeEnd,
    this.workTimeId,
    this.workTimeStart,
  });

  factory WorkTime.fromJson(Map<String, dynamic> json) => WorkTime(
        workTimeEnd: json["work_time_end"] == null
            ? null
            : DateTime.parse(json["work_time_end"]),
        workTimeId: json["work_time_id"],
        workTimeStart: json["work_time_start"] == null
            ? null
            : DateTime.parse(json["work_time_start"]),
      );

  Map<String, dynamic> toJson() => {
        "work_time_end": workTimeEnd?.toIso8601String(),
        "work_time_id": workTimeId,
        "work_time_start": workTimeStart?.toIso8601String(),
      };
}
