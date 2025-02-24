import 'package:equatable/equatable.dart';

import '../../models/games/_game_model.dart';

class GameState extends Equatable {
  final List<GameModel> games;
  final int selectedGameIndex;

  const GameState({
    this.games = const [],
    this.selectedGameIndex = 0,
  });

  GameState copyWith({List<GameModel>? games, int? selectedGameIndex}) {
    return GameState(
      games: games ?? this.games,
      selectedGameIndex: selectedGameIndex ?? this.selectedGameIndex,
    );
  }

  @override
  List<Object?> get props => [games, selectedGameIndex];
}
