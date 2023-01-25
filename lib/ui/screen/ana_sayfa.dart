import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:yemek_siparis/assets/renkler/renkler.dart';
import 'package:yemek_siparis/data/entity/yemekler.dart';
import 'package:yemek_siparis/ui/cubit/ana_sayfa_cubit.dart';
import 'package:yemek_siparis/ui/screen/detay_sayfa.dart';
import 'package:yemek_siparis/ui/screen/iletisim.dart';
import 'package:yemek_siparis/ui/screen/sepet_ekle_sayfa.dart';

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({Key? key}) : super(key: key);

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {

  late CarouselSlider carouselSlider;

  @override
  void initState() {
    super.initState();
    context.read<AnaSayfaCubit>().tumYemekleriGoster();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: renk5.withOpacity(0.4),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<AnaSayfaCubit,List<Yemekler>> (
              builder: (context, yemekListesi) {
                if(yemekListesi.isNotEmpty){
                  return Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        carouselSlider=CarouselSlider(
                          options: CarouselOptions(
                            height: 150,
                            initialPage: 0,
                            enlargeCenterPage: true,
                            autoPlay: true,
                            reverse: false,
                            enableInfiniteScroll: true,
                            autoPlayInterval: Duration(seconds: 2),
                            autoPlayAnimationDuration: Duration(
                                milliseconds: 2000
                            ),
                            scrollDirection: Axis.horizontal,
                          ),
                          items:yemekListesi.map((imgAsset){
                            return Builder(
                              builder: (BuilderContext) {
                                return Container(
                                  width: 600,
                                  decoration: BoxDecoration(
                                    color: renk2,
                                   boxShadow: [BoxShadow(color: renk1,offset: Offset(0.1,1),blurRadius: 12)],
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${imgAsset.yemek_resim_adi}"),
                                );
                              },
                            );
                          }
                          ).toList(),

                        ),
                      ],
                    ),
                  );
                }
                else{
                  return Center(child: Text("Böyle bir liste yok",style: TextStyle(fontFamily: "Quicksand"),),);
                }
              },
            ),

            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(right: 260,bottom: 10),
              child: Text("Menü",style: TextStyle(fontSize: 25),),
            ),
            BlocBuilder<AnaSayfaCubit,List<Yemekler>>(
              builder: (context,yemeklerListesi){
                if(yemeklerListesi.isNotEmpty){
                  return Container(
                   // height: 500,
                   // height: 2210,
                    //height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width-50,
                    //color: Colors.red,
                    alignment: Alignment.topCenter,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: yemeklerListesi.length,
                      itemBuilder: (context,indeks){
                        var yemek = yemeklerListesi[indeks];

                        return GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>SepetEkleSayfa(yemeklerr: yemek)));
                            //Navigator.push(context, MaterialPageRoute(builder: (context) =>DetaySayfa(yemekler: yemek)));
                          },
                          child: Card(
                            color: renk1,
                            //color: Colors.white12,
                            //elevation: 100,
                            shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(25)),
                            child: Row(
                              children: [
                                Card(
                                  color:renk1,
                                  //color:Colors.black,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  child: Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${yemek.yemek_resim_adi}",
                                    width: 80,fit: BoxFit.cover,),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 25),
                                  child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("${yemek.yemek_adi}",style: TextStyle(fontSize: 20),),
                                      Text("${yemek.yemek_fiyat} ₺",style: TextStyle(fontSize: 25,color: Colors.black),)
                                    ],
                                  ),
                                ),
                                Spacer(),
                                IconButton(onPressed: (){}, icon: Icon(Icons.chevron_right)),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
                else {return Center(child: Text("Yemek yok"),);}
              },
            ),
          ],
        ),
      ),
    );
  }
}
