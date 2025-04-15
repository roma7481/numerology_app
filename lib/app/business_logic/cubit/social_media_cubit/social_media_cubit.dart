import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/SocialMediaLink.dart';
import '../../../data/repository/SocialLinksRepository.dart';

class SocialLinksCubit extends Cubit<SocialLinksState> {
  SocialLinksCubit() : super(SocialLinksLoading());

  void load(String langCode) async {
    emit(SocialLinksLoading());
    try {
      final links = await SocialLinksRepository().getLinksForLanguage(langCode);
      emit(SocialLinksLoaded(links));
    } catch (e) {
      emit(SocialLinksError());
    }
  }
}

abstract class SocialLinksState {}

class SocialLinksLoading extends SocialLinksState {}

class SocialLinksError extends SocialLinksState {}

class SocialLinksLoaded extends SocialLinksState {
  final List<SocialMediaLink> links;
  SocialLinksLoaded(this.links);
}
