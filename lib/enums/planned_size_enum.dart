enum PlannedSize {
  normal(displayName: "Default"),
  minimal(displayName: "Minimal"),
  ;

  const PlannedSize({required this.displayName});

  final String displayName;

  int toJson() => index;
  static PlannedSize fromJson(int json) => values[json];
}
