final String tableUsers = 'users';

class UserFields {
  static final List<String> values = [id, name, gender];
  static final String id = '_id';
  static final String name = 'name';
  static final String gender = 'gender';
}

class User {
  final int? id;
  final String name;
  final String gender;

  const User({this.id, required this.name, required this.gender});

  User copy({
    int? id,
    String? name,
    String? gender,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        gender: gender ?? this.gender,
      );

  static User fromJson(Map<String, Object?> json) => User(
        id: json[UserFields.id] as int?,
        name: json[UserFields.name] as String,
        gender: json[UserFields.gender] as String,
      );

  Map<String, Object?> toJson() => {
        UserFields.id: id,
        UserFields.name: name,
        UserFields.gender: gender,
      };
}
