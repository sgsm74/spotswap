import 'package:spotswap/domain/entities/profile_entity.dart';

class ProfileModel extends Profile {
  const ProfileModel({
    required super.id,
    required super.name,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      ProfileModel(id: json['id'], name: json['display_name']);
}
