enum AppTheme {
  light(displayName: 'Light'),
  dark(displayName: 'Dark'),
  amoled(displayName: 'Amoled'),
  ;

  const AppTheme({required this.displayName});

  final String displayName;

  int toJson() => index;
  static AppTheme fromJson(dynamic json) => values[json];
}
