import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'majors_data.dart';
import 'dart:io' show Platform;
import 'constants.dart';
import 'bottom_button.dart';

enum Financial {yes, no}

class FilterScreen extends StatefulWidget {
  static const String id = 'filter_screen';

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  int satScore = 1000;
  Financial selectedAid;
  String selectedMajor = 'Education';
  String selectedCountry = 'Finland';
  // bool whichDrop = false; false = countries, true = major

  DropdownButton<String> androidDropDown(bool whichDrop){

    List<String> list = whichDrop ? majorsList : countriesList ;

    List<DropdownMenuItem<String>> dropDownItems = [];
    for (int i = 0; i < list.length; i++) {
      String item = list[i];
      var newItem = DropdownMenuItem(
        child: Text(item),
        value: item,
      );

      dropDownItems.add(newItem);
    }
    return DropdownButton<String>(
      isExpanded: true,
      value: whichDrop ? selectedMajor : selectedCountry,
      items: dropDownItems,
      onChanged: (value) {
        setState(() {
          if(whichDrop)
            selectedMajor = value;
          else
            selectedCountry = value;
        });
      },
    );
  }

  CupertinoPicker iOSPicker(bool whichDrop){
    List<Text> pickerItems = [];

    List<String> list = whichDrop ? majorsList : countriesList ;
    for(String item in list){
      pickerItems.add(Text(item));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);

        if(whichDrop)
          selectedMajor = list[selectedIndex];
        else
          selectedCountry = list[selectedIndex];
      },
      children: pickerItems,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SEARCH'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: Text('Choose your major:')),
            Container(
              height: 40.0,
              alignment: Alignment.center,
              child: Platform.isIOS ? iOSPicker(true) : androidDropDown(true),
            ),
            Container(
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: Text('Choose your country:')
            ),
            Container(
              height: 40.0,
              alignment: Alignment.centerLeft,
              child: Platform.isIOS ? iOSPicker(false) : androidDropDown(false),
            ),
            Text(
              'Do you need any financial aid?',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedAid = Financial.yes;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(15.0),
                    height: 50.0,
                    width: 80.0,
                    child: Center(child: Text('YES')),
                    margin: EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      color: selectedAid == Financial.yes ? kActiveCardColour : kInactiveCardColour,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedAid = Financial.no;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(15.0),
                    height: 50.0,
                    width: 80.0,
                    child: Center(child: Text('NO')),
                    margin: EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      color: selectedAid == Financial.no ? kActiveCardColour : kInactiveCardColour,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20.0),
            Text('YOUR SAT SCORE',

            ),
            Text( satScore.toString(),
              style: kNumberTextStyle,
            ),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                  inactiveTrackColor: Color(0xff8d8e98),
                  activeTrackColor: Colors.blueGrey,
                  thumbColor: Color(0xffeb1555),
                  overlayColor: Color(0x29eb1555),
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15.0),
                  overlayShape: RoundSliderOverlayShape(overlayRadius:30.0)
              ),
              child: Slider(
                value: satScore.toDouble(),
                min: 200.0,
                max: 1600.0,
                onChanged: (double newValue){
                  setState(() {
                    satScore = newValue.round();
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('200'),
                  Text('1600')
                ],
              ),
            ),
            SizedBox(height: 10.0),
            
          ],
        ),
      ),
      bottomNavigationBar: BottomButton(
        buttonTitle: 'CALCULATE',
        onTap: (){
        },
      ),
    );
  }}


