import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:signscribe/utils/colors.dart';
import 'package:provider/provider.dart';

class TextModel {
  String text = 'https://signscribeoffline.netlify.app/';
}

class TextProvider extends ChangeNotifier {
  final TextModel _textModel = TextModel();

  TextModel get textModel => _textModel;

  void updateText(String newText) {
    _textModel.text = newText;
    notifyListeners();
  }
}

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: whiteColor,
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: secondaryColor,
          automaticallyImplyLeading: true,
          leading: Hero(
            tag: 'back1',
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back,
                color: mainColor,
              ),
            ),
          ),
          title: const Text("Settings",
            style: TextStyle(
              fontFamily: 'Comfortaa',
              fontWeight: FontWeight.w600,
              color: mainColor,
            ),
          ),
        ),
        backgroundColor: secondaryColor,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextField(
                onChanged: (newText) {
                  Provider.of<TextProvider>(context, listen: false).updateText(newText);
                },
                decoration: InputDecoration(
                  labelText: 'Enter Link',
                  hintText: 'Our App Speaks the Language of the Heart',
                  labelStyle: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Comfortaa',
                    fontWeight: FontWeight.w600,
                    ),
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontFamily: 'Comfortaa',
                    fontWeight: FontWeight.w600,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: mainColor), // Border color when not focused
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: mainColor), // Border color when focused
                  ),
                ),
                style: const TextStyle(
                  fontFamily: 'Comfortaa',
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                cursorColor: mainColor,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(mainColor),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Save',
                  style: TextStyle(
                    fontFamily: 'Comfortaa',
                    fontWeight: FontWeight.w600,
                    color: secondaryColor
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}