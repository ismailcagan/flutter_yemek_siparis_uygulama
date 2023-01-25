import 'package:flutter/material.dart';
import 'package:yemek_siparis/assets/renkler/renkler.dart';
import 'package:yemek_siparis/ui/screen/ana_sayfa.dart';
import 'package:yemek_siparis/ui/screen/arama_sayfa.dart';
import 'package:yemek_siparis/ui/screen/iletisim.dart';
import 'package:yemek_siparis/ui/screen/sepet_sayfa.dart';

class TabsKontrol extends StatefulWidget {
  const TabsKontrol({Key? key}) : super(key: key);

  @override
  State<TabsKontrol> createState() => _TabsKontrolState();
}

class _TabsKontrolState extends State<TabsKontrol> {
  
  int secilenindeks=0;
  var sayfaListesi =[AnaSayfa(),SepetSayfa(),Iletisim(),AramaSayfa()];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            SizedBox(
              height: 100,
                child: Image.asset("lib/assets/image/cagan_yemek.png")),
            Text("Hoş Gelidiniz.. ",style: TextStyle(color:Colors.black),)
          ],
        ),
      ),
      
      body: sayfaListesi[secilenindeks],
      
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.home_sharp),label: "AnaSayfa"),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),label: "Sepet"),
        BottomNavigationBarItem(icon: Icon(Icons.contact_page),label: "İletişim"),
        BottomNavigationBarItem(icon: Icon(Icons.search),label: "Arama"),
      ],
      backgroundColor: Colors.black,
        selectedItemColor: Colors.grey,
        unselectedItemColor: Colors.black,
        currentIndex: secilenindeks,
        onTap: (indeks){
        print(indeks.toString());
        setState(() {
          secilenindeks=indeks;
        });
        },
      ),
    );
  }
}
