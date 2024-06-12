import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoControllerProvider extends ChangeNotifier {
  late VideoPlayerController _controller;

  VideoPlayerController get controller => _controller;

  VideoControllerProvider() {
    _initializeVideo();
  }

  void _initializeVideo() {
    _controller = VideoPlayerController.asset('assets/video.mp4')
      ..initialize().then((_) {
        _controller.play();
        _controller.setLooping(true);
        notifyListeners();
      }).catchError((error) {
        print('Error initializing video: $error');
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
