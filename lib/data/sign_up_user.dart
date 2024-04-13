import 'package:smart_connected_health/data/user_entity.dart';

import 'firebase_controller.dart';

class UserController {
  final _firebase = FirebaseController();
  final _collection = 'users';

  Future<bool> signUpUser(UserEntity user) async {
    try {
      await _firebase.updateData(
        data: user,
        id: user.id,
        collection: _collection,
      );
      return true;
    } catch (e, stackTrace) {
      return Future.error(
          "Error while signing up user ${e.toString()}{", stackTrace);
    }
  }
}
