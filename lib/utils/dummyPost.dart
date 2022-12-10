import 'package:flutter/material.dart';

class UserPosts extends StatelessWidget {
  const UserPosts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.grey[300], shape: BoxShape.circle),
                    child: const CircleAvatar(
                      backgroundImage: NetworkImage('https://picsum.photos/200/300'),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'Name',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const Icon(Icons.menu)
            ],
          ),
        ),
        Container(
          height: 300,
          color: Colors.grey,
          child:
          const Image(image: NetworkImage('https://picsum.photos/200/300')),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.favorite),
                      SizedBox(width: 5.0),
                      Icon(Icons.chat_bubble_outline),
                      SizedBox(width: 5.0),
                      Icon(Icons.share)
                    ],
                  ),
                  const Icon(Icons.bookmark),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Row(children: const [
                  Text('Liked by '),
                  Text(
                    ' Ahmet ', style: TextStyle(fontWeight: FontWeight.bold),),
                  Text('and '),
                  Text(
                    ' Mehmet ', style: TextStyle(fontWeight: FontWeight.bold),),
                  Text('256 others '),
                ],),
              ),
            ],
          ),)
      ]
      ,
    );
  }
}
