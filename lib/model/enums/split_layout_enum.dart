enum SplitLayout {
  uneven(left: 2, right: 3, displayName: 'Uneven'),
  even(left: 1, right: 1, displayName: 'Even'),
  disabled(left: 1, right: 1, displayName: 'Disabled'),
  ;

  const SplitLayout({
    required this.left,
    required this.right,
    required this.displayName,
  });

  final int left;
  final int right;
  final String displayName;

  int toJson() => index;
  static SplitLayout fromJson(String json) => values[int.parse(json)];
}
