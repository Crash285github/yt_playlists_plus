import 'package:flutter/material.dart';

///centerTitle, floating & snap properties are set to `true` by default
class PresetSliverAppBar extends SliverAppBar {
  const PresetSliverAppBar({
    super.title,
    super.actions,
    super.bottom,
    super.key,
    super.floating = true,
    super.snap = true,
    super.centerTitle = true,
  });
}
