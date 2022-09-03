import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SuggestionPlaces extends StatefulWidget {
  const SuggestionPlaces({Key? key}) : super(key: key);

  @override
  State<SuggestionPlaces> createState() => _SuggestionPlacesState();
}

//region Notes
/*What is Place Api, How it works
   * => Place api used for searches purposes like if we search any place on google api then
   * he shows us related places for our suggestions so these suggestion are coming from Place Api.
   * Just we need to enable it from console and hit this api using get request.
   * */
//endregion

class _SuggestionPlacesState extends State<SuggestionPlaces> {
  TextEditingController textEditingController = TextEditingController();
  String sessionToken = "123456";
  List<dynamic> placeList = [];

  @override
  void initState() {
    textEditingController.addListener(() {
      onChange();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Container(
              height: double.infinity,
              padding: const EdgeInsets.all(20),
              color: Colors.white,
              child: Column(
                children: [
                  TextField(
                    controller: textEditingController,
                    decoration: const InputDecoration(
                        hintText: "Search Places"
                    ),
                  ),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                        itemCount: placeList.length,
                        itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(placeList[index]["description"]),
                      );
                    }),
                  )
                ],
              ),
            ),
        ));
  }

  void onChange(){
    if(sessionToken == null){
      setState(() {
        sessionToken = "355175A41C0EBB07";
      });
    }
    getSuggestion(textEditingController.text);

  }

  void getSuggestion(String input)async{
    String apiKey = "AIzaSyDQ2c_pOSOFYSjxGMwkFvCVWKjYOM9siow";
    String baseURL = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request = '$baseURL?input=$input&key=$apiKey&sessiontoken=$sessionToken';
    print(request);
    var response = await http.get(Uri.parse(request));
    if(response.statusCode == 200){
      print(response.body);
      setState(() {
        placeList = jsonDecode(response.body.toString())['predictions']; //because response returning in predictions
      });
    }
    else{
      throw Exception("Failed");
    }
  }

}
