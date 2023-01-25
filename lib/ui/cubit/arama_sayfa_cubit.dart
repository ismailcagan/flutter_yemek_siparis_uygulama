
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_siparis/data/entity/yemekler.dart';
import 'package:yemek_siparis/data/repo/yemeklerdao_repository.dart';

class AramaSayfaCubit extends Cubit<List<Yemekler>>
{
  AramaSayfaCubit():super(<Yemekler>[]);

  var krepo = YemeklerDaoRepository();

  Future<void> YemekleriGosterAra() async
  {
    var bos_liste =<Yemekler>[];

    try
    {
      var liste = await krepo.tumYemekleriGoster();
      emit(liste);
    }
    catch(e)
    {
      var liste = await bos_liste;
      emit(liste);
    }
  }

}