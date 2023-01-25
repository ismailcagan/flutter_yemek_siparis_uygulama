import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yemek_siparis/assets/renkler/renkler.dart';

class Iletisim extends StatefulWidget {
  const Iletisim({Key? key}) : super(key: key);

  @override
  State<Iletisim> createState() => _IletisimState();
}

class _IletisimState extends State<Iletisim> {


  Future<void> telefonarama() async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: "05393995115",
    );
    await launchUrl(launchUri);
  }

  // E-MAİL
  String? encodeQueryParameters(Map<String,String> params)
  {
    return params.entries
        .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }


  Future<void> emailMesaj() async
  {
    String subject ="";
    String body ="";

      final Uri emailUri = Uri(
        scheme: 'mailto',
        path: "ismailcagan95@gmail.com",
        query: encodeQueryParameters(
          <String,String>{'subject':subject,'body':body}),
      );
      if(await canLaunch(emailUri.toString())){
        launch(emailUri.toString());
      }
      else{print("e mail hata");}
  }

  double enlem = 0.0;
  double boylam= 0.0;

  Future<void> konumBilgisiAl() async
  {
    var konum = await Geolocator.getCurrentPosition(desiredAccuracy:LocationAccuracy.high);
    setState(() {
      enlem =  konum.latitude;
      boylam = konum.longitude;
      print("Enlem :$enlem");
      print("Boylam :$boylam");

    });
  }

  var konummap= "AIzaSyDmIeIsS_omvq9G9IpyMGLzjLzf34S6ZU8";
  var konumMap = "AIzaSyDyynJC04P_USAWmzvMZ-y29sOXv6vUVR8";
  // 39.9032923,32.6226799
  
  Completer<GoogleMapController> haritaKontrol = Completer();
  var baslangicKonum = CameraPosition(target: LatLng(40.9854523,37.8812243),zoom: 17);


  @override
  void initState() {
    super.initState();
    konumBilgisiAl();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: renk5,
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            Text("Konum Bilgisi",style: TextStyle(fontSize: 25),),
            SizedBox(
                width: 300,
                height: 300,
              child: GoogleMap(
                initialCameraPosition: baslangicKonum,
                onMapCreated: (GoogleMapController controller){
                  haritaKontrol.complete(controller);
                },
              ),
            ),
            Text("Daha fazlası için bize ulaşın!",style: TextStyle(fontSize: 25),),

            //MAİL
            InkWell(
              onTap: (){
                emailMesaj();
              },
              child: Container(
                width: MediaQuery.of(context).size.width/3,
                decoration: BoxDecoration(
                  color: renk4,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0,3)
                    ),
                  ]
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text("Mail",textAlign: TextAlign.center,),
                ),
              ),
            ),

            // TELEFON

            InkWell(
              onTap: (){
                telefonarama();
              },
              child: Container(
                width: MediaQuery.of(context).size.width/3,
                decoration: BoxDecoration(
                    color: renk4,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0,3)
                      ),
                    ]
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text("Phone",textAlign: TextAlign.center,),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
