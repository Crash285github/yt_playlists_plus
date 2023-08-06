import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/widgets/preset_sliver_app_bar.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const PresetSliverAppBar(title: Text("About")),
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
