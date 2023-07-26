import 'package:flutter/material.dart';

///centerTitle, floating & snap properties are set to `true`
customSliverAppBar(String title) => SliverAppBar(
      title: Text(title),
      centerTitle: true,
      floating: true,
      snap: true,
    );
