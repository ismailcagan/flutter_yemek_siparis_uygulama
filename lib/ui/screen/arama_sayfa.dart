import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_siparis/assets/renkler/renkler.dart';
import 'package:yemek_siparis/data/entity/yemekler.dart';
import 'package:yemek_siparis/ui/cubit/arama_sayfa_cubit.dart';
import 'package:yemek_siparis/ui/screen/sepet_ekle_sayfa.dart';

class AramaSayfa extends StatefulWidget {
  const AramaSayfa({Key? key}) : super(key: key);

  @override
  State<AramaSayfa> createState() => _AramaSayfaState();
}

class _AramaSayfaState extends State<AramaSayfa> {

  String alinanVeri="";
  var tfKontrol = TextEditingController();

  var yemekResimAdi="";
  var yemekAdi="";
  var yemekFiyati="";
  int count =0;
  bool deneme=true;
  String resim ="http://kasimadalan.pe.hu/yemekler/resimler/";
  String mesaj ="";

  @override
  void initState() {
    super.initState();
    context.read<AramaSayfaCubit>().YemekleriGosterAra();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: renk5.withOpacity(0.4),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 25,bottom: 25,left: 50,right: 50),
              child: Card(
                color: renk5.withOpacity(0.4),
                child: TextField(
                  style: TextStyle(fontSize: 25),
                  obscureText: false,
                  //keyboardType: TextInputType.none,
                  controller: tfKontrol,
                  decoration: InputDecoration(hintText: "Ara...",),
                ),
              ),
            ),
            BlocBuilder<AramaSayfaCubit,List<Yemekler>>(
              builder: (context,yemeklerListesi){
                if(yemeklerListesi.isNotEmpty && tfKontrol.text!=""){
                  return Column(
                    children: [
                      ElevatedButton(
                        style: OutlinedButton.styleFrom(backgroundColor: renk1),
                          onPressed:()
                          {
                            setState(() {
                              alinanVeri = tfKontrol.text;

                              for(var i=0;i<yemeklerListesi.length;i++)
                                {
                                  if(yemeklerListesi[i].yemek_adi==alinanVeri ||
                                      yemeklerListesi[i].yemek_adi.toLowerCase() == alinanVeri.toLowerCase() ||
                                  yemeklerListesi[i].yemek_adi.toUpperCase() == alinanVeri.toUpperCase())
                                    {
                                      yemekResimAdi = yemeklerListesi[i].yemek_resim_adi;
                                      yemekAdi = yemeklerListesi[i].yemek_adi;
                                      yemekFiyati = yemeklerListesi[i].yemek_fiyat;
                                      count=0;
                                      return;
                                    }
                                }
                              if(count==0)
                                {
                                tfKontrol.text="";
                                count = count-1;
                                }
                            });
                          },
                          child: Text("Arama Yap",style: TextStyle(fontSize: 20),)),
                      SizedBox(height: 30,),
                      GestureDetector(
                        onTap: ()
                        {
                          setState(() {
                          });

                        },
                        child: Container(
                          height: 250,
                          width: 300,
                          color: renk4,
                          child: Column(
                            children: [
                              SizedBox(
                                  height: 200,
                                  child: Image.network("http://kasimadalan.pe.hu/yemekler/resimler/$yemekResimAdi")),
                              Row( mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("$yemekAdi",style: TextStyle(fontSize: 25),),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text("$yemekFiyati ₺",style: TextStyle(fontSize: 25),),
                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }
                else {

                  return Column(
                    children: [
                      ElevatedButton(
                        style: OutlinedButton.styleFrom(backgroundColor: renk1),
                          onPressed:()
                          {
                            setState(() {
                              alinanVeri = tfKontrol.text;

                              for(var i=0;i<yemeklerListesi.length;i++)
                              {
                                if(yemeklerListesi[i].yemek_adi==alinanVeri ||
                                    yemeklerListesi[i].yemek_adi.toLowerCase() == alinanVeri.toLowerCase() ||
                                    yemeklerListesi[i].yemek_adi.toUpperCase() == alinanVeri.toUpperCase())
                                {
                                  yemekResimAdi = yemeklerListesi[i].yemek_resim_adi;
                                  yemekAdi = yemeklerListesi[i].yemek_adi;
                                  yemekFiyati = yemeklerListesi[i].yemek_fiyat;
                                }
                              }

                            });
                          },
                          child: Text("Arama Yap",style: TextStyle(fontSize: 20),)),

                      Padding(
                        padding: const EdgeInsets.only(top: 100),
                        child: Text("Lütfen Doğru Bilgi Girin..!",
                          style: TextStyle(fontSize: 20),),
                      ),

                    ],
                  );
                }
              },
            ),



          ],
        ),
      ),
    );
  }
}

