enum InitialPlannedSize {
  ///Default value
  normal(displayName: "Default"),

  ///Lowest setting
  minimal(displayName: "Minimal"),
  ;

  const InitialPlannedSize({required this.displayName});

  final String displayName;
}
