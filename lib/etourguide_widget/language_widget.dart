import 'package:flutter/material.dart';
import 'package:flutter_etourguide/constraint.dart';
import 'package:flutter_etourguide/etouguide_view/animation/FadeAnimation.dart';
import 'package:flutter_etourguide/etouguide_view/logo_screen_view.dart';

class LanguageWidget extends StatefulWidget {
  @override
  _LanguageWidgetState createState() => _LanguageWidgetState();
}

class _LanguageWidgetState extends State<LanguageWidget> {
  String defaultItem = "Chọn ngôn ngữ (Select language)";
  List<String> item = ["Tiếng Việt (Vietnamese)", "Tiếng Anh (English)"];
  String selectedItem;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: dropDownList(),
        ),
        Positioned(
            top: 0,
            right: 0,
            child: FadeAnimation(
              1.5,
              Container(
                width: 161,
                height: 245,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/theme1.png"),
                        fit: BoxFit.fill)),
              ),
            )),
        Positioned(
            bottom: 0,
            left: 0,
            child: FadeAnimation(
              1.8,
              Container(
                width: 161,
                height: 235,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/theme2.png"),
                        fit: BoxFit.fill)),
              ),
            )),
        Positioned(
          bottom: MediaQuery.of(context).size.height * 0.25,
          left: MediaQuery.of(context).size.width * 0.3,
          right: MediaQuery.of(context).size.width * 0.3,
          child: FadeAnimation(
            2.3,
            Container(
              height: MediaQuery.of(context).size.height * 0.06,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                color: kPrimaryColor,
                child: Icon(
                  Icons.arrow_right_alt,
                  color: Colors.white,
                  size: 16,
                ),
                onPressed: () {
                  if (selectedItem.contains("Vietnamese")) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => LogoScreenView()));
                  } else if (selectedItem.contains("English")) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => LogoScreenView(
                              localization: "en",
                            )));
                  }
                },
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Widget dropDownList() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
      child: FadeAnimation(
        2,
        Container(
          padding: EdgeInsets.only(left: 15, right: 15),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                    blurRadius: 2,
                    spreadRadius: 1.5,
                    offset: Offset(1, 2),
                    color: kPrimaryColor.withOpacity(0.5))
              ]),
          child: DropdownButton(
            hint: Text('${defaultItem}'), // Not necessary for Option 1
            value: selectedItem,
            onChanged: (newValue) {
              setState(() {
                selectedItem = newValue;
                //print(selectedItem);
              });
            },
            items: item.map((location) {
              return DropdownMenuItem(
                child: Text(
                  location,
                  style: TextStyle(fontFamily: 'Helve', fontSize: 16),
                ),
                value: location,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
