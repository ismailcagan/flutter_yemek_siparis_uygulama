class Yemekler
{
  String yemek_id;
  String yemek_adi;
  String yemek_resim_adi;
  String yemek_fiyat;
 // String yemek_kategori;

  Yemekler({
    required this.yemek_id,
    required this.yemek_adi,
    required this.yemek_resim_adi,
    required this.yemek_fiyat,
   // required this.yemek_kategori
  });

  factory Yemekler.fromJson(Map<String,dynamic> json)
  {
    return Yemekler(
        yemek_id: json["yemek_id"] as String,
        yemek_adi: json["yemek_adi"] as String,
        yemek_resim_adi: json["yemek_resim_adi"] as String,
        yemek_fiyat: json["yemek_fiyat"] as String,
       // yemek_kategori: json["yemek_kategori"] as String,
    );
  }

}