
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_siparis/data/entity/sepet_yemekler.dart';
import 'package:yemek_siparis/data/repo/yemeklerdao_repository.dart';

class SepetSayfaCubit extends Cubit<List<SepetYemekler>>
{
  SepetSayfaCubit():super(<SepetYemekler>[]);

  var krepo = YemeklerDaoRepository();

  Future<void> sepetYemekleriGoster(String kullanici_adi) async
  {
    var bos_liste =<SepetYemekler>[];
    try
    {
      var liste = await krepo.sepetYemekleriGoster(kullanici_adi);
      emit(liste);
    }
    catch(e)
    {
      var liste = await bos_liste;
      emit(liste);
    }
  }

  Future<void> sil(String sepet_yemek_id,String kullanici_adi) async
  {
    await krepo.sil(sepet_yemek_id, kullanici_adi);
    await sepetYemekleriGoster(kullanici_adi);
  }
}