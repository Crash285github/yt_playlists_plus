import 'package:flutter/material.dart';

///centerTitle, floating & snap properties are set to `true`
customSliverAppBar({required String title, List<Widget>? actions}) => SliverAppBar(
      title: Text(title),
      centerTitle: true,
      floating: true,
      snap: true,
      actions: actions,
    );
