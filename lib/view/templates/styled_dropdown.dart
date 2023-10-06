import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/config.dart';

///A pre-styled `DropdownButton`
class StyledDropdown<T> extends DropdownButton {
  StyledDropdown({
    super.key,
    super.value,
    required super.items,
    required super.onChanged,
    super.borderRadius =
        const BorderRadius.all(Radius.circular(AppConfig.defaultCornerRadius)),
    super.padding = const EdgeInsets.symmetric(horizontal: AppConfig.spacing),
    super.underline = const SizedBox.shrink(),
    super.alignment = Alignment.center,
    super.iconSize = 0,
  });
}
