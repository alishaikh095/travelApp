import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:ghoom_pakistan/models/exlusiveListing.dart';
import '../providers/exclusive_provider.dart';
import '../providers/event_provider.dart';
import '../widgets/image_input.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/package.dart';

class AddPackageScreen extends StatefulWidget {
  static const routeName = '/add-package';
  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddPackageScreen> {
  final _form = GlobalKey<FormState>();
  File _pickedImage;
  TextEditingController _listingController = new TextEditingController();
  var publisheList;
  TimeOfDay selectedTime = TimeOfDay(
    hour: 12,
    minute: 00,
  );
  var _pkgData = Package(
      id: null,
      title: '',
      pkgListing: null,
      pkgLoc: '',
      startDate: null,
      endDate: null,
      startTime: null,
      endTime: null,
      pkgDesc: '',
      price: null);
  void _presentStartDate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime(2070))
        .then((pickeDate) {
      if (pickeDate == null) {
        return;
      }
      setState(() {
        _pkgData = Package(
            id: null,
            title: _pkgData.title,
            pkgListing: _pkgData.pkgListing,
            pkgLoc: _pkgData.pkgLoc,
            startDate: pickeDate,
            endDate: _pkgData.endDate,
            startTime: _pkgData.startTime,
            endTime: _pkgData.endTime,
            pkgDesc: _pkgData.pkgDesc,
            price: _pkgData.price);
      });
    });
  }

  void _presentendtDate() {
    DateTime startDate;
    if (_pkgData.startDate == null) {
      return;
    }

    startDate = _pkgData.startDate;

    showDatePicker(
            context: context,
            initialDate: startDate,
            firstDate: startDate,
            lastDate: DateTime(2070))
        .then((pickeDate) {
      if (pickeDate == null) {
        return;
      }
      setState(() {
        _pkgData = Package(
            id: null,
            title: _pkgData.title,
            pkgListing: _pkgData.pkgListing,
            pkgLoc: _pkgData.pkgLoc,
            startDate: _pkgData.startDate,
            endDate: pickeDate,
            startTime: _pkgData.startTime,
            endTime: _pkgData.endTime,
            pkgDesc: _pkgData.pkgDesc,
            price: _pkgData.price);
      });
    });
  }

  void _selectStartTime() {
    showTimePicker(context: context, initialTime: selectedTime)
        .then((pickedTime) {
      setState(() {
        setState(() {
          _pkgData = Package(
              id: null,
              title: _pkgData.title,
              pkgListing: _pkgData.pkgListing,
              pkgLoc: _pkgData.pkgLoc,
              startDate: _pkgData.startDate,
              endDate: _pkgData.endDate,
              startTime: formatTimeOfDay(pickedTime),
              endTime: _pkgData.endTime,
              pkgDesc: _pkgData.pkgDesc,
              price: _pkgData.price);
        });
      });
      print(pickedTime);
    });
  }

  String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm();
    return format.format(dt);
  }

  void _selectEndTime() {
    showTimePicker(context: context, initialTime: selectedTime)
        .then((pickedTime) {
      setState(() {
        setState(() {
          _pkgData = Package(
              id: null,
              title: _pkgData.title,
              pkgListing: _pkgData.pkgListing,
              pkgLoc: _pkgData.pkgLoc,
              startDate: _pkgData.startDate,
              endDate: _pkgData.endDate,
              startTime: _pkgData.startTime,
              endTime: formatTimeOfDay(pickedTime),
              pkgDesc: _pkgData.pkgDesc,
              price: _pkgData.price);
        });
      });
      print(pickedTime);
    });
  }

  void _saveForm() async {
    var isValid = _form.currentState.validate();
    if (!isValid || _pickedImage == null) {
      return;
    }

    _form.currentState.save();
    await Provider.of<EventProvider>(context, listen: false)
        .addEvent(_pkgData, _pickedImage);
  }

  void _selectedImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Package'),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                onSaved: (val) {
                  _pkgData = Package(
                      id: null,
                      title: val,
                      pkgListing: _pkgData.pkgListing,
                      pkgLoc: _pkgData.pkgLoc,
                      startDate: _pkgData.startDate,
                      endDate: _pkgData.endDate,
                      startTime: _pkgData.startTime,
                      endTime: _pkgData.endTime,
                      pkgDesc: _pkgData.pkgDesc,
                      price: _pkgData.price);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please Provide Title';
                  }
                  return null;
                },
              ),
              TypeAheadFormField(
                  onSuggestionSelected: (Exclusive suggestion) {
                    final excl = suggestion;
                    this._listingController.text = suggestion.title;
                    _pkgData = Package(
                        id: null,
                        title: _pkgData.title,
                        pkgListing: excl.id,
                        pkgLoc: _pkgData.pkgLoc,
                        startDate: _pkgData.startDate,
                        startTime: _pkgData.startTime,
                        endTime: _pkgData.endTime,
                        endDate: _pkgData.endDate,
                        pkgDesc: _pkgData.pkgDesc,
                        price: _pkgData.price);
                  },
                  debounceDuration: Duration(milliseconds: 500),
                  textFieldConfiguration: TextFieldConfiguration(
                      controller: this._listingController,
                      decoration: InputDecoration(
                          labelText: 'Listing',
                          hintText: 'Start Typing to get Listing')),
                  itemBuilder: (context, Exclusive suggestion) {
                    final pubList = suggestion;
                    return ListTile(
                      title: Text(pubList.title),
                    );
                  },
                  suggestionsCallback: Provider.of<ExclusiveProvider>(context)
                      .fetchPublishedListings),
              TextFormField(
                decoration: InputDecoration(labelText: 'Location'),
                textInputAction: TextInputAction.next,
                onSaved: (val) {
                  _pkgData = Package(
                      id: null,
                      title: _pkgData.title,
                      pkgListing: _pkgData.pkgListing,
                      pkgLoc: val,
                      startDate: _pkgData.startDate,
                      endDate: _pkgData.endDate,
                      startTime: _pkgData.startTime,
                      endTime: _pkgData.endTime,
                      pkgDesc: _pkgData.pkgDesc,
                      price: _pkgData.price);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please Provide Location';
                  }
                  return null;
                },
              ),
              Row(
                children: [
                  Text(
                    _pkgData.startDate == null
                        ? 'No Date Choosen'
                        : DateFormat('MM/dd/yyyy').format(_pkgData.startDate),
                  ),
                  TextButton(
                      onPressed: _presentStartDate,
                      child: Text(
                        'Choose Start Date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ))
                ],
              ),
              Row(
                children: [
                  Text(
                    _pkgData.endDate == null
                        ? 'No Date Choosen'
                        : DateFormat('MM/dd/yyyy').format(_pkgData.endDate),
                  ),
                  TextButton(
                      onPressed: _presentendtDate,
                      child: Text(
                        'Choose End Date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ))
                ],
              ),
              Row(
                children: [
                  Text(
                    _pkgData.startTime == null
                        ? 'No Time Choosen'
                        : _pkgData.startTime.toString(),
                  ),
                  TextButton(
                      onPressed: _selectStartTime,
                      child: Text(
                        'Select Start Time',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ))
                ],
              ),
              Row(
                children: [
                  Text(
                    _pkgData.endTime == null
                        ? 'No Time Choosen'
                        : _pkgData.endTime.toString(),
                  ),
                  TextButton(
                      onPressed: _selectEndTime,
                      child: Text(
                        'Select End Time',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ))
                ],
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                textInputAction: TextInputAction.next,
                onSaved: (val) {
                  _pkgData = Package(
                      id: null,
                      title: _pkgData.title,
                      pkgListing: _pkgData.pkgListing,
                      pkgLoc: _pkgData.pkgLoc,
                      startDate: _pkgData.startDate,
                      endDate: _pkgData.endDate,
                      startTime: _pkgData.startTime,
                      endTime: _pkgData.endTime,
                      pkgDesc: val,
                      price: _pkgData.price);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please Provide Description';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              ImageInput(_selectedImage),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                onSaved: (val) {
                  _pkgData = Package(
                      id: null,
                      title: _pkgData.title,
                      pkgListing: _pkgData.pkgListing,
                      pkgLoc: _pkgData.pkgLoc,
                      startDate: _pkgData.startDate,
                      endDate: _pkgData.endDate,
                      startTime: _pkgData.startTime,
                      endTime: _pkgData.endTime,
                      pkgDesc: _pkgData.pkgDesc,
                      price: val);
                },
              ),
              Container(
                height: 40.0,
                margin: EdgeInsets.only(top: 20.0),
                child: ElevatedButton(
                  onPressed: _saveForm,
                  child: Text('Add Package'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
