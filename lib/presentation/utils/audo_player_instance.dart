import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

class AudioPlayerManager {
  static final AudioPlayerManager _instance = AudioPlayerManager._internal();
  AudioPlayer? _audioPlayer;

  factory AudioPlayerManager() {
    return _instance;
  }

  AudioPlayerManager._internal();

  Future<void> init() async {
    await JustAudioBackground.init(
      androidNotificationChannelId: 'com.example.app4.channel.audio',
      androidNotificationChannelName: 'Audio Playback',
      androidNotificationOngoing: true,
      androidStopForegroundOnPause: true,
    );

    _audioPlayer = AudioPlayer();
  }

  AudioPlayer get audioPlayer {
    if (_audioPlayer == null) {
      throw Exception("Audio player not initialized");
    }
    return _audioPlayer!;
  }

  void dispose() {
    _audioPlayer?.dispose();
    _audioPlayer = null;
  }
}
