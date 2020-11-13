import 'package:flutter/material.dart';
import '../../models/Authors.dart';

Widget buildRedakteur(newsCreatedBy) {
  if (Authors.getRedakteur(newsCreatedBy) != null) {
    return Column(
      children: <Widget>[
        Padding(
            padding:
                EdgeInsets.only(top: 10.0, left: 20, right: 20, bottom: 10),
            child: Divider()),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 35,
              backgroundImage: AssetImage(
                Authors.getRedakteur(newsCreatedBy),
              ),
            ),
            Text("   von " + newsCreatedBy),
          ],
        ),
        Padding(
            padding: EdgeInsets.only(top: 10.0, left: 20, right: 20),
            child: Divider()),
      ],
    );
  } else
    return SizedBox();
}

Widget buildRedakteurNewsList(newsCreatedBy) {
  if (Authors.getRedakteur(newsCreatedBy) != null) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 6,
                    color: Colors.black,
                    offset: Offset(2.0, 2.0),
                  )
                ],
              ),
              child: CircleAvatar(
                radius: 35,
                backgroundImage: AssetImage(
                  Authors.getRedakteur(newsCreatedBy),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 10.0, left: 0, right: 0),
        ),
      ],
    );
  } else
    return SizedBox();
}
