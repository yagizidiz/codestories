import 'package:video_player/video_player.dart';
//Data model for story object
enum MediaType { image, video }

class Story {
  final String mediaUrl;
  final MediaType mediaType;
  late VideoPlayerController? videoController;
  void setController() async {
    if (mediaType == MediaType.video) {
      videoController = VideoPlayerController.network(mediaUrl);
    }
  }

  Future<void> initController() async {
    if (videoController?.value != null) {
      await videoController!.initialize();
      if(mediaType==MediaType.video){}
    }
  }

  Future<void> disposeController() async {
    if (videoController != null) {
      if (videoController!.value.isInitialized) {
        await videoController!.dispose();
      }
    }
  }

  Story({required this.mediaUrl, required this.mediaType});
}
