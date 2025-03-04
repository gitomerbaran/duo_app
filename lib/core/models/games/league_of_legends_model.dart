import '../../constants/enums/icon_enums.dart';
import '../../utils/icon_manager.dart';
import '_game_model.dart';
import '../../extensions/asset_extension.dart';
import '../../constants/game/game_constants.dart';

class LeagueOfLegends extends GameModel {
  final String nickName;
  final String server;
  final String? rank;
  static final String _icon = IconManager.instance.toPng(IconEnums.LOL.getIcon);
  static final String _gameName = GameConstants.LOL;

  LeagueOfLegends({
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
