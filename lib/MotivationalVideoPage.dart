import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MotivationalVideoPage extends StatelessWidget {
  final List<String> videoIds;

  MotivationalVideoPage({required this.videoIds});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Defence Videos'),
      ),
      body: ListView.builder(
        itemCount: videoIds.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Video ${index + 1}'),
            subtitle: YoutubePlayer(
              controller: YoutubePlayerController(
                initialVideoId: videoIds[index],
                flags: YoutubePlayerFlags(
                  autoPlay: false,
                  mute: false,
                ),
              ),
              showVideoProgressIndicator: true,
            ),
          );
        },
      ),
    );
  }
}
