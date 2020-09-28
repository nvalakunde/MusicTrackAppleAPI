import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobilellc_task/models/music.dart';

class MusicCard extends StatefulWidget {
  final Results musicInstance;
  final bool musicPlaying;
  // ignore: sort_constructors_first
  const MusicCard(this.musicInstance,this.musicPlaying);

  @override
  _MusicCardState createState() => _MusicCardState();
}

class _MusicCardState extends State<MusicCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        // ignore: always_specify_types
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            // ignore: always_specify_types
            children: [
              Container(
                margin: const EdgeInsets.only(left:8,right:8),
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image:
                        NetworkImage(widget.musicInstance.artworkUrl100),
                  ),
                ),
              ),
              Container(
                width:200,
                margin: const EdgeInsets.only(top:10,bottom:10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // ignore: always_specify_types
                  children: [
                    Container(
                      child: Text(
                          // ignore: unnecessary_string_interpolations
                          '${widget.musicInstance.artistName.toUpperCase()}',
                          // overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          )
                          // style: Theme.of(context).textTheme.bodyText1,
                          ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      
                      child: Text(
                        widget.musicInstance.collectionName==null?'':
                        // ignore: unnecessary_string_interpolations
                        '${widget.musicInstance?.collectionName}',
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                            fontWeight: FontWeight.w600,
                          ),
                          )
                    ),
                  ],
                ),
              ),
              if (widget.musicPlaying) Container(
                margin: const EdgeInsets.all(8),
                height: 60,
                width: 60,
                child: const Image(
                  image: AssetImage('assets/music.gif')),
              ) else Container(
                margin: const EdgeInsets.all(8),
                
              ),
              
            ],
          ),
        ],
      ),
    );
  }
}
