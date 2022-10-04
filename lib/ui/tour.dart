import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:property_box/components/neumorphic_image_buttom.dart';
import 'package:video_player/video_player.dart';

import '../theme/colors.dart';

class Tour extends StatefulWidget {
  final List videos;
  const Tour({required this.videos, Key? key}) : super(key: key);

  @override
  State<Tour> createState() => _TourState();
}

class _TourState extends State<Tour> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColors.dark,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.keyboard_backspace_rounded,
                          color: Colors.white)),
                  GestureDetector(
                      onTap: () {},
                      child:
                          const Icon(Icons.share_outlined, color: Colors.white))
                ],
              ),
              const SizedBox(height: 30),
              Text(
                  '150 Sq.yards  G+1 House at SaiNagar, LB Nagar for 7000000'
                      .toLowerCase(),
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      letterSpacing: -0.15,
                      color: Colors.white.withOpacity(0.87))),
              const SizedBox(height: 20),
              Flexible(
                  child: ListView.builder(
                      itemCount: widget.videos.length,
                      itemBuilder: (context, index) {
                        return VideoPlayPage(
                            videoLink: widget.videos[index],
                            videoName: 'video${index + 1}');
                      }))
            ]),
          ),
        ));
  }
}

class VideoPlayPage extends StatefulWidget {
  final String videoLink;
  final String videoName;
  const VideoPlayPage(
      {required this.videoLink, required this.videoName, Key? key})
      : super(key: key);

  @override
  State<VideoPlayPage> createState() => _VideoPlayPageState();
}

class _VideoPlayPageState extends State<VideoPlayPage> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _controller = VideoPlayerController.network(widget.videoLink);
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);

    super.initState();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Neumorphic(
              padding: const EdgeInsets.all(7),
              style: NeumorphicStyle(
                  shape: NeumorphicShape.flat,
                  color: CustomColors.dark,
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                  shadowLightColor: Colors.black),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: HexColor('1C1C1C')),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // If the video is playing, pause it.
                            if (_controller.value.isPlaying) {
                              setState(() {
                                _controller.pause();
                              });
                            }
                          },
                          child: SizedBox(
                            width: double.maxFinite,
                            height: 250,
                            child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10)),
                                child: InteractiveViewer(
                                    maxScale: 4,
                                    child: VideoPlayer(_controller))),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: Text(widget.videoName,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      color: Colors.white,
                                      letterSpacing: -0.15)),
                            ),
                            const NeumorphicImageButton(
                                image: 'assets/download.png'),
                            const SizedBox(width: 10),
                            const NeumorphicImageButton(
                                image: 'assets/notific.png'),
                          ],
                        )
                      ],
                    ),
                    if (!_controller.value.isPlaying)
                      Padding(
                        padding: EdgeInsets.only(
                            top: _controller.value.aspectRatio * 120),
                        child: Align(
                            alignment: Alignment.center,
                            child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _controller.play();
                                  });
                                },
                                child: Image.asset("assets/play.png"))),
                      ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
