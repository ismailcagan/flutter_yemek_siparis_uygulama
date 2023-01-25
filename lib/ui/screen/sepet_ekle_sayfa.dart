import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_siparis/assets/renkler/renkler.dart';
import 'package:yemek_siparis/data/entity/sepet_yemekler.dart';
import 'package:yemek_siparis/data/entity/yemekler.dart';
import 'package:yemek_siparis/ui/cubit/detay_sayfa_cubit.dart';
import 'package:yemek_siparis/ui/cubit/sepet_sayfa_cubit.dart';
import 'package:yemek_siparis/ui/screen/ana_sayfa.dart';
import 'package:yemek_siparis/ui/screen/sepet_sayfa.dart';

class SepetEkleSayfa extends StatefulWidget {
  Yemekler yemeklerr;

  SepetEkleSayfa({required this.yemeklerr});

  @override
  State<SepetEkleSayfa> createState() => _SepetEkleSayfaState();
}

class _SepetEkleSayfaState extends State<SepetEkleSayfa> {

  String yemek_siparis_adet ="0";
  String yeni_yemek_siparis_adet ="0";
  int aynimi = 0;

  String sepet_adet_sayisi="0";


  @override
  void initState() {
    super.initState();
    context.read<SepetSayfaCubit>().sepetYemekleriGoster("ismailcagan95@gmail.com");
  }

  @override
  Widget build(BuildContext context) {
    var yemek = widget.yemeklerr;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Row(
                children: [
                  IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon:Icon(Icons.chevron_left)),
                  Padding(
                    padding: const EdgeInsets.only(left: 80),
                    child: Text("Yemek Detay",style: TextStyle(fontSize: 25)),
                  ),
                ],
              ),
            ),
            Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${yemek.yemek_resim_adi}"),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 360,
              decoration: BoxDecoration(
                color: renk5.withOpacity(0.5),
                //color:Colors.white.withOpacity(0.25),
                //color: Colors.white,
                borderRadius: BorderRadius.only(topLeft:Radius.circular(50)),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 25,top: 30),
                    child: Row(children: [
                      Column(
                        children: [
                          Text("${yemek.yemek_adi}",style: TextStyle(fontSize: 30,fontFamily: "Quicksand",fontWeight: FontWeight.bold),),
                          SizedBox(height: 10,),
                          Text("Birim Fiyat :${yemek.yemek_fiyat} ₺",style: TextStyle(fontSize: 15,fontFamily: "Quicksand",fontWeight: FontWeight.bold),),
                        ],
                      ),

                      Spacer(),
                      Card(
                        color: Colors.white54,
                        shadowColor: Colors.black,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                        child: Row(
                          children: [
                            TextButton(onPressed: (){

                              setState(() {
                                yemek_siparis_adet = (int.parse(yemek_siparis_adet) + 1).toString();
                              });

                            }, child: Text("+",style: TextStyle(fontSize: 30,color: arkaPlanColor),)),

                            Text("${yemek_siparis_adet}",style: TextStyle(fontSize: 30),),

                            TextButton(onPressed: (){
                              if(int.parse(yemek_siparis_adet) > 0)
                              {
                                setState(() {
                                  yemek_siparis_adet = (int.parse(yemek_siparis_adet) - 1).toString();
                                });
                              }
                            }, child: Text("-",style: TextStyle(fontSize: 30,color: arkaPlanColor),)),
                          ],),
                      ),
                          ],
                        ),
                      ),

                  SizedBox(height: 50,),
                  Text("Toplam Fiyat :${((int.parse(yemek.yemek_fiyat)) * int.parse(yemek_siparis_adet)).toString()} ₺",
                  style: TextStyle(fontSize: 30),),

                  Spacer(),

                  Padding(
                    padding: const EdgeInsets.only(left: 25,right: 25,bottom: 30),
                    child: Row(
                      children: [
                        BlocBuilder<SepetSayfaCubit,List<SepetYemekler>>(
                          builder: (context,sepetListesi){
                            if(sepetListesi.isNotEmpty){
                              return Row(
                                children: [

                                  InkWell(
                                    onTap: (){
                                     setState(() {

                                       if(int.parse(yemek_siparis_adet)>0)
                                       {
                                         for(var i = 0; i<sepetListesi.length; i++)
                                         {
                                           if(sepetListesi[i].yemek_adi == yemek.yemek_adi)
                                           {
                                             yeni_yemek_siparis_adet = (int.parse(yemek_siparis_adet) + int.parse(sepetListesi[i].yemek_siparis_adet)).toString();
                                             context.read<SepetSayfaCubit>().sil(sepetListesi[i].sepet_yemek_id, sepetListesi[i].kullanici_adi);
                                             context.read<SepetKayitCubit>().kaydet(
                                                 yemek.yemek_adi,
                                                 yemek.yemek_resim_adi,
                                                 yemek.yemek_fiyat,
                                                 yeni_yemek_siparis_adet,
                                                 "ismailcagan95@gmail.com");
                                             aynimi = 0;
                                             return;
                                           }

                                         }
                                         if(aynimi == 0)
                                         {
                                           context.read<SepetKayitCubit>().kaydet(
                                               yemek.yemek_adi,
                                               yemek.yemek_resim_adi,
                                               yemek.yemek_fiyat,
                                               yemek_siparis_adet,
                                               "ismailcagan95@gmail.com");
                                           aynimi = -1;
                                         }
                                       }
                                       else
                                       {
                                         ScaffoldMessenger.of(context).showSnackBar(
                                           SnackBar(content: Text("Eksik Bilgi lütfen adet miktarı girin",style: TextStyle(fontSize: 20),),action:
                                           SnackBarAction(label: "Tamam", onPressed: (){
                                           }),),);
                                       }

                                     });
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width/3,
                                      decoration: BoxDecoration(
                                        color:renk1,
                                        //  color: arkaPlanColor,
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
                                        padding: const EdgeInsets.all(15.0),
                                        child: Text("Sepete Ekle",textAlign: TextAlign.center,style: TextStyle(fontSize: 20),),
                                      ),
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(left: 150),
                                    child: Card(
                                        color: renk4,
                                        child: IconButton(onPressed: (){
                                          Navigator.push(context, MaterialPageRoute(builder: ((context) => SepetSayfa())));
                                        }, icon: Icon(Icons.shopping_cart,color: Colors.white,))),
                                  ),
                                ],
                              );
                            }
                            else {return Row(
                              children: [

                                InkWell(
                                  onTap: (){
                                    setState(() {
                                      if(int.parse(yemek_siparis_adet)>0)
                                      {
                                        for(var i = 0; i<sepetListesi.length; i++)
                                        {
                                          if(sepetListesi[i].yemek_adi == yemek.yemek_adi)
                                          {
                                            yeni_yemek_siparis_adet = (int.parse(yemek_siparis_adet) + int.parse(sepetListesi[i].yemek_siparis_adet)).toString();
                                            context.read<SepetSayfaCubit>().sil(sepetListesi[i].sepet_yemek_id, sepetListesi[i].kullanici_adi);
                                            context.read<SepetKayitCubit>().kaydet(
                                                yemek.yemek_adi,
                                                yemek.yemek_resim_adi,
                                                yemek.yemek_fiyat,
                                                yeni_yemek_siparis_adet,
                                                "ismailcagan95@gmail.com");
                                            aynimi = 0;
                                            return;
                                          }

                                        }
                                        if(aynimi == 0)
                                        {
                                          context.read<SepetKayitCubit>().kaydet(
                                              yemek.yemek_adi,
                                              yemek.yemek_resim_adi,
                                              yemek.yemek_fiyat,
                                              yemek_siparis_adet,
                                              "ismailcagan95@gmail.com");
                                          aynimi = -1;
                                        }
                                      }
                                      else
                                      {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text("Eksik Bilgi lütfen adet miktarı girin",style: TextStyle(fontSize: 20),),action:
                                          SnackBarAction(label: "Tamam", onPressed: (){
                                          }),),);
                                      }

                                    });
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width/3,
                                    decoration: BoxDecoration(
                                        color:renk1,
                                        //  color: arkaPlanColor,
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
                                      padding: const EdgeInsets.all(15.0),
                                      child: Text("Sepete Ekle",textAlign: TextAlign.center,style: TextStyle(fontSize: 20),),
                                    ),
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(left: 150),
                                  child: Card(
                                      color: renk4,
                                      child: IconButton(onPressed: (){
                                        Navigator.push(context, MaterialPageRoute(builder: ((context) => SepetSayfa())));
                                      }, icon: Icon(Icons.shopping_cart,color: Colors.white,))),
                                ),
                              ],
                            );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
