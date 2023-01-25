
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_siparis/data/entity/yemekler.dart';
import 'package:yemek_siparis/data/repo/yemeklerdao_repository.dart';

class AnaSayfaCubit extends Cubit<List<Yemekler>>
{
  AnaSayfaCubit():super(<Yemekler>[]);

  var krepo = YemeklerDaoRepository();

  Future<void> tumYemekleriGoster() async
  {
    var liste = await krepo.tumYemekleriGoster();
    emit(liste);
  }

}