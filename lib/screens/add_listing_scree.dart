import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ghoom_pakistan/screens/home_screen.dart';
import 'package:ghoom_pakistan/widgets/image_input.dart';
import '../models/category.dart';
import '../models/exlusiveListing.dart';
import '../providers/category_provider.dart';
import '../providers/exclusive_provider.dart';
import 'package:provider/provider.dart';

class AddListingScreen extends StatefulWidget {
  static const routeName = '/add-listing';

  @override
  _AddListingScreenState createState() => _AddListingScreenState();
}

class _AddListingScreenState extends State<AddListingScreen> {
  final _priceFocusNode = FocusNode();
  File _pickedImage;
  final _descFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  final _imageUrlController = TextEditingController();
  final _imgUrlFocusNode = FocusNode();
  Category dropdownValue;
  var _spinInit = false;
  var _init = true;
  var listingCats;

  final catnames = [];

  var _listingData = Exclusive(
      title: '',
      description: '',
      phoneNumber: '',
      city: '',
      fullAddress: '',
      emailAdress: '',
      category: null,
      website: '');

  @override
  void initState() {
    _imgUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void dispose() {
    _imgUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descFocusNode.dispose();
    _imageUrlController.dispose();
    _imgUrlFocusNode.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (_init) {
      Provider.of<Categories>(context).fetchListingCategory();
    }
    _init = false;
    listingCats = Provider.of<Categories>(context);
    if (listingCats.listcat.length > 0) {
      dropdownValue = listingCats.listcat[0];
    }
    super.didChangeDependencies();
  }

  void _updateImageUrl() {
    if (!_imgUrlFocusNode.hasFocus) {
      if ((!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('http')) ||
          (!_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.endsWith('.jpeg'))) {
        return null;
      }
      setState(() {});
    }
  }

  String replaceString(String imgUrl) {
    return imgUrl.replaceAll('&amp;', '&');
  }

  void _selectedImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _saveForm() async {
    var isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _spinInit = true;
    });

    await Provider.of<ExclusiveProvider>(context, listen: false)
        .addListing(_listingData, _pickedImage)
        .then((resp) {
      print(resp);
      // if (resp['status'] == 'success') {
      setState(() {
        _spinInit = false;
      });
      //   Navigator.of(context).pop();
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Listing'),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                onSaved: (val) {
                  _listingData = Exclusive(
                      id: null,
                      title: val,
                      description: _listingData.description,
                      phoneNumber: _listingData.phoneNumber,
                      city: _listingData.city,
                      fullAddress: _listingData.fullAddress,
                      emailAdress: _listingData.emailAdress,
                      category: _listingData.category,
                      website: _listingData.website);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please Provide Title';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'City'),
                textInputAction: TextInputAction.next,
                onSaved: (val) {
                  _listingData = Exclusive(
                      id: null,
                      title: _listingData.title,
                      description: _listingData.description,
                      phoneNumber: _listingData.phoneNumber,
                      city: val,
                      emailAdress: _listingData.emailAdress,
                      fullAddress: _listingData.fullAddress,
                      category: _listingData.category,
                      website: _listingData.website);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please Provide City';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Full Address'),
                textInputAction: TextInputAction.next,
                onSaved: (val) {
                  _listingData = Exclusive(
                      id: null,
                      title: _listingData.title,
                      description: _listingData.description,
                      phoneNumber: _listingData.phoneNumber,
                      city: _listingData.city,
                      fullAddress: val,
                      emailAdress: _listingData.emailAdress,
                      category: _listingData.category,
                      website: _listingData.website);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please Provide Full Address';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email Address'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                onSaved: (val) {
                  _listingData = Exclusive(
                      id: null,
                      title: _listingData.title,
                      description: _listingData.description,
                      phoneNumber: _listingData.phoneNumber,
                      city: _listingData.city,
                      fullAddress: _listingData.fullAddress,
                      emailAdress: val,
                      category: _listingData.category,
                      website: _listingData.website);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please Provide Email';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Phone Number'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onSaved: (val) {
                  _listingData = Exclusive(
                      id: null,
                      title: _listingData.title,
                      description: _listingData.description,
                      phoneNumber: val,
                      emailAdress: _listingData.emailAdress,
                      city: _listingData.city,
                      fullAddress: _listingData.fullAddress,
                      category: _listingData.category,
                      website: _listingData.website);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please Provide Phone Number';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number.';
                  }

                  if (double.parse(value) <= 0) {
                    return 'Please entr a numbr greater than zero';
                  }
                  return null;
                },
              ),
              listingCats.listcat.length > 0
                  ? DropdownButton(
                      isExpanded: true,
                      hint: Text('Select Category'),
                      value: dropdownValue,
                      items: listingCats.listcat
                          .map<DropdownMenuItem<Category>>((Category value) {
                        return DropdownMenuItem<Category>(
                          value: value,
                          child: Text(replaceString(value.title)),
                        );
                      }).toList(),
                      icon: Icon(Icons.arrow_downward),
                      iconSize: 24,
                      onChanged: (val) {
                        setState(() {
                          dropdownValue = val;
                          // print(val.id);
                          _listingData = Exclusive(
                              id: null,
                              title: _listingData.title,
                              description: _listingData.description,
                              phoneNumber: _listingData.phoneNumber,
                              city: _listingData.city,
                              emailAdress: _listingData.emailAdress,
                              fullAddress: _listingData.fullAddress,
                              category: replaceString(val.title),
                              website: _listingData.website);
                        });
                      },
                    )
                  : Text('Loading'),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                onSaved: (val) {
                  _listingData = Exclusive(
                      id: null,
                      title: _listingData.title,
                      description: val,
                      phoneNumber: _listingData.phoneNumber,
                      city: _listingData.city,
                      fullAddress: _listingData.fullAddress,
                      emailAdress: _listingData.emailAdress,
                      category: _listingData.category,
                      website: _listingData.website);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'PLease enter a description';
                  }

                  if (value.length < 10) {
                    return 'should be at least 10 characters long';
                  }
                  return null;
                },
              ),
              ImageInput(_selectedImage),
              TextFormField(
                decoration: InputDecoration(labelText: 'Website Link'),
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.url,
                onFieldSubmitted: (_) {
                  _saveForm();
                },
                onSaved: (val) {
                  _listingData = Exclusive(
                      id: null,
                      title: _listingData.title,
                      imgUrl: _listingData.imgUrl,
                      description: _listingData.description,
                      phoneNumber: _listingData.phoneNumber,
                      city: _listingData.city,
                      emailAdress: _listingData.emailAdress,
                      fullAddress: _listingData.fullAddress,
                      category: _listingData.category,
                      website: val);
                },
              ),
              Container(
                height: 40.0,
                margin: EdgeInsets.only(top: 20.0),
                child: ElevatedButton(
                  onPressed: _saveForm,
                  child: _spinInit == true
                      ? Container(
                          height: 20.0,
                          width: 20.0,
                          child: CircularProgressIndicator())
                      : Text('Submit Listing'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
