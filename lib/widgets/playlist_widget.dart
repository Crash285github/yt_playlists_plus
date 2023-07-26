import 'package:flutter/material.dart';

class PlaylistWidget extends StatefulWidget {
  const PlaylistWidget({super.key});

  @override
  State<PlaylistWidget> createState() => _PlaylistWidgetState();
}

class _PlaylistWidgetState extends State<PlaylistWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black54,
        ),
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed('/playlist');
          },
          borderRadius: BorderRadius.circular(10),
          child: Row(
            children: [
              Flexible(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          image: DecorationImage(
                              image: NetworkImage(
                                "https://i.ytimg.com/vi/t5vG4Be1Ci8/hq720.jpg?sqp=-oaymwEXCNAFEJQDSFryq4qpAwkIARUAAIhCGAE=&rs=AOn4CLBlLKzzIjDELsCteMUT6W5QQXwGAA",
                              ),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    const Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Titleaaaaaaaaaaaaaaaaaaaaaaaa",
                            style: TextStyle(fontSize: 30),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 20),
                          Text("author"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    SizedBox(height: 60),
                    Icon(
                      Icons.check,
                      color: Colors.green,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
