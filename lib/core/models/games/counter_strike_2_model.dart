import '../../constants/enums/icon_enums.dart';
import '../../utils/icon_manager.dart';
import '_game_model.dart';
import '../../extensions/asset_extension.dart';

class CounterStrike2 extends GameModel {
  static final String _icon = IconManager.instance.toPng(IconEnums.CS2.getIcon);
  static final String _gameName = "Counter Strike 2";
  final String nickName;

  final String server;
  final String? rank;
  CounterStrike2({
    required this.nickName,
    required this.server,
    this.rank,
  }) : super(
          name: _gameName,
          icon: _icon,
        );

  @override
  List<Object?> get props => super.props..addAll([nickName, server, rank]);
}
