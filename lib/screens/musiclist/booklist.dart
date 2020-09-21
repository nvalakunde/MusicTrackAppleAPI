import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mobilellc_task/screens/musiclist/bookcard.dart';
import 'package:mobilellc_task/services/bookservice.dart';
import 'package:mobilellc_task/utils/colors.dart';
import 'package:mobilellc_task/utils/constantdata.dart';
import 'package:path_provider/path_provider.dart';

enum PlayerState { stopped, playing, paused }
typedef void OnError(Exception exception);
class BookCards extends StatefulWidget {
  @override
  _BookCardsState createState() => new _BookCardsState();
}

class _BookCardsState extends State<BookCards> {
  TextEditingController editingSearchController;
  bool isLoading = false;
  int currentIndex=-1;
  String audioUrl;
  Object redrawObject;

 Duration duration;
  Duration position;
  AudioPlayer audioPlayer;

  String localFilePath;

  PlayerState playerState = PlayerState.stopped;

  get isPlaying => playerState == PlayerState.playing;
  get isPaused => playerState == PlayerState.paused;

  get durationText =>
      duration != null ? duration.toString().split('.').first : '';

  get positionText =>
      position != null ? position.toString().split('.').first : '';

  bool isMuted = false;

  StreamSubscription _positionSubscription;
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
      // appBar: AppBar(
      //   elevation: 0.0,
      //   backgroundColor: themeColorFaintBlue,
      //   leading: IconButton(
      //     icon: Icon(
      //       Icons.arrow_back,
      //       color: themeColorBlue,
      //     ),
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //   ),
      //   centerTitle: false,
      //   title: Text(
      //     "Music Player",
      //     style: TextStyle(color: themeColorBlue),
      //     textAlign: TextAlign.left,
      //   ),
      // ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(10),
            child: Container(
                color: themeColorLightGrey,
                child: TextField(
                  controller: editingSearchController,
                  onSubmitted: (value) => {
                    searchBook(value).then((apiHitData) {
                      if (this.mounted) {
                        setState(() {
                          musicData = apiHitData;
                          isLoading = false;
                        });
                      }
                    })
                  },
                  // onChanged: (value) async {
                  //   print(value);
                  //   setState(() {
                  //     editingSearchController.text = value;
                  //   });
                  // },
                  decoration: InputDecoration(
                    focusColor: themeColorGrey,
                    prefixIcon: Icon(
                      Icons.search,
                      color: themeColorGrey,
                    ),
                    suffixIcon: InkWell(
                      onTap: () {
                        editingSearchController.text = "";
                      },
                      child: Icon(
                        Icons.close,
                        color: editingSearchController.text == ""
                            ? themeColorLightGrey
                            : themeColorGrey,
                      ),
                    ),
                    border: InputBorder.none,
                    labelText: 'Search Artist',
                    labelStyle: Theme.of(context).textTheme.bodyText1,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: themeColorGrey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: themeColorBlue),
                    ),
                  ),
                )),
          ),
          musicData.results == null
              ? Container()
              : Container(
                  color: themeColorFaintBlue,
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Column(
                      // shrinkWrap: true,
                      children: List.generate(musicData.resultCount, (index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          currentIndex = index;
                          print("currentIndex");
                          print(currentIndex);
                          audioUrl=musicData.results[index].previewUrl;
                          redrawObject=Object();
                          // isPlaying?stop():stop();
                          initAudioPlayer();
                        });
                            
                      },
                      child: MusicCard(musicData.results[index],
                          currentIndex == index ? true : false),
                    );
                  })),
                ),
          Container(
            height: isLoading ? 50.0 : 0,
            color: Colors.transparent,
            child: Center(
              child: new CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(themeColorBlue),
              ),
            ),
          ),
        ],
      ),
      
      bottomNavigationBar:currentIndex >= 0? Container(
        key: ValueKey<Object>(redrawObject),
        height: 150,
        child: playerUI(context),
      ):Container(
        key: ValueKey<Object>(redrawObject),
        height: 10,
      ),
    );
  }

void initAudioPlayer() {
    audioPlayer = AudioPlayer();
    _positionSubscription = audioPlayer.onAudioPositionChanged
        .listen((p) => setState(() => position = p));
    _audioPlayerStateSubscription =
        audioPlayer.onPlayerStateChanged.listen((s) {
          
      if (s == AudioPlayerState.PLAYING) {
        setState(() => duration = audioPlayer.duration);
      } else if (s == AudioPlayerState.STOPPED) {
        onComplete();
        setState(() {
          position = duration;
         
        });
      }
    }, onError: (msg) {
      setState(() {
        playerState = PlayerState.stopped;
        duration = Duration(seconds: 0);
        position = Duration(seconds: 0);
      });
    });
play();
    
  }

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
  Future pause() async {
    await audioPlayer.pause();
    setState(() => playerState = PlayerState.paused);
  }

  Future stop() async {
    await audioPlayer.stop();
    setState(() {
      playerState = PlayerState.stopped;
      position = Duration();
      currentIndex=-1;
    });
  }

  Future mute(bool muted) async {
    await audioPlayer.mute(muted);
    setState(() {
      isMuted = muted;
    });
  }

  void onComplete() {
    setState(() => playerState = PlayerState.stopped);
    setState(() {
      currentIndex=-1;
      print("onComplete called");
    });
  }

  Future<Uint8List> _loadFileBytes(String url, {OnError onError}) async {
    Uint8List bytes;
    try {
      bytes = await readBytes(url);
    } on ClientException {
      rethrow;
    }
    return bytes;
  }

  Future _loadFile() async {
    final bytes = await _loadFileBytes(audioUrl,
        onError: (Exception exception) =>
            print('_loadFile => exception $exception'));

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/audio.mp3');

    await file.writeAsBytes(bytes);
    if (await file.exists())
      setState(() {
        localFilePath = file.path;
      });
  }
  Widget playerUI(BuildContext context) {
    return Center(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            Material(child: _buildPlayer()),
          ],
        ),
      ),
    );
  }
  Widget _buildPlayer() => Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(mainAxisSize: MainAxisSize.min, children: [
              IconButton(
                onPressed: isPlaying ? null : () => play(),
                iconSize: 30,
                icon: Icon(Icons.play_arrow),
                color: Colors.cyan,
              ),
              IconButton(
                onPressed: isPlaying ? () => pause() : null,
                iconSize: 30,
                icon: Icon(Icons.pause),
                color: Colors.cyan,
              ),
              IconButton(
                onPressed: isPlaying || isPaused ? () => stop() : null,
                iconSize: 30,
                icon: Icon(Icons.stop),
                color: Colors.cyan,
              ),
            ]),
            if (duration != null)
              Slider(
                  value: position?.inMilliseconds?.toDouble() ?? 0.0,
                  onChanged: (double value) {
                    return audioPlayer.seek((value / 1000).roundToDouble());
                  },
                  min: 0.0,
                  max: duration.inMilliseconds.toDouble()),
            // if (position != null) _buildMuteButtons(),
            // if (position != null) _buildProgressView()
          ],
        ),
      );
}
