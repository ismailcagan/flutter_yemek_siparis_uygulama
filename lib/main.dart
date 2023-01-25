import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_siparis/ui/cubit/ana_sayfa_cubit.dart';
import 'package:yemek_siparis/ui/cubit/arama_sayfa_cubit.dart';
import 'package:yemek_siparis/ui/cubit/detay_sayfa_cubit.dart';
import 'package:yemek_siparis/ui/cubit/sepet_sayfa_cubit.dart';
import 'package:yemek_siparis/ui/screen/ana_sayfa.dart';
import 'package:yemek_siparis/ui/screen/tabs_kontrol.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AnaSayfaCubit()),
        BlocProvider(create: (context) => SepetKayitCubit()),
        BlocProvider(create: (context) => SepetSayfaCubit()),
        BlocProvider(create: (context) => AramaSayfaCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const TabsKontrol(),
      ),
    );
  }
}
