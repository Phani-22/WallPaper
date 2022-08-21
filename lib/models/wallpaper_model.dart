class WallpaperModel {
  String photographer;
  String photographerUrl;
  int photographerId;
  SrcModel src = SrcModel("", "", "");

  WallpaperModel(
    this.src,
    this.photographer,
    this.photographerId,
    this.photographerUrl,
  );
}

class SrcModel {
  String original;
  String small;
  String portrait;

  SrcModel(
    this.original,
    this.portrait,
    this.small,
  );
}
