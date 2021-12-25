import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class NoteVideoView extends StatefulWidget {
  const NoteVideoView({Key? key, required this.path}) : super(key: key);

  final String path;

  @override
  State<NoteVideoView> createState() => _NoteVideoViewState();
}

class _NoteVideoViewState extends State<NoteVideoView> {
  bool startedPlaying = false;
  VideoPlayerController? _videoPlayerController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    super.dispose();
  }

  Future<bool> started() async {
    await _videoPlayerController?.initialize();
    await _videoPlayerController?.play();
    startedPlaying = true;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    _videoPlayerController = VideoPlayerController.asset(widget.path);
    return FutureBuilder<bool>(
      future: started(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.data == true) {
          return AspectRatio(
            aspectRatio: _videoPlayerController!.value.aspectRatio,
            child: VideoPlayer(_videoPlayerController!),
          );
        } else {
          return const Text('waiting for video to load');
        }
      },
    );
  }
}
