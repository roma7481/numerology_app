class Forecast {
  final String title;
  final String cardTitle;
  final String iconPath;
  final List<String> btnTitles;
  final List<String> contents;
  final List<int> calc;
  final String info;
  String promotionAppLink;

  Forecast({
    this.info,
    this.calc,
    this.cardTitle,
    this.title,
    this.iconPath,
    this.btnTitles,
    this.contents,
    this.promotionAppLink = ''
  });
}
