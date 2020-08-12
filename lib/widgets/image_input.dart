import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
final Function onSelectImage;

ImageInput(this.onSelectImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;


//  kai nufotkinam, ta pati vaizdeli ideda i maza langeli
  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final imageFile =
        await picker.getImage(source: ImageSource.camera, maxWidth: 600);
    setState(() {
      //  tokiu budu bus pickedPile type'as konvertuotas i file type'a
      _storedImage = File(imageFile.path);
    });
    //  apsirasome vieta kurioje mes saugosim nufotkinta image'a
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    //  tas imageFile.path - trumpalaike direktorija kur issaugomas image'as kai tik jis yra padaromas
    final fileName = path.basename(imageFile.path);
    //  tai reikia..pasiimu image'a ir jo pavadinima, nukopinu ta imige'a
    //  i appDir vieta ir issaugau file'o pavadinima. saugom telefone
    final savedImage = await _storedImage.copy('${appDir.path}/$fileName');
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _storedImage != null
              ? Image.file(_storedImage,
                  fit: BoxFit.cover, width: double.infinity)
              : Text(
                  'NO image taken',
                  textAlign: TextAlign.center,
                ),
          alignment: Alignment.center,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: FlatButton.icon(
            icon: Icon(Icons.camera),
            label: Text('Take picture'),
            textColor: Colors.indigo,
            onPressed: () {
              _takePicture();
            },
          ),
        ),
      ],
    );
  }
}
