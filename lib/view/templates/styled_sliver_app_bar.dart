import 'package:flutter/material.dart';

///A `SliverAppBar` with different default properties
///
///[floating] = true;
///[snap] = true;
///[centerTitle] = true;
class StyledSliverAppBar extends SliverAppBar {
  const StyledSliverAppBar({
    super.centerTitle = true,
    super.floating = true,
    super.snap = true,
    super.actions,
    super.bottom,
    super.pinned,
    super.title,
    super.key,
  });
}
