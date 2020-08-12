import 'package:flutter/material.dart';
import '../widgets/image_input.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import '../providers/great_places.dart';

//  naudojam stful widget'a nes bus user'io interaction'as bus

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place';

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File _pickedImage;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _savePlace() {
    if (_titleController.text.isEmpty || _pickedImage == null) {
      return;
    }
    Provider.of<GreatPlaces>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage);
        Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new place'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(labelText: 'Title'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ImageInput(_selectImage),
                  ],
                ),
              ),
            ),
          ),
          RaisedButton.icon(
            splashColor: Colors.yellowAccent,
            elevation: 0,
            // knopke nukrenta pilnai iki dugno
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            //  jei butume parase _savePLace() -> tai reiskia, kad uzkrautu iskart,
            //  o, _savePlace -> tai reiskia, jog iskvies sita funkcija ka useris pastaus mygtuka
            onPressed: _savePlace,
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            label: Text(
              'Add place',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            color: Colors.blueGrey,
          ),
        ],
      ),
    );
  }
}
