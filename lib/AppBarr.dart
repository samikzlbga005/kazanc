import 'package:flutter/material.dart';
import 'package:kazanc/giris_cikis.dart';
import 'package:kazanc/gunluk.dart';
import 'package:kazanc/login.dart';
import 'package:kazanc/islerim.dart';
import 'package:kazanc/kazanclarim.dart';
import 'package:kazanc/kullanici_sayfa.dart';

class AppBarr extends StatefulWidget{
  late int kullanici_no;
  late String kullanici_adi;
  late String sifre;
  AppBarr(this.kullanici_no,this.kullanici_adi,this.sifre);
  @override
  State<StatefulWidget> createState() => _AppBarr();
}

class _AppBarr extends State<AppBarr> {
  int _selectedIndex = 0;
  
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  int asd = 0;
  late List <Widget> screens= [
    kullanici_sayfa(widget.kullanici_no,widget.kullanici_adi,widget.sifre),
    kazanclarim(widget.kullanici_no),
    giris_cikis(widget.kullanici_no),
    islerim(widget.kullanici_no),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Anasayfa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on),
            label: 'Kazançlarım',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.play_arrow),
            label: 'İş Başlat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'İşlerim',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.black,
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
      ),
    );
  }
}