import 'dart:io';

import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/view/widgets/preset_sliver_app_bar.dart';

///Tells the user about the Application
class AboutPage extends StatelessWidget {
  final double _padding = 10;

  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const CustomSliverAppBar(title: Text("About")),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: EdgeInsets.all(_padding),
                child: Text(
                  "Hi There!",
                  textAlign: TextAlign.center,
                  style: textTheme.titleLarge,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(_padding),
                child: Text(
                  "Here I'll explain how to use the app. (It'll be very simple)",
                  textAlign: TextAlign.center,
                  style: textTheme.bodyLarge,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(_padding),
                child: Text(
                  "At first you won't have any Playlists downloaded. To do that, click the search button.",
                  textAlign: TextAlign.center,
                  style: textTheme.bodyLarge,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(_padding),
                child: Text(
                  "You'll be on the search page. Search for any Playlist you want.",
                  textAlign: TextAlign.center,
                  style: textTheme.bodyLarge,
                ),
              ),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(_padding),
                  child: Text(
                    "Pro tip: You can search with keywords, but you can also search with a Playlist's link. Since unlisted Playlists don't appear in the results, you can use it's link to find it.",
                    textAlign: TextAlign.center,
                    style:
                        textTheme.bodyLarge!.copyWith(color: Colors.grey[600]),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(_padding),
                child: Text(
                  "Click on the results to download them. Now you have Playlists you can observe.",
                  textAlign: TextAlign.center,
                  style: textTheme.bodyLarge,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(_padding),
                child: Text(
                  "This means whenever you refresh it, any change that happened to it will be visible on it's page.",
                  textAlign: TextAlign.center,
                  style: textTheme.bodyLarge,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(_padding),
                child: Text(
                  "Each Playlist also saves a history of changes.",
                  textAlign: TextAlign.center,
                  style: textTheme.bodyLarge,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(_padding),
                child: Text(
                  "You can also use a Planned list for each Playlist, for videos you want to add later. (Because for example, it's not on Youtube yet)",
                  textAlign: TextAlign.center,
                  style: textTheme.bodyLarge,
                ),
              ),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(_padding),
                  child: Text(
                    "Pro tip: Bringing up the context menu of missing videos (${Platform.isAndroid ? "long-press" : "right-click"}) shows the option to save them to planned.",
                    textAlign: TextAlign.center,
                    style:
                        textTheme.bodyLarge!.copyWith(color: Colors.grey[600]),
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}