class MusicModel {
  int resultCount;
  List<Results> results;

  // ignore: sort_constructors_first
  MusicModel({this.resultCount, this.results});

  // ignore: sort_constructors_first
  MusicModel.fromJson(Map<String, dynamic> json) {
    resultCount = json['resultCount'] as int;
    if (json['results'] != null) {
      results =  <Results>[];
      // ignore: always_specify_types
      json['results'].forEach((v) => results.add(Results.fromJson(v)));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['resultCount'] = resultCount;
    if (results != null) {
      data['results'] = results.map((Results v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  String wrapperType;
  String kind;
  int artistId;
  int collectionId;
  int trackId;
  String artistName;
  String collectionName;
  String trackName;
  String collectionCensoredName;
  String trackCensoredName;
  String artistViewUrl;
  String collectionViewUrl;
  String trackViewUrl;
  String previewUrl;
  String artworkUrl30;
  String artworkUrl60;
  String artworkUrl100;
  double collectionPrice;
  double trackPrice;
  String releaseDate;
  String collectionExplicitness;
  String trackExplicitness;
  int discCount;
  int discNumber;
  int trackCount;
  int trackNumber;
  int trackTimeMillis;
  String country;
  String currency;
  String primaryGenreName;
  bool isStreamable;
  String collectionArtistName;

  // ignore: sort_constructors_first
  Results(
      {this.wrapperType,
      this.kind,
      this.artistId,
      this.collectionId,
      this.trackId,
      this.artistName,
      this.collectionName,
      this.trackName,
      this.collectionCensoredName,
      this.trackCensoredName,
      this.artistViewUrl,
      this.collectionViewUrl,
      this.trackViewUrl,
      this.previewUrl,
      this.artworkUrl30,
      this.artworkUrl60,
      this.artworkUrl100,
      this.collectionPrice,
      this.trackPrice,
      this.releaseDate,
      this.collectionExplicitness,
      this.trackExplicitness,
      this.discCount,
      this.discNumber,
      this.trackCount,
      this.trackNumber,
      this.trackTimeMillis,
      this.country,
      this.currency,
      this.primaryGenreName,
      this.isStreamable,
      this.collectionArtistName});

  // ignore: sort_constructors_first
  Results.fromJson(Map<String, dynamic> json) {
    wrapperType = json['wrapperType'] as String;
    kind = json['kind'] as String;
    artistId = json['artistId'] as int;
    collectionId = json['collectionId'] as int;
    trackId = json['trackId'] as int;
    artistName = json['artistName'] as String;
    collectionName = json['collectionName'] as String;
    trackName = json['trackName'] as String;
    collectionCensoredName = json['collectionCensoredName'] as String;
    trackCensoredName = json['trackCensoredName'] as String;
    artistViewUrl = json['artistViewUrl'] as String;
    collectionViewUrl = json['collectionViewUrl'] as String;
    trackViewUrl = json['trackViewUrl'] as String;
    previewUrl = json['previewUrl'] as String;
    artworkUrl30 = json['artworkUrl30'] as String;
    artworkUrl60 = json['artworkUrl60'] as String;
    artworkUrl100 = json['artworkUrl100'] as String;
    collectionPrice = json['collectionPrice'] as double;
    trackPrice = json['trackPrice'] as double;
    releaseDate = json['releaseDate'] as String;
    collectionExplicitness = json['collectionExplicitness'] as String;
    trackExplicitness = json['trackExplicitness'] as String;
    discCount = json['discCount'] as int;
    discNumber = json['discNumber'] as int;
    trackCount = json['trackCount'] as int;
    trackNumber = json['trackNumber'] as int;
    trackTimeMillis = json['trackTimeMillis'] as int;
    country = json['country'] as String;
    currency = json['currency'] as String;
    primaryGenreName = json['primaryGenreName'] as String;
    isStreamable = json['isStreamable'] as bool;
    collectionArtistName = json['collectionArtistName'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wrapperType'] = wrapperType;
    data['kind'] = kind;
    data['artistId'] = artistId;
    data['collectionId'] = collectionId;
    data['trackId'] = trackId;
    data['artistName'] = artistName;
    data['collectionName'] = collectionName;
    data['trackName'] = trackName;
    data['collectionCensoredName'] = collectionCensoredName;
    data['trackCensoredName'] = trackCensoredName;
    data['artistViewUrl'] = artistViewUrl;
    data['collectionViewUrl'] = collectionViewUrl;
    data['trackViewUrl'] = trackViewUrl;
    data['previewUrl'] = previewUrl;
    data['artworkUrl30'] = artworkUrl30;
    data['artworkUrl60'] = artworkUrl60;
    data['artworkUrl100'] = artworkUrl100;
    data['collectionPrice'] = collectionPrice;
    data['trackPrice'] = trackPrice;
    data['releaseDate'] = releaseDate;
    data['collectionExplicitness'] = collectionExplicitness;
    data['trackExplicitness'] = trackExplicitness;
    data['discCount'] = discCount;
    data['discNumber'] = discNumber;
    data['trackCount'] = trackCount;
    data['trackNumber'] = trackNumber;
    data['trackTimeMillis'] = trackTimeMillis;
    data['country'] = country;
    data['currency'] = currency;
    data['primaryGenreName'] = primaryGenreName;
    data['isStreamable'] = isStreamable;
    data['collectionArtistName'] = collectionArtistName;
    return data;
  }
}