import 'package:flutter/material.dart';
import 'package:codestories/models/user_model.dart';
//One of the two different story circle, this one is dummy without a gradient surrounding, not clickable and functional just here to be displayed until stories are loaded.
class LoadingCircle extends StatefulWidget {
  final User user;

  const LoadingCircle({Key? key, required this.user}) : super(key: key);

  @override
  State<LoadingCircle> createState() => _LoadingCircleState();
}

class _LoadingCircleState extends State<LoadingCircle>
    with SingleTickerProviderStateMixin {
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
              color : Colors.transparent,
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
                        image: NetworkImage(widget.user.profilePictureUrl),
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
            widget.user.userName,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}
