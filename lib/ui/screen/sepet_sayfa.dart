import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_siparis/assets/renkler/renkler.dart';
import 'package:yemek_siparis/data/entity/sepet_yemekler.dart';
import 'package:yemek_siparis/ui/cubit/detay_sayfa_cubit.dart';
import 'package:yemek_siparis/ui/cubit/sepet_sayfa_cubit.dart';

class SepetSayfa extends StatefulWidget {

  @override
  State<SepetSayfa> createState() => _SepetSayfaState();
}

class _SepetSayfaState extends State<SepetSayfa> {

  @override
  void initState() {
    super.initState();
    context.read<SepetSayfaCubit>().sepetYemekleriGoster("ismailcagan95@gmail.com");// Uygulama açıldığında verileri getirecek
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: renk5,
      body: BlocBuilder<SepetSayfaCubit,List<SepetYemekler>>(
        builder: (context,sepetListesi){
          if(sepetListesi.isNotEmpty){
            return ListView.builder(
              itemCount: sepetListesi.length,
              itemBuilder: (context,indeks){
                var sepet = sepetListesi[indeks];
                return GestureDetector(
                  onTap: (){
                   // context.read<SepetSayfaCubit>().sepetYemekleriGoster("ismailcagan95@gmail.com");
                  },
                  child: Card(
                    color: renk2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    child: Row(
                      children: [
                        SizedBox(width: 120,height: 120,
                            child:Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${sepet.yemek_resim_adi}")
                        ),
                        SizedBox(width: 10,),
                        Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("${sepet.yemek_adi}",style: const TextStyle(fontSize: 25, color: Colors.white,),),
                            Text("Toplam Fiyat :${((int.parse(sepet.yemek_fiyat)) * (int.parse(sepet.yemek_siparis_adet))).toString()} ₺",style: const TextStyle(fontSize: 15,color:Colors.white),),
                            Text("Birim Fiyat :${sepet.yemek_fiyat} ₺",style: const TextStyle(fontSize: 15,color:Colors.white),),
                            SizedBox(height:5,),
                          ],
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Column(
                            children: [
                              Text("${sepet.yemek_siparis_adet} adet",style: const TextStyle(fontSize: 20,color:Colors.white),),
                              InkWell(
                                onTap: ()
                                {
                                  setState(() {
                                    if(int.parse(sepet.yemek_siparis_adet) > 1)
                                    {
                                      sepet.yemek_siparis_adet = (int.parse(sepet.yemek_siparis_adet) - 1).toString();
                                      context.read<SepetKayitCubit>().kaydet(
                                          sepet.yemek_adi,
                                          sepet.yemek_resim_adi,
                                          sepet.yemek_fiyat,
                                          sepet.yemek_siparis_adet,
                                          sepet.kullanici_adi);

                                      context.read<SepetSayfaCubit>().sil(sepet.sepet_yemek_id,"ismailcagan95@gmail.com");
                                    }
                                    else
                                    {
                                      context.read<SepetSayfaCubit>().sil(sepet.sepet_yemek_id,"ismailcagan95@gmail.com");
                                    }
                                  });
                                },
                                child: Container(
                                  height: 40,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(child: Text("Adet Sil",style: TextStyle(color: Colors.white),)),
                                ),
                              ),

                              InkWell(
                                onTap: ()
                                {
                                  context.read<SepetSayfaCubit>().sil(sepet.sepet_yemek_id,"ismailcagan95@gmail.com");
                                },
                                child: Container(
                                  height: 40,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(child: Text("Tümünü Sil",style: TextStyle(color: Colors.white),)),
                                ),
                              ),
                              /*
                              ElevatedButton(
                                  style: OutlinedButton.styleFrom(backgroundColor: Colors.black,),
                                  onPressed: (){

                                  }, child: Text("Tümünü Sil")),
                              */
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );//listeleme yapacak
          }
          //else if(sepetListesi.isEmpty){Text("hata oluştu");}
          else{
            return Center(
                child: Text("Sepette Yemek Yok"));
          }
        },
      ),
















      /*
      body: BlocBuilder<SepetSayfaCubit,List<SepetYemekler>>(
        builder: (context,sepetListesi){
          if(sepetListesi.isNotEmpty){
            return ListView.builder(
              itemCount: sepetListesi.length,
              itemBuilder: (context,indeks){
                var sepet = sepetListesi[indeks];
                return GestureDetector(
                  onTap: (){
                    context.read<SepetSayfaCubit>().sepetYemekleriGoster("ismailcagan95@gmail.com");
                  },
                  child: Card(
                    color: arkaPlanColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    child: Row(
                      children: [
                        SizedBox(width: 150,height: 150,
                            child:Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${sepet.yemek_resim_adi}")
                        ),
                        Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("${sepet.yemek_adi}",style: const TextStyle(fontSize: 25, color: Colors.white,),),
                            Text("Toplam Fiyat :${((int.parse(sepet.yemek_fiyat)) * (int.parse(sepet.yemek_siparis_adet))).toString()} ₺",style: const TextStyle(fontSize: 15,color:Colors.white),),
                            Text("Birim Fiyat :${sepet.yemek_fiyat} ₺",style: const TextStyle(fontSize: 15,color:Colors.white),),
                            SizedBox(height:5,),
                          ],
                        ),
                          Spacer(),
                          Column(
                            children: [
                              Text("${sepet.yemek_siparis_adet} adet",style: const TextStyle(fontSize: 20,color:Colors.white),),
                              ElevatedButton(
                                style: OutlinedButton.styleFrom(backgroundColor: Colors.red),
                                  onPressed: (){
                                    setState(() {
                                      if(int.parse(sepet.yemek_siparis_adet) > 1)
                                        {
                                          sepet.yemek_siparis_adet = (int.parse(sepet.yemek_siparis_adet) - 1).toString();
                                          context.read<SepetKayitCubit>().kaydet(
                                              sepet.yemek_adi,
                                              sepet.yemek_resim_adi,
                                              sepet.yemek_fiyat,
                                              sepet.yemek_siparis_adet,
                                              sepet.kullanici_adi);

                                          context.read<SepetSayfaCubit>().sil(sepet.sepet_yemek_id,"ismailcagan95@gmail.com");
                                        }
                                      else
                                      {
                                        context.read<SepetSayfaCubit>().sil(sepet.sepet_yemek_id,"ismailcagan95@gmail.com");
                                      }
                                    });
                                  },
                                  child:const Text("Adet Sil",)),

                              ElevatedButton(
                                  style: OutlinedButton.styleFrom(backgroundColor: Colors.black),
                                  onPressed: (){
                                context.read<SepetSayfaCubit>().sil(sepet.sepet_yemek_id,"ismailcagan95@gmail.com");
                              }, child: Text("Tamamen Sil")),
                            ],
                          ),
                      ],
                    ),
                  ),
                );
              },
            );//listeleme yapacak
          }
          //else if(sepetListesi.isEmpty){Text("hata oluştu");}
          else{
            return Center(
                child: Text("Sepette Yemek Yok"));
          }
        },
      ),
*/
    );
  }
}
