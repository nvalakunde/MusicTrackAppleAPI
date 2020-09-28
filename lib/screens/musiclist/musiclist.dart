import 'dart:async';
import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobilellc_task/models/music.dart';
import 'package:mobilellc_task/screens/musiclist/musiccard.dart';
import 'package:mobilellc_task/services/musicservice.dart';
import 'package:mobilellc_task/utils/colors.dart';
import 'package:mobilellc_task/utils/constantdata.dart';

enum PlayerState { stopped, playing, paused }

class MusicCards extends StatefulWidget {
  @override
  _MusicCardsState createState() => _MusicCardsState();
}

class _MusicCardsState extends State<MusicCards> {
  TextEditingController editingSearchController;
  bool isLoading = false;
  int currentIndex = -1;
  String audioUrl;
  Object redrawObject;

  Duration duration;
  Duration position;
  AudioPlayer audioPlayer;

  String localFilePath;

  PlayerState playerState = PlayerState.stopped;

  bool get isPlaying => playerState == PlayerState.playing;
  bool get isPaused => playerState == PlayerState.paused;

  String get durationText =>
      duration != null ? duration.toString().split('.').first : '';

  String get positionText =>
      position != null ? position.toString().split('.').first : '';

  bool isMuted = false;

  // ignore: always_specify_types
  StreamSubscription _positionSubscription;
  // ignore: always_specify_types
  StreamSubscription _audioPlayerStateSubscription;

  @override
  void initState() {
    super.initState();
    editingSearchController = TextEditingController();
  }

  @override
  void dispose() {
    _positionSubscription.cancel();
    _audioPlayerStateSubscription.cancel();
    audioPlayer.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeColorFaintBlue,
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Card(
            margin: const EdgeInsets.all(10),
            child: Container(
                color: themeColorLightGrey,
                child: TextField(
                  controller: editingSearchController,
                  // ignore: always_specify_types
                  onSubmitted: (String value) => {
                    searchMusics(value).then((MusicModel apiHitData) {
                      if (mounted) {
                        print('apiHitData');
                        print(apiHitData);
                        setState(() {
                          musicData = apiHitData;
                          isLoading = false;
                        });
                      }
                    })
                  },
                  decoration: InputDecoration(
                    focusColor: themeColorGrey,
                    prefixIcon: const Icon(
                      Icons.search,
                      color: themeColorGrey,
                    ),
                    suffixIcon: InkWell(
                      onTap: () {
                        editingSearchController.text = '';
                      },
                      child: Icon(
                        Icons.close,
                        color: editingSearchController.text == ''
                            ? themeColorLightGrey
                            : themeColorGrey,
                      ),
                    ),
                    border: InputBorder.none,
                    labelText: 'Search Artist',
                    labelStyle: Theme.of(context).textTheme.bodyText1,
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: themeColorGrey),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: themeColorBlue),
                    ),
                  ),
                )),
          ),
          // ignore: prefer_if_elements_to_conditional_expressions
          musicData.results == null
              ? Container()
              : Container(
                  color: themeColorFaintBlue,
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Column(
                      // shrinkWrap: true,
                      // ignore: always_specify_types
                      children:
                          // ignore: always_specify_types
                          List.generate(musicData.resultCount, (int index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          currentIndex = index;
                          print('currentIndex');
                          print(currentIndex);
                          audioUrl = musicData.results[index].previewUrl;
                          redrawObject = Object();
                          // isPlaying?stop():play();
                          initAudioPlayer();
                        });
                        
                      },
                      child: MusicCard(
                          musicData.results[index],
                          // ignore: avoid_bool_literals_in_conditional_expressions
                          currentIndex == index ? true : false),
                    );
                  })),
                ),
          Container(
            height: isLoading ? 50.0 : 0,
            color: Colors.transparent,
            child: const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(themeColorBlue),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: currentIndex >= 0
          ? Container(
              key: ValueKey<Object>(redrawObject),
              height: 150,
              child: playerUI(context),
            )
          : Container(
              key: ValueKey<Object>(redrawObject),
              height: 10,
            ),
    );
  }

  void initAudioPlayer() {
    audioPlayer = AudioPlayer();
    play();
    _positionSubscription = audioPlayer.onAudioPositionChanged
// ignore: always_specify_types
        .listen((p) => setState(() => position = p));
    _audioPlayerStateSubscription =
        // ignore: always_specify_types
        audioPlayer.onPlayerStateChanged.listen((s) {
      if (s == AudioPlayerState.PLAYING) {
        setState(() => duration = audioPlayer.duration);
      } else if (s == AudioPlayerState.STOPPED) {
        onComplete();
        setState(() {
          position = duration;
        });
      }
    }, onError: () {
      setState(() {
        playerState = PlayerState.stopped;
        duration = const Duration(seconds: 0);
        position = const Duration(seconds: 0);
      });
    });
    play();
  }

  // ignore: always_specify_types
  Future play() async {
    await audioPlayer.play(audioUrl);
    setState(() {
      // currentlyPlaying=currentIndex;
      playerState = PlayerState.playing;
    });
    setState(() {
      // currentlyPlaying=currentIndex;
    });
  }

  // ignore: always_specify_types
  Future pause() async {
    await audioPlayer.pause();
    setState(() => playerState = PlayerState.paused);
  }

  // ignore: always_specify_types
  Future stop() async {
    await audioPlayer.stop();
    setState(() {
      playerState = PlayerState.stopped;
      position = const Duration();
      currentIndex = -1;
    });
  }

  // ignore: always_specify_types
  Future mute(bool muted) async {
    await audioPlayer.mute(muted);
    setState(() {
      isMuted = muted;
    });
  }

  void onComplete() {
    setState(() => playerState = PlayerState.stopped);
    setState(() {
      currentIndex = -1;
      print('onComplete called');
    });
  }

  Widget playerUI(BuildContext context) {
    return Center(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          // ignore: always_specify_types
          children: [
            Material(child: _buildPlayer()),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayer() => Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // ignore: always_specify_types
          children: [
            // ignore: always_specify_types
            Row(mainAxisSize: MainAxisSize.min, children: [
              IconButton(
                onPressed: isPlaying ? null : () => play(),
                iconSize: 30,
                icon: const Icon(Icons.play_arrow),
                color: Colors.cyan,
              ),
              IconButton(
                onPressed: isPlaying ? () => pause() : null,
                iconSize: 30,
                icon: const Icon(Icons.pause),
                color: Colors.cyan,
              ),
              IconButton(
                onPressed: isPlaying || isPaused ? () => stop() : null,
                iconSize: 30,
                icon: const Icon(Icons.stop),
                color: Colors.cyan,
              ),
            ]),
            if (duration != null)
              Slider(
                value: position?.inMilliseconds?.toDouble() ?? 0.0,
                onChanged: (double value) {
                  return audioPlayer.seek(
                    (value / 1000).roundToDouble(),
                  );
                },
                min: 0.0,
                max: duration.inMilliseconds.toDouble(),
              ),
          ],
        ),
      );
}
