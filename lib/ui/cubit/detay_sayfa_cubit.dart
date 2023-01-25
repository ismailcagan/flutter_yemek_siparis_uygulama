
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_siparis/data/repo/yemeklerdao_repository.dart';

class SepetKayitCubit extends Cubit<void>
{
  SepetKayitCubit():super(0);

  var krepo = YemeklerDaoRepository();

  Future<void> kaydet(String yemek_adi,String yemek_resim_adi,String yemek_fiyat, String yemek_siparis_adet,String kullanici_adi) async
  {
    await krepo.kaydet(yemek_adi, yemek_resim_adi, yemek_fiyat, yemek_siparis_adet, kullanici_adi);
  }



}