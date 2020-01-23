import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import './event_card.dart';
import '../../models/event.dart';
import '../../scoped-models/main.dart';

class EventWidget extends StatelessWidget {
  Widget _buildEventList(List<Event> event) {
    Widget eventCards = Center(
      child: Text('No news found, please add some'),
    );
    if (event.length > 0) {
      eventCards = ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) =>
            EventCard(event[index], index),
        itemCount: 3, //news.length
      );
    } else {
      eventCards = Container();
    }
    return eventCards;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return _buildEventList(model.allEvents);
      },
    );
  }
}
