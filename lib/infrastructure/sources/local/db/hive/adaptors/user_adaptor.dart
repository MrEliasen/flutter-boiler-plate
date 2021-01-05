import 'package:flutter_app_boilerplate/entities/auth/user.dart';
import 'package:hive/hive.dart';

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = User.adaptorId;

  @override
  User read(BinaryReader reader) {
    return User.fromMap(
      Map<String, dynamic>.from(reader.read() as Map<dynamic, dynamic>),
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer.write(obj.toMap());
  }
}
