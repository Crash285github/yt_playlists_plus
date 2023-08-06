import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/widgets/bottom_padding.dart';
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
    return widget.history.isEmpty
        ? Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: _TopRow(
                  onClearPressed: widget.history.isEmpty
                      ? null
                      : () => setState(() => widget.history.clear()),
                ),
              ),
              const Divider(),
              Expanded(
                  child: Center(
                child: Text(
                  "History is empty.",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Colors.grey),
                ),
              ))
            ],
          )
        : ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: _TopRow(
                  onClearPressed: widget.history.isEmpty
                      ? null
                      : () => setState(() => widget.history.clear()),
                ),
              ),
              const Divider(),
              const SizedBox(height: 16),
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
              const BottomPadding(),
            ],
          );
  }
}

class _TopRow extends StatelessWidget {
  final Function()? onClearPressed;

  const _TopRow({
    required this.onClearPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "History",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        TextButton(
          onPressed: onClearPressed,
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text("Clear"), Icon(Icons.clear)],
          ),
        )
      ],
    );
  }
}
