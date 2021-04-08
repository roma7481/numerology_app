part of 'bio_second_cubit.dart';

class BioSecondState {
  final int date;
  final List<double> bio;
  final List<CardData> description;

  BioSecondState({
    this.description = const [],
    this.date,
    this.bio = const [0.0, 0.0, 0.0],
  });
}
