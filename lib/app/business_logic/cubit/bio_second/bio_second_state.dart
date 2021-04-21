part of 'bio_second_cubit.dart';

abstract class BioSecondState {}

class BioSecondStateLoading extends BioSecondState {}

class BioSecondStateError extends BioSecondState {}

class BioSecondStateReady extends BioSecondState {
  final int date;
  final List<double> bio;
  final List<CardData> description;

  BioSecondStateReady({
    this.description = const [],
    this.date,
    this.bio = const [0.0, 0.0, 0.0],
  });
}
