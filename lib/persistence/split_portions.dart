enum SplitPortions {
  uneven(left: 2, right: 3),
  even(left: 1, right: 1);

  const SplitPortions({required this.left, required this.right});

  final int left;
  final int right;
}
