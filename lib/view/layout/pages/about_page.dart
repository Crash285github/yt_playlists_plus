import 'dart:io';

import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/view/bottom_padding.dart';
import 'package:yt_playlists_plus/view/template/styled_sliver_app_bar.dart';

///Tells the user about the Application
class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const StyledSliverAppBar(title: Text("About")),
          SliverList(
            delegate: SliverChildListDelegate([
              const _Paragraph("Hi There!"),
              const _Paragraph(
                  "Here I'll explain how to use the app. (It'll be very simple)"),
              const _Paragraph(
                  "At first you won't have any Playlists downloaded. To do that, click the search button."),
              const _Paragraph(
                  "You'll be on the search page. Search for any Playlist you want."),
              const _ProTip(
                  "Pro tip: You can search with keywords, but you can also search with a Playlist's link. Since unlisted Playlists don't appear in the results, you can use it's link to find it."),
              const _Paragraph(
                  "Click on the results to download them. Now you have Playlists you can observe."),
              const _Paragraph(
                  "This means whenever you refresh it, any change that happened to it will be visible on it's page."),
              const _Paragraph(
                  "Each Playlist also saves a history of changes."),
              const _Paragraph(
                  "You can also use a Planned list for each Playlist, for videos you want to add later. (Because for example, it's not on Youtube yet)"),
              _ProTip(
                  "Pro tip: Bringing up the context menu of missing videos (${Platform.isAndroid ? "long-press" : "right-click"}) shows the option to save them to planned."),
            ]),
          ),
          const SliverFillRemaining(hasScrollBody: false),
          const SliverToBoxAdapter(child: BottomPadding()),
        ],
      ),
    );
  }
}

class _Paragraph extends StatelessWidget {
  final String text;
  const _Paragraph(
    this.text,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}

class _ProTip extends StatelessWidget {
  final String text;
  const _ProTip(this.text);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Colors.grey[600]),
        ),
      ),
    );
  }
}
