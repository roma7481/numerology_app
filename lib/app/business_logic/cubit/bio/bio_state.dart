part of 'bio_cubit.dart';

class BioState {
  final int date;
  final double physical;
  final double emotional;
  final double intel;
  final List<CardData> description;

  BioState({
    this.description = const [],
    this.date,
    this.physical,
    this.emotional,
    this.intel,
  });
}
