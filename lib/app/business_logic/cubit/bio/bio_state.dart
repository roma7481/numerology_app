part of 'bio_cubit.dart';

class BioState {
  final int? date;
  final List<double> bio;
  final List<CardData> description;

  BioState({
    this.description = const [],
    this.date,
    this.bio = const[0.0, 0.0, 0.0],
  });
}
