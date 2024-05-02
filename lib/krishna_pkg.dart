library krishna_pkg;

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:krishna_pkg/login_page.dart';

/// A Calculator.
// class Calculator {
//   /// Returns [value] plus 1.
//   int addOne(int value) => value + 1;
// }
class KrishnaPackage extends StatefulWidget {
  final String? keyCode;
  const KrishnaPackage({
    @required this.keyCode,
    Key? key}):super(key: key);

  @override
  State<KrishnaPackage> createState() => _KrishnaPackageState();
}

class _KrishnaPackageState extends State<KrishnaPackage> {
  bool isValid = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUrlResponse(keyId: widget.keyCode!);
  }
  Future getUrlResponse({required String keyId}) async{
    var request = http.Request('GET', Uri.parse('https://uatgoldapi.islamicly.com/api/SafeGold/Get_RedeemGoldStatus?tx_id=$keyId'));//6926539

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      if (response != null) {
        final responseData = await response.stream.bytesToString();
        final mapResponse = json.decode(responseData.toString());
        print('getRedeemGoldStatus mapResponse:: $mapResponse');
        if (mapResponse["status"] == 1) {
          setState(() {
            isValid = true;
          });
          print("isValid::: $isValid");
        }
        }
    }
    else {
    print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return isValid == true? LoginPage():Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Center(
        child: Text('Please pass valid key'),
      ),
    );
  }
}

