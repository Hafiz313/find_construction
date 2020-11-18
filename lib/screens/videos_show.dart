import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class ChewieListItem extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final bool looping;
  ChewieListItem({@required this.videoPlayerController, this.looping, Key key})
      : super(key: key);
  @override
  _ChewieListItemState createState() => _ChewieListItemState();
}

class _ChewieListItemState extends State<ChewieListItem> with WidgetsBindingObserver{
  ChewieController _chewieController;
  @override
  void initState() {
    super.initState();
    _chewieController = ChewieController(
        videoPlayerController: widget.videoPlayerController..initialize(),
        aspectRatio: 16 / 9,
        autoInitialize: false,
        looping: false,
        errorBuilder: (context, errorMessage) {
          return Center(
              child: Text(
                errorMessage,
                style: TextStyle(color: Colors.white),
              ));
        });
    /*_chewieController.addListener(() {
      setState(() {});
    });*/
    //_chewieController._initialize().then((_) => setState(() {}));
    _chewieController.play();
    WidgetsBinding.instance.addObserver(this);
  }
  @override
  Widget build(BuildContext context) {
    return


      Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child:
        _chewieController != null &&
            _chewieController
                .videoPlayerController.value.initialized
            ? Chewie(
          controller: _chewieController,
        )
            : Container(
          color: Colors.white,
              child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
              CircularProgressIndicator(),
              SizedBox(height: 20),
              Text('Loading'),
          ],
        ),
            ),
      /*  Chewie(
          controller: _chewieController,
        ),*/
      ),
    );
  }
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    widget.videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }
}





