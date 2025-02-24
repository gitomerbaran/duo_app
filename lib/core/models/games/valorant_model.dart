import '../../constants/enums/icon_enums.dart';
import '../../utils/icon_manager.dart';
import '../../extensions/asset_extension.dart';
import '_game_model.dart';

class Valorant extends GameModel {
  final String nickName;
  final String server;
  final String? rank;
  static final String _icon = IconManager.instance.toPng(IconEnums.CS2.getIcon);
  static final String _gameName = "League of Legends";
   Valorant({
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
