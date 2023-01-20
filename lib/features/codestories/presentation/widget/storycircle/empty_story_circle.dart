import 'package:flutter/material.dart';
import 'package:codestories/features/codestories/domain/entity/user_entity.dart';

class EmptyStoryCircle extends StatelessWidget {
  final UserEntity userEntity;

  const EmptyStoryCircle({Key? key, required this.userEntity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 68,
            height: 68,
            decoration: const BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                      color: Colors.transparent,
                      width: 2,
                    ),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(userEntity.profilePictureUrl),
                        fit: BoxFit.cover)),
                width: 60,
                height: 60,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        SizedBox(
          width: 40,
          child: Text(
            userEntity.userId,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}
