import 'package:codestories/models/story_model.dart';
import 'package:codestories/models/user_model.dart';
//dummy story and user lists.
final userProfileList = [
  const User(
      userName: 'user1', profilePictureUrl: 'https://picsum.photos/200/300'),
  const User(
    userName: 'user2',
    profilePictureUrl: 'https://picsum.photos/200/300',
  ),
  const User(
    userName: 'user3',
    profilePictureUrl: 'https://picsum.photos/200/300',
  ),
  const User(
    userName: 'user4',
    profilePictureUrl: 'https://picsum.photos/200/300',
  ),
  const User(
    userName: 'user5',
    profilePictureUrl: 'https://picsum.photos/200/300',
  ),
  const User(
    userName: 'user6',
    profilePictureUrl: 'https://picsum.photos/200/300',
  ),
  const User(
    userName: 'user7',
    profilePictureUrl: 'https://picsum.photos/200/300',
  ),
];
final userStoryMap = {
  'user1': [
    Story(
        mediaUrl:
            'https://static.videezy.com/system/resources/previews/000/007/536/original/rockybeach.mp4',
        mediaType: MediaType.video),
    Story(
        mediaUrl:
            'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
        mediaType: MediaType.video),
  ],
  'user2': [
    Story(
        mediaUrl:
            'https://static.videezy.com/system/resources/previews/000/007/536/original/rockybeach.mp4',
        mediaType: MediaType.video),
  ],
  'user3': [
    Story(
        mediaUrl:
            'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
        mediaType: MediaType.video),
    Story(
        mediaUrl:
            'https://static.videezy.com/system/resources/previews/000/007/536/original/rockybeach.mp4',
        mediaType: MediaType.video),
    Story(
        mediaUrl:
            'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
        mediaType: MediaType.video),
    Story(
        mediaUrl:
            'https://static.videezy.com/system/resources/previews/000/007/536/original/rockybeach.mp4',
        mediaType: MediaType.video),
  ],
  'user4': [
    Story(
        mediaUrl:
            'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
        mediaType: MediaType.video),
  ],
  'user5': [
    Story(
        mediaUrl:
            'https://static.videezy.com/system/resources/previews/000/005/529/original/Reaviling_Sjusj%C3%B8en_Ski_Senter.mp4',
        mediaType: MediaType.video),
  ],
  'user6': [
    Story(
        mediaUrl:
            'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
        mediaType: MediaType.video),
    Story(
        mediaUrl: 'https://picsum.photos/200/300', mediaType: MediaType.image),
    Story(
        mediaUrl:
            'https://static.videezy.com/system/resources/previews/000/005/529/original/Reaviling_Sjusj%C3%B8en_Ski_Senter.mp4',
        mediaType: MediaType.video),
    Story(
        mediaUrl:
            'https://static.videezy.com/system/resources/previews/000/005/529/original/Reaviling_Sjusj%C3%B8en_Ski_Senter.mp4',
        mediaType: MediaType.video),
    Story(
        mediaUrl:
            'https://picsum.photos/200/300',
        mediaType: MediaType.image),
  ],
  'user7': [
    Story(
        mediaUrl:
            'https://static.videezy.com/system/resources/previews/000/005/529/original/Reaviling_Sjusj%C3%B8en_Ski_Senter.mp4',
        mediaType: MediaType.video),
    Story(
        mediaUrl:
            'https://static.videezy.com/system/resources/previews/000/007/536/original/rockybeach.mp4 ',
        mediaType: MediaType.video),
    Story(
        mediaUrl:
            'https://static.videezy.com/system/resources/previews/000/005/529/original/Reaviling_Sjusj%C3%B8en_Ski_Senter.mp4',
        mediaType: MediaType.video),
  ]
};
