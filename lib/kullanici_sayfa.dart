import 'package:flutter/material.dart';
import 'package:kazanc/giris_cikis.dart';
import 'package:kazanc/kazanclarim.dart';
import 'login.dart';
import 'islerim.dart';
import 'AppBarr.dart';


class kullanici_sayfa extends StatefulWidget{
  final int kullanici_no;
  final String kullanici_adi;
  final String sifre;
  kullanici_sayfa(this.kullanici_no,this.kullanici_adi,this.sifre);
  @override
  State<StatefulWidget> createState() => _kullanici_sayfa();
}

class _kullanici_sayfa extends State<kullanici_sayfa>{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text("ANASAYFA"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(5,0,5,0),
                height: 100,
                width: double.maxFinite,
                child: Card(
                  color: Color.fromARGB(255, 187, 255, 190),
                  elevation: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text("Kullanıcı No: " + widget.kullanici_no.toString(),style: TextStyle(fontSize: 17.0),),
                      Text("Ad Soyad: " + widget.kullanici_adi,style: TextStyle(fontSize: 17.0),),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(15.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    onPrimary: Colors.white,
                    shadowColor: Colors.greenAccent,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0)),
                    minimumSize: Size(120, 50), 
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) {
                      return Login(false);
                    }));
                  },
                  child: Text('Çıkış Yap',style: TextStyle(fontSize: 18.0),),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}