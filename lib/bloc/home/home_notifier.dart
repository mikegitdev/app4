import 'package:app4/bloc/home/home_state.dart';
import 'package:app4/data/repositories/home_repository.dart';

class HomeNotifier extends StateNotifierProvider<HomeState> {
  final HomeRepository repository;

  HomeNotifier(this.repository) : super(HomeState.initial());

  Future<void> getSongs() async {
    state = state.copyWith(isLoading: true);
    try {
      final songs = await repository.getSongs();
      state = state.copyWith(isLoading: false, songs: songs);
    } catch (e, s) {
      debugPrintStack(label: e.toString(), stackTrace: s);
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  return HomeNotifier(HomeRepository());
});
