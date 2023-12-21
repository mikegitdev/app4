// part of 'home_bloc.dart';

// @immutable
// sealed class HomeState {}

// final class HomeInitial extends HomeState {}

// final class HomeLoading extends HomeState {}

// final class SongsLoaded extends HomeState {
//   final List<SongModel> songs;

//   SongsLoaded(this.songs);
// }

// final class HomeError extends HomeState {
//   final String message;

//   HomeError(this.message);
// }

import 'package:on_audio_query/on_audio_query.dart';

class HomeState {
  final bool isLoading;
  final List<SongModel>? songs;
  final String? error;

  const HomeState({
    this.isLoading = false,
    this.songs,
    this.error,
  });

  HomeState copyWith({
    bool? isLoading,
    List<SongModel>? songs,
    String? error,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      songs: songs ?? this.songs,
      error: error ?? this.error,
    );
  }

  static HomeState initial() {
    return const HomeState();
  }
}
