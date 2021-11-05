final String tableUsers = 'users';

class UserFields {
  static final List<String> values = [id, name, gender, userpassword];
  static final String id = '_id';
  static final String name = 'name';
  static final String gender = 'gender';
  static final String userpassword = 'userpassword';
}

class User {
  final int? id;
  final String name;
  final String gender;
  final String userpassword;

  const User({
    this.id,
    required this.name,
    required this.gender,
    required this.userpassword,
  });

  User copy({
    int? id,
    String? name,
    String? gender,
    String? userpassword,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        gender: gender ?? this.gender,
        userpassword: userpassword ?? this.userpassword,
      );

  static User fromJson(Map<String, Object?> json) {
    // print(json);
    return User(
      id: json[UserFields.id] as int?,
      name: json[UserFields.name] as String,
      gender: json[UserFields.gender] as String,
      userpassword: json[UserFields.userpassword]! as String,
    );
  }

  Map<String, Object?> toJson() => {
        UserFields.id: id,
        UserFields.name: name,
        UserFields.gender: gender,
        UserFields.userpassword: userpassword,
      };
}
