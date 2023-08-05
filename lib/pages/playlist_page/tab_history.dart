import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/widgets/history_widget.dart';
import '../../model/video/video_history.dart';

class HistoryTab extends StatefulWidget {
  final List<VideoHistory> history;
  const HistoryTab({super.key, required this.history});

  @override
  State<HistoryTab> createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> {
  @override
  Widget build(BuildContext context) {
    int index = 0;
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "History",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              TextButton(
                onPressed: widget.history.isEmpty
                    ? null
                    : () => setState(() => widget.history.clear()),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text("Clear"), Icon(Icons.clear)],
                ),
              )
            ],
          ),
        ),
        ...widget.history.reversed.map(
          (videoHistory) {
            index++;
            return HistoryWidget(
              videoHistory: videoHistory,
              firstOfList: index == 1,
              lastOfList: index == widget.history.length,
            );
          },
        ),
        const SizedBox(height: 80),
      ],
    );
  }
}
