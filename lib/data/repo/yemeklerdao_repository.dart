import 'package:yemek_siparis/data/entity/sepet_yemekler.dart';
import 'package:yemek_siparis/data/entity/sepet_yemekler_cevap.dart';
import 'package:yemek_siparis/data/entity/yemekler.dart';
import 'package:yemek_siparis/data/entity/yemekler_cevap.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class YemeklerDaoRepository
{
  List<Yemekler> parseYemeklerCevap(String cevap)
  {
    return YemeklerCevap.fromJson(json.decode(cevap)).yemekler;
  }

  List<SepetYemekler> parseSepetlerCevap(String sepetCevap)
  {
    return SepetCevap.fromJson(json.decode(sepetCevap)).sepet_yemekler;
  }

  // SEPETTEKİ VERİLERİ LİSTELEME
  Future<List<SepetYemekler>> sepetYemekleriGoster(String kullanici_adi) async
  {

    var url = Uri.parse("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php");
    var veri ={"kullanici_adi":kullanici_adi};
    var cevap = await http.post(url,body: veri);
    return parseSepetlerCevap(cevap.body);
  }

  Future<void> sil(String sepet_yemek_id,String kullanici_adi ) async
  {
    var url = Uri.parse("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php");
    var veri = {"sepet_yemek_id":sepet_yemek_id.toString(),"kullanici_adi":kullanici_adi};
    var cevap = await http.post(url,body: veri);
    print("sepet yemek silindi :${cevap.body}");
  }

  // YEMEK LİSTELEME
  Future<List<Yemekler>> tumYemekleriGoster() async
  {
    var url = Uri.parse("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php");
    var cevap = await http.get(url);
    return parseYemeklerCevap(cevap.body);
  }


  // SEPETE VERİ EKLEME
  Future<void> kaydet(String yemek_adi,String yemek_resim_adi,String yemek_fiyat,String yemek_siparis_adet,String kullanici_adi) async
  {
    var url = Uri.parse("http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php");
    var veri ={"yemek_adi":yemek_adi,"yemek_resim_adi":yemek_resim_adi,"yemek_fiyat":yemek_fiyat,"yemek_siparis_adet":yemek_siparis_adet,"kullanici_adi":kullanici_adi};
    var cevap = await http.post(url,body: veri);
    print("sepet kayıt :${cevap.body}");
  }

}
