// ignore: file_names
import 'package:listenbox/models/BaseModel.dart';

class DeezerSongModel implements BaseModel {
  int? id;
  bool? readable;
  String? title;
  String? titleShort;
  String? titleVersion;
  String? isrc;
  String? link;
  String? share;
  num? duration;
  num? trackPosition;
  num? diskNumber;
  num? rank;
  String? releaseDate;
  bool? explicitLyrics;
  int? explicitContentLyrics;
  int? explicitContentCover;
  String? preview;
  num? bpm;
  num? gain;
  List<String>? availableCountries;
  List<Contributors>? contributors;
  String? md5Image;
  Artist? artist;
  Album? album;
  String? type;

  DeezerSongModel({
    this.id,
    this.readable,
    this.title,
    this.titleShort,
    this.titleVersion,
    this.isrc,
    this.link,
    this.share,
    this.duration,
    this.trackPosition,
    this.diskNumber,
    this.rank,
    this.releaseDate,
    this.explicitLyrics,
    this.explicitContentLyrics,
    this.explicitContentCover,
    this.preview,
    this.bpm,
    this.gain,
    this.availableCountries,
    this.contributors,
    this.md5Image,
    this.artist,
    this.album,
    this.type,
  });

  DeezerSongModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    readable = json['readable'];
    title = json['title'];
    titleShort = json['title_short'];
    titleVersion = json['title_version'];
    isrc = json['isrc'];
    link = json['link'];
    share = json['share'];
    duration = json['duration'];
    trackPosition = json['track_position'];
    diskNumber = json['disk_number'];
    rank = json['rank'];
    releaseDate = json['release_date'];
    explicitLyrics = json['explicit_lyrics'];
    explicitContentLyrics = json['explicit_content_lyrics'];
    explicitContentCover = json['explicit_content_cover'];
    preview = json['preview'];
    bpm = json['bpm'];
    gain = json['gain'];
    availableCountries = json['available_countries'].cast<String>();
    if (json['contributors'] != null) {
      contributors = <Contributors>[];
      json['contributors'].forEach((v) {
        contributors?.add(Contributors.fromJson(v));
      });
    }
    md5Image = json['md5_image'];
    artist = json['artist'] != null ? Artist.fromJson(json['artist']) : null;
    album = json['album'] != null ? Album.fromJson(json['album']) : null;
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['readable'] = readable;
    data['title'] = title;
    data['title_short'] = titleShort;
    data['title_version'] = titleVersion;
    data['isrc'] = isrc;
    data['link'] = link;
    data['share'] = share;
    data['duration'] = duration;
    data['track_position'] = trackPosition;
    data['disk_number'] = diskNumber;
    data['rank'] = rank;
    data['release_date'] = releaseDate;
    data['explicit_lyrics'] = explicitLyrics;
    data['explicit_content_lyrics'] = explicitContentLyrics;
    data['explicit_content_cover'] = explicitContentCover;
    data['preview'] = preview;
    data['bpm'] = bpm;
    data['gain'] = gain;
    data['available_countries'] = availableCountries;
    if (contributors != null) {
      data['contributors'] = contributors?.map((v) => v.toJson()).toList();
    }
    data['md5_image'] = md5Image;
    if (artist != null) {
      data['artist'] = artist?.toJson();
    }
    if (album != null) {
      data['album'] = album?.toJson();
    }
    data['type'] = type;
    return data;
  }
}

class Contributors {
  int? id;
  String? name;
  String? link;
  String? share;
  String? picture;
  String? pictureSmall;
  String? pictureMedium;
  String? pictureBig;
  String? pictureXl;
  bool? radio;
  String? tracklist;
  String? type;
  String? role;

  Contributors(
      {this.id,
      this.name,
      this.link,
      this.share,
      this.picture,
      this.pictureSmall,
      this.pictureMedium,
      this.pictureBig,
      this.pictureXl,
      this.radio,
      this.tracklist,
      this.type,
      this.role});

  Contributors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    link = json['link'];
    share = json['share'];
    picture = json['picture'];
    pictureSmall = json['picture_small'];
    pictureMedium = json['picture_medium'];
    pictureBig = json['picture_big'];
    pictureXl = json['picture_xl'];
    radio = json['radio'];
    tracklist = json['tracklist'];
    type = json['type'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['link'] = link;
    data['share'] = share;
    data['picture'] = picture;
    data['picture_s,mall'] = pictureSmall;
    data['picture_medium'] = pictureMedium;
    data['picture_big'] = pictureBig;
    data['picture_xl'] = pictureXl;
    data['radio'] = radio;
    data['tracklist'] = tracklist;
    data['type'] = type;
    data['role'] = role;
    return data;
  }
}

class Artist {
  int? id;
  String? name;
  String? link;
  String? share;
  String? picture;
  String? pictureSmall;
  String? pictureMedium;
  String? pictureBig;
  String? pictureXl;
  bool? radio;
  String? tracklist;
  String? type;

  Artist(
      {this.id,
      this.name,
      this.link,
      this.share,
      this.picture,
      this.pictureSmall,
      this.pictureMedium,
      this.pictureBig,
      this.pictureXl,
      this.radio,
      this.tracklist,
      this.type});

  Artist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    link = json['link'];
    share = json['share'];
    picture = json['picture'];
    pictureSmall = json['picture_small'];
    pictureMedium = json['picture_medium'];
    pictureBig = json['picture_big'];
    pictureXl = json['picture_xl'];
    radio = json['radio'];
    tracklist = json['tracklist'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['link'] = link;
    data['share'] = share;
    data['picture'] = picture;
    data['picture_small'] = pictureSmall;
    data['picture_medium'] = pictureMedium;
    data['picture_big'] = pictureBig;
    data['picture_xl'] = pictureXl;
    data['radio'] = radio;
    data['tracklist'] = tracklist;
    data['type'] = type;
    return data;
  }
}

class Album {
  int? id;
  String? title;
  String? link;
  String? cover;
  String? coverSmall;
  String? coverMedium;
  String? coverBig;
  String? coverXl;
  String? md5Image;
  String? releaseDate;
  String? tracklist;
  String? type;

  Album(
      {this.id,
      this.title,
      this.link,
      this.cover,
      this.coverSmall,
      this.coverMedium,
      this.coverBig,
      this.coverXl,
      this.md5Image,
      this.releaseDate,
      this.tracklist,
      this.type});

  Album.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    link = json['link'];
    cover = json['cover'];
    coverSmall = json['cover_small'];
    coverMedium = json['cover_medium'];
    coverBig = json['cover_big'];
    coverXl = json['cover_xl'];
    md5Image = json['md5_image'];
    releaseDate = json['release_date'];
    tracklist = json['tracklist'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['link'] = link;
    data['cover'] = cover;
    data['cover_small'] = coverSmall;
    data['cover_medium'] = coverMedium;
    data['cover_big'] = coverBig;
    data['cover_xl'] = coverXl;
    data['md5_image'] = md5Image;
    data['release_date'] = releaseDate;
    data['tracklist'] = tracklist;
    data['type'] = type;
    return data;
  }
}
