import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessengerScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        titleSpacing: 20.0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20.0,
              backgroundImage: NetworkImage(
                  'https://hips.hearstapps.com/esquireuk.cdnds.net/15/37/original/original-tom-hardy-esquire-may-cover-promo-11-jpg-4c8bc653.jpg'
              ),
            ),
            SizedBox(
              width: 15.0,
            ),
            Text(
              'Chats',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: (){},
              icon: CircleAvatar(
                backgroundColor: Colors.grey[200],
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.black,
                  size: 18.0,
                ),
              ),
          ),
          IconButton(
            onPressed: (){},
            icon: CircleAvatar(
              backgroundColor: Colors.grey[200],
              child: Icon(
                Icons.edit,
                color: Colors.black,
                size: 18.0,
              ),
            ),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             Container(
               padding: EdgeInsets.all(5.0),
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(15.0),
                 color: Colors.grey[200],
               ),
               child: Row(
                 children: [
                   Icon(
                     Icons.search,
                   ),
                   SizedBox(width: 10.0,),
                   Text('Search'),
                 ],
               ),
             ),
             SizedBox(
               height: 25.0,
             ),
             Container(
               height: 100,
               child: ListView.separated(
                   scrollDirection: Axis.horizontal,
                   shrinkWrap: true,
                   itemBuilder: (context, index) => BuildStoryItem (),
                   separatorBuilder: (context, index) => SizedBox(width: 20,),
                   itemCount: 8
               ),
             ),
             SizedBox(
                height: 20.0,
              ),
             ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => BuildChatItem(),
                  separatorBuilder: (context, index) => SizedBox(height: 15,),
                  itemCount: 12
              ),
            ],
          ),
        ),

      ),
    );
  }


  Widget BuildStoryItem () => Container(
    width: 60,
    child: Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            CircleAvatar(
              radius: 30.0,
              backgroundImage: NetworkImage(
                  'https://hips.hearstapps.com/esquireuk.cdnds.net/15/37/original/original-tom-hardy-esquire-may-cover-promo-11-jpg-4c8bc653.jpg'
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(
                bottom: 2.0,
                end: 2.0,
              ),
              child: CircleAvatar(
                radius: 5.0,
                backgroundColor: Colors.green,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 7,
        ),
        Text(
          'Ahmed Halim',
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );
  Widget BuildChatItem () => Row(
    children: [
      Container(
        width: 60,
        child: Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            CircleAvatar(
              radius: 30.0,
              backgroundImage: NetworkImage(
                  'https://hips.hearstapps.com/esquireuk.cdnds.net/15/37/original/original-tom-hardy-esquire-may-cover-promo-11-jpg-4c8bc653.jpg'
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(
                bottom: 2.0,
                end: 2.0,
              ),
              child: CircleAvatar(
                radius: 5.0,
                backgroundColor: Colors.green,
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        width: 15,
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ahmed Halim',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 17
              ),
            ),
            Row(
              children: [
                Text(
                    'انت فين'
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0
                  ),
                  child: Text(
                      '.'
                  ),
                ),
                Text(
                  '2.03 PM',
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}
