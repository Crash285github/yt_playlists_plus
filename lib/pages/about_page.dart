import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/widgets/widgets_export.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          customSliverAppBar("About"),
          SliverList(
            delegate: SliverChildListDelegate([
              const Placeholder(
                fallbackHeight: 1000,
              )
            ]),
          ),
        ],
      ),
    );
  }
}
