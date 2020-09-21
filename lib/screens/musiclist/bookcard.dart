import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobilellc_task/models/book.dart';

class MusicCard extends StatefulWidget {
  final Results musicInstance;
  final bool musicPlaying;
  MusicCard(this.musicInstance,this.musicPlaying);

  @override
  _MusicCardState createState() => new _MusicCardState();
}

class _MusicCardState extends State<MusicCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(left:8,right:8),
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image:
                        NetworkImage("${widget.musicInstance.artworkUrl100}"),
                  ),
                ),
              ),
              Container(
                width:200,
                margin: EdgeInsets.only(top:10,bottom:10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                          "${widget.musicInstance.artistName.toUpperCase()}",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          )
                          // style: Theme.of(context).textTheme.bodyText1,
                          ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      
                      child: Text(
                        widget.musicInstance.collectionName==null?"":
                        "${widget.musicInstance?.collectionName}",
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                            fontWeight: FontWeight.w600,
                          ),
                          )
                    ),
                  ],
                ),
              ),
              widget.musicPlaying?
              Container(
                margin: EdgeInsets.all(8),
                height: 60,
                width: 60,
                child: Image(
                  image: AssetImage('assets/music.gif')),
              ):Container(
                margin: EdgeInsets.all(8),
                
              ),
              
            ],
          ),
        ],
      ),
    );
  }
}
