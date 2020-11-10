import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import './event_card.dart';
import '../../models/event.dart';

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
    return _buildEventList(
        Provider.of<EventProvider>(context, listen: false).allEvents);
  }
}
