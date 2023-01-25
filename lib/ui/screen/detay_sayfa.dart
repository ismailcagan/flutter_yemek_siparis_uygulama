import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_siparis/assets/renkler/renkler.dart';
import 'package:yemek_siparis/data/entity/sepet_yemekler.dart';
import 'package:yemek_siparis/data/entity/yemekler.dart';
import 'package:yemek_siparis/ui/cubit/detay_sayfa_cubit.dart';
import 'package:yemek_siparis/ui/cubit/sepet_sayfa_cubit.dart';
import 'package:yemek_siparis/ui/screen/sepet_sayfa.dart';


class DetaySayfa extends StatefulWidget {

  Yemekler yemekler;

  DetaySayfa({required this.yemekler});

  @override
  State<DetaySayfa> createState() => _DetaySayfaState();
}

class _DetaySayfaState extends State<DetaySayfa> {


  String yemek_siparis_adet ="0";
  String yeni_yemek_siparis_adet ="0";
  int count =0;

  var kullaniciAdi ="ismailcagan95@gmail.com";

  @override
  void initState() {
    super.initState();
    context.read<SepetSayfaCubit>().sepetYemekleriGoster("ismailcagan95@gmail.com");
  }

  @override
  Widget build(BuildContext context) {
    var yemek=widget.yemekler;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${yemek.yemek_resim_adi}"),

          Container(
            width: MediaQuery.of(context).size.width,
            height: 400,
            //height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft:Radius.circular(50)),
            ),
            child:Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30,bottom: 70),
                  child: Text("Toplam Üçret :"
                      "${(int.parse(yemek.yemek_fiyat) * int.parse(yemek_siparis_adet)).toString()}",
                    style: TextStyle(fontSize: 30),),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text("${yemek.yemek_adi}", style: TextStyle(fontSize: 30),),
                    ),
                    Spacer(),
                    Card(
                      color: Colors.yellow,
                      child: Row(
                        children: [
                          TextButton(
                              style: OutlinedButton.styleFrom(backgroundColor: arkaPlanColor,foregroundColor: Colors.white),
                              onPressed: ()
                              {
                                setState(() {
                                  yemek_siparis_adet = (int.parse(yemek_siparis_adet) +1).toString();
                                });
                              }, child: Text("+",
                            style: TextStyle(fontSize: 20,),)),

                          Padding(
                            padding: const EdgeInsets.only(left: 15,right: 15),
                            child: Text("${yemek_siparis_adet}",style: TextStyle(fontSize: 25),),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(right: 30),
                            child: TextButton( style: OutlinedButton.styleFrom(backgroundColor: arkaPlanColor,foregroundColor: Colors.white),
                                onPressed: (){
                                  setState(() {
                                    if(int.parse(yemek_siparis_adet)>0)
                                    {
                                      yemek_siparis_adet = (int.parse(yemek_siparis_adet) -1).toString();
                                    }
                                  });
                                }, child: Text("-",style: TextStyle(fontSize: 20),)),
                          ),

                        ],
                      ),
                    ),
                  ],
                ),


                Text("Yeni Siparis Adet :$yeni_yemek_siparis_adet",style: TextStyle(fontSize: 30),),

                Spacer(),
                BlocBuilder<SepetSayfaCubit,List<SepetYemekler>>(
                  builder: (context,sepetlerListesi){
                    if(sepetlerListesi.isNotEmpty)
                      {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 50),
                              child: Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                      style: OutlinedButton.styleFrom(backgroundColor: Colors.black,foregroundColor: Colors.white),
                                      onPressed: ()
                                  {
                                    setState(() {
                                      for(var i = 0; i<sepetlerListesi.length;i++){
                                        if(yemek.yemek_adi == sepetlerListesi[i].yemek_adi){

                                          yeni_yemek_siparis_adet = (int.parse(yemek_siparis_adet) + int.parse(sepetlerListesi[i].yemek_siparis_adet)).toString();
                                          sepetlerListesi[i].yemek_siparis_adet = (int.parse(yemek_siparis_adet) + int.parse(sepetlerListesi[i].yemek_siparis_adet)).toString();

                                          context.read<SepetSayfaCubit>().sil(sepetlerListesi[i].sepet_yemek_id, sepetlerListesi[i].kullanici_adi);
                                          context.read<SepetKayitCubit>().kaydet(
                                              yemek.yemek_adi,
                                              yemek.yemek_resim_adi,
                                              yemek.yemek_fiyat,
                                              yeni_yemek_siparis_adet,
                                              "ismailcagan95@gmail.com");

                                          print("sepet ekleme ${sepetlerListesi[i].yemek_adi}");
                                          count = 0;
                                          return;
                                        }
                                      }
                                      if(count==0){
                                            context.read<SepetKayitCubit>().kaydet(
                                                yemek.yemek_adi,
                                                yemek.yemek_resim_adi,
                                                yemek.yemek_fiyat,
                                                yemek_siparis_adet,
                                                "ismailcagan95@gmail.com");
                                            count=count-1;
                                      }
                                      else
                                      {

                                      }
                                    });
                                  }, child: Text("Seperte Ekle",style: TextStyle(fontSize: 20),)),
                                  ElevatedButton(
                                      style: OutlinedButton.styleFrom(backgroundColor: Colors.black,foregroundColor: Colors.white),
                                      onPressed: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SepetSayfa()));
                                      },
                                      child: Text("Sepete Git",style: TextStyle(fontSize: 20),)),
                                ],
                              ),
                            );
                      }
                    else {return Padding(
                      padding: const EdgeInsets.only(bottom: 50),
                      child: Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              style: OutlinedButton.styleFrom(backgroundColor: Colors.black,foregroundColor: Colors.white),
                              onPressed: ()
                          {
                            context.read<SepetKayitCubit>().kaydet(
                                yemek.yemek_adi,
                                yemek.yemek_resim_adi,
                                yemek.yemek_fiyat,
                                yemek_siparis_adet,
                                "ismailcagan95@gmail.com");
                          }, child: Text("Sepete Ekle")),

                          ElevatedButton(
                              style: OutlinedButton.styleFrom(backgroundColor: Colors.black,foregroundColor: Colors.white),
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>SepetSayfa()));
                              },
                              child: Text("Sepete Git",style: TextStyle(fontSize: 20),))
                        ],
                      ),
                    );}
                  },
                ),

              ],
            ),
          ),


        ],
      ),

    );
  }
}
