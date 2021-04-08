part of 'bio_cubit.dart';

class BioState {
  final int date;
  final List<double> bioPrim;
  final List<double> bioSecond;
  final List<CardData> descriptionPrim;
  final List<CardData> descriptionSecond;

  BioState({
    this.date,
    this.bioPrim = const [],
    this.bioSecond = const [],
    this.descriptionPrim = const [],
    this.descriptionSecond = const [],
  });

  BioState copyWith({
    int date,
    List<double> bioPrim,
    List<double> bioSecond,
    List<CardData> descriptionPrim,
    List<CardData> descriptionSecond,
  }) {
    if ((date == null || identical(date, this.date)) &&
        (bioPrim == null || identical(bioPrim, this.bioPrim)) &&
        (bioSecond == null || identical(bioSecond, this.bioSecond)) &&
        (descriptionPrim == null ||
            identical(descriptionPrim, this.descriptionPrim)) &&
        (descriptionSecond == null ||
            identical(descriptionSecond, this.descriptionSecond))) {
      return this;
    }

    return new BioState(
      date: date ?? this.date,
      bioPrim: bioPrim ?? this.bioPrim,
      bioSecond: bioSecond ?? this.bioSecond,
      descriptionPrim: descriptionPrim ?? this.descriptionPrim,
      descriptionSecond: descriptionSecond ?? this.descriptionSecond,
    );
  }
}
