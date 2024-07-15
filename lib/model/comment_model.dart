import 'package:flutter/foundation.dart';
import 'package:instgramclone/model/user_model.dart';

class Commment {
  String? comment;
  Users? commenter;
  Commment({@required this.comment, @required this.commenter});
}
