import 'package:equatable/equatable.dart';

abstract class GameModel extends Equatable {
  final String name;
  final String icon;
  

  const GameModel({
    required this.name,
    required this.icon,
  });

  @override
  List<Object?> get props => [name, icon,];
}
