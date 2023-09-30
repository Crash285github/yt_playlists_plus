import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/services/popup_service/open_textfield_dialog.dart';
import 'package:yt_playlists_plus/services/popup_service/popup_service.dart';
import 'package:yt_playlists_plus/services/popup_service/show_snackbar.dart';
import 'package:yt_playlists_plus/controller/settings_controllers/theme_controller.dart';
import 'package:yt_playlists_plus/view/layouts/pages/playlist_page/tabs/videos/planned/empty_planned.dart';
import 'package:yt_playlists_plus/view/layouts/pages/playlist_page/tabs/videos/planned/planned_list.dart';
import 'package:yt_playlists_plus/controller/playlists_controller.dart';

class PlannedPanel extends StatefulWidget {
  final Set<String> planned;
  final ScrollController scrollController;
  final Function()? onHandleTapped;

  const PlannedPanel({
    super.key,
    required this.planned,
    required this.scrollController,
    required this.onHandleTapped,
  });

  @override
  State<PlannedPanel> createState() => _PlannedPanelState();
}

class _PlannedPanelState extends State<PlannedPanel> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  bool canSubmitPlanned(String title) {
    if (title.trim().isEmpty) {
      PopUpService().showSnackBar(
        context: context,
        message: "Can't be empty.",
      );
      return false;
    }

    if (widget.planned.contains(title.trim())) {
      PopUpService().showSnackBar(
        context: context,
        message: "Already exists.",
      );
      return false;
    }

    return true;
  }

  Future<void> addTitle() async {
    final String? title = await PopUpService().openTextFieldDialog(
      context: context,
      controller: _textEditingController,
      title: "Add new planned video",
      label: "Enter title",
      submitLabel: "Add",
    );

    if (title == null) return;
    if (canSubmitPlanned(title)) {
      setState(() {
        widget.planned.add(title);
      });
      PlaylistsController().save();
    }
  }

  void deleteTitle(String title) {
    setState(() {
      widget.planned.remove(title);
    });
    PlaylistsController().save();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      )),
      elevation: 5,
      color: ThemeController().isAmoled
          ? Colors.black
          : Theme.of(context).colorScheme.background,
      surfaceTintColor: Theme.of(context).colorScheme.primary,
      child: widget.planned.isEmpty
          ? EmptyPlanned(
              onAddPressed: addTitle,
              scrollController: widget.scrollController,
              onHandleTapped: widget.onHandleTapped,
            )
          : PlannedList(
              scrollController: widget.scrollController,
              planned: widget.planned,
              onAddPressed: addTitle,
              onDeletePressed: deleteTitle,
              onHandleTapped: widget.onHandleTapped,
            ),
    );
  }
}
