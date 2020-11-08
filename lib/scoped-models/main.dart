import 'package:scoped_model/scoped_model.dart';

import './connected_news.dart';

class MainModel extends Model
    with ConnectedNewsModel, UserModel, EventModel, UtilityModel {}
