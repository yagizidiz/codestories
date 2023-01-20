import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String userId;
  final String profilePictureUrl;

  const UserEntity({required this.userId, required this.profilePictureUrl});

  @override
  List<Object?> get props => [userId, profilePictureUrl];
}
