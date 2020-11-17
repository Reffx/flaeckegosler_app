/* import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';
import '../scoped-models/main.dart';

import '../widgets/ui_elements/logout.dart';
import '../models/event.dart';

import 'dart:async';

class EventAdminPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _EventAdminStatePage();
  }
}

class _EventAdminStatePage extends State<EventAdminPage> {
  final Map<String, dynamic> _formData = {
    'playTime': null,
    'predictedPlayTime': null,
    'location': null,
    'city': null,
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DateTime selectedPlayTimeDate;
  DateTime selectedPredictedPlayTimeDate;
  TimeOfDay selectedPlayTimeHour;
  TimeOfDay selectedPredictedPlayTimeHour;

  DateTime _playTimeDate = new DateTime.now();
  TimeOfDay _playTimeHour = new TimeOfDay.now();

  DateTime _predictedPlayTimeDate = new DateTime.now();
  TimeOfDay _predictedPlayTimeHour = new TimeOfDay.now();

  Future<Null> _selectPredictedPlayTimeDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _predictedPlayTimeDate,
      firstDate: new DateTime(DateTime.now().year - 1),
      lastDate: new DateTime(DateTime.now().year + 1),
    );
    if (picked != null && picked != selectedPredictedPlayTimeDate) {
      setState(() {
        selectedPredictedPlayTimeDate = picked;
        _formData['predictedPlayTime'] =
            selectedPredictedPlayTimeDate.toString();
      });
    }
  }

  Future<Null> _selectPlayTimeDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _playTimeDate,
      firstDate: new DateTime(DateTime.now().year - 1),
      lastDate: new DateTime(DateTime.now().year + 1),
    );
    if (picked != null && picked != selectedPlayTimeDate) {
      setState(() {
        selectedPlayTimeDate = picked;
        _formData['playTime'] = selectedPlayTimeDate.toString();
      });
    }
  }

  Future<Null> _selectPlayTime(BuildContext context) async {
    final TimeOfDay picked =
        await showTimePicker(context: context, initialTime: _playTimeHour);
    if (picked != null && picked != selectedPlayTimeHour) {
      setState(() {
        selectedPlayTimeHour = picked;
        _formData['playTime'] = DateTime(
                selectedPlayTimeDate.year,
                selectedPlayTimeDate.month,
                selectedPlayTimeDate.day,
                selectedPlayTimeHour.hour,
                selectedPlayTimeHour.minute)
            .toString();
      });
    }
  }

  Future<Null> _selectPredictedPlayTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
        context: context, initialTime: _predictedPlayTimeHour);
    if (picked != null && picked != selectedPredictedPlayTimeHour) {
      setState(() {
        selectedPredictedPlayTimeHour = picked;
        _formData['predictedPlayTime'] = DateTime(
                selectedPredictedPlayTimeDate.year,
                selectedPredictedPlayTimeDate.month,
                selectedPredictedPlayTimeDate.day,
                selectedPredictedPlayTimeHour.hour,
                selectedPredictedPlayTimeHour.minute)
            .toString();
      });
    }
  }

  Widget _buildPredictedPlayTimeTextField(Event event) {
    return Column(
      children: <Widget>[
        Text('Date selected: ${_predictedPlayTimeDate.toString()}'),
        RaisedButton(
          child: Text('Wähle das Datum (predicted) der Spielzeit:'),
          onPressed: () {
            print('${_selectPredictedPlayTimeDate(context)}');
          },
        ),
        Text('Time selected: ${_predictedPlayTimeHour.toString()}'),
        RaisedButton(
          child: Text('Wähle geschätzte Spielzeit:'),
          onPressed: () {
            _selectPredictedPlayTime(context);
          },
        ),
      ],
    );
  }

  Widget _buildPlayTimeTextField(Event event) {
    return Column(
      children: <Widget>[
        Text('Date selected: ${_playTimeDate.toString()}'),
        RaisedButton(
          child: Text('Wähle das Datum der Spielzeit:'),
          onPressed: () {
            print('${_selectPlayTimeDate(context)}');
          },
        ),
        Text('Time selected: ${_playTimeHour.toString()}'),
        RaisedButton(
          child: Text('Wähle genaue Spielzeit:'),
          onPressed: () {
            _selectPlayTime(context);
          },
        ),
      ],
    );
  }

  Widget _buildLocationTextField(Event event) {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Location'),
      initialValue: event == null ? '' : event.location,
      validator: (String value) {
        //if (value.trim().length == 0)
        if (value.isEmpty) {
          return 'Location is required';
        }
      },
      onSaved: (String value) {
        _formData['location'] = value;
      },
    );
  }

  Widget _buildCityTextField(Event event) {
    return TextFormField(
      decoration: InputDecoration(labelText: 'City'),
      initialValue: event == null ? '' : event.city,
      validator: (String value) {
        //if (value.trim().length == 0)
        if (value.isEmpty) {
          return 'City is required';
        }
      },
      onSaved: (String value) {
        _formData['city'] = value;
      },
    );
  }

  /* Widget _buildSubmitButton() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return model.isLoading
            ? Center(child: CircularProgressIndicator())
            : RaisedButton(
                child: Text('Save'),
                textColor: Colors.black,
                onPressed: () {
                  _submitForm(model.addEvent, model.updateEvent,
                      model.selectEvent, model.selectedEventIndex);
                },
              );
      },
    );
  } */

  void _submitForm(
      Function addEvent, Function updateEvent, Function setSelectedEvent,
      [int selectedEventIndex]) {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    if (selectedEventIndex == -1) {
      addEvent(
        _formData['playTime'],
        _formData['predictedPlayTime'],
        _formData['location'],
        _formData['city'],
      ).then((bool success) {
        if (success) {
          Navigator.pushReplacementNamed(context, '/ticker')
              .then((_) => setSelectedEvent(null));
        } else {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Something went wrong'),
                  content: Text('Please try again!'),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('Okay'),
                    )
                  ],
                );
              });
        }
      });
    } else {
      updateEvent(
        _formData['playTime'],
        _formData['predictedPlayTime'],
        _formData['location'],
        _formData['city'],
      );
    }
  }

  Widget _buildPageContent(BuildContext context, Event event) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550 ? 500 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
            children: <Widget>[
              _buildPlayTimeTextField(event),
              _buildPredictedPlayTimeTextField(event),
              _buildLocationTextField(event),
              _buildCityTextField(event),
              SizedBox(
                height: 10.0,
              ),
              // _buildSubmitButton(),
              Container(
                child: LogoutWidget(),
              )
            ],
          ),
        ),
      ),
    );
  }

/*  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        final Widget pageContent =
            _buildPageContent(context, model.selectedEvent);
        return /* model.selectedEventIndex == -1
            ? pageContent
            : 
            */
            Scaffold(
          appBar: AppBar(
            title: Text('Edit Events'),
          ),
          body: pageContent,
        );
      },
    );
  }
}*/
*/
