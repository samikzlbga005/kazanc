import 'package:flutter/material.dart';
import 'dart:math';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kazanc/AppBarr.dart';
import 'kullanici_sayfa.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget{
  bool durum = false;

  Login(this.durum);
  @override
  State<StatefulWidget> createState() =>_Login();

}

class _Login extends State<Login>{

  CollectionReference refgiris = FirebaseFirestore.instance.collection('kullaniciGiris');
  final Stream<QuerySnapshot> _userStream = FirebaseFirestore.instance.collection('kullaniciGiris').snapshots();


  @override
  void initState(){
    super.initState();
    if(widget.durum == false){
      girisKullaniciAdiController.text = "";
      girisSifreController.text = "";
    }
    else{
      getir();
    }
  }

  final kullaniciAdicontroller = TextEditingController();
  final sifrecontroller = TextEditingController();

  final girisKullaniciAdiController = TextEditingController();
  final girisSifreController = TextEditingController();


  int kullaniciNo = 0;
  late String kullaniciAdi = "";
  late String sifre = "";

  bool kullaniciNoDogrula = true;
  bool varMi = true;

  bool isChecked = false;

  void getir()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    girisKullaniciAdiController.text = prefs.getString("k_adi").toString();
    girisSifreController.text = prefs.getString("sifre").toString();
    isChecked = prefs.getBool("check")!;
    if(isChecked == true){
      GirisYap();
    }
  }
  
  void kullaniciNoEkle()async{
    QuerySnapshot querySnapshot = await refgiris.get();
    int random = Random().nextInt(999999);
    kullaniciNo = random;
    for(int i = 0; i< querySnapshot.size;i++){
      if(kullaniciNo == querySnapshot.docChanges[i].doc["Kullanıcı No"]){
        kullaniciNoDogrula = false;
        break;
      }
    }
    if(kullaniciNoDogrula){
      Kaydet(kullaniciNo);
    }
    else{
      kullaniciNo = random;
      kullaniciNoDogrula = true;
      Kaydet(kullaniciNo);
    }
  }

  void Kaydet(int kullaniciNo){
    setState(() {
      kullaniciAdi = kullaniciAdicontroller.text;
      sifre = sifrecontroller.text;
      kullaniciAdicontroller.clear();
      sifrecontroller.clear();

      refgiris.add({
        "Kullanıcı No": kullaniciNo,
        "kullaniciAdi": kullaniciAdi,
        "sifre": sifre,
      });
    });
  }
  
  void GirisYap()async{
    QuerySnapshot querySnapshot = await refgiris.get();
    for(int i = 0; i<querySnapshot.size;i++){
      if((girisKullaniciAdiController.text == querySnapshot.docChanges[i].doc["kullaniciAdi"])&
        (girisSifreController.text == querySnapshot.docChanges[i].doc["sifre"])){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) {
            return AppBarr(querySnapshot.docChanges[i].doc['Kullanıcı No'],
            querySnapshot.docChanges[i].doc['kullaniciAdi'], 
            querySnapshot.docChanges[i].doc['sifre']);
          }));
          varMi = false;
       }
    }
    if(varMi){
      Fluttertoast.showToast(msg: "Kullanıcı Adı veya Şifre Hatalı");
    }
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text("HOŞGELDİNİZ"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  padding: EdgeInsets.all(15.0),
                  alignment: Alignment.center,
                    child: TextField(
                    controller: girisKullaniciAdiController,
                    decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Kullanıcı Adı',
                  ),
                ),
              ),
              Container(
                  padding: EdgeInsets.all(15.0),
                  alignment: Alignment.center,
                  child: TextField(
                    controller: girisSifreController,
                    obscureText: true,
                    decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Şifre',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top:35),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green ,
                    onPrimary: Colors.white,
                    shadowColor: Colors.greenAccent,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0)),
                    minimumSize: Size(160, 50), 
                  ),
                  onPressed: () {
                    GirisYap();
                  },
                  child: Text('Giriş Yap',style: TextStyle(fontSize: 18.0),),
                )
              ),
              Container(
                padding: EdgeInsets.all(15.0),
                child: TextButton(
                  child: Text("Kayıt Ol", style: TextStyle(fontSize: 17.0,color: Colors.green),),
                  onPressed: (){
                    showDialog(
                      context: context,
                      builder: (context) {
                      return SingleChildScrollView(
                        child: AlertDialog(
                          title: Text('Kayıt Ol'),
                          content: Container(
                            height: 100,
                            child: Column(
                              children: <Widget>[
                                TextField(
                                  controller: kullaniciAdicontroller,
                                  decoration: InputDecoration(
                                  hintText: 'Kullanıcı Adı',
                                  ),
                                ),
                                TextField(
                                  controller: sifrecontroller,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                  hintText: 'Şifre (En az 8 karakter)',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                    primary: Colors.green,
                                    onPrimary: Colors.white,
                                    shadowColor: Colors.greenAccent,
                                    elevation: 3,
                                    shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32.0)),
                                    minimumSize: Size(100, 40), 
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      if((kullaniciAdicontroller.text == "") | (sifrecontroller.text == "")){
                                        Fluttertoast.showToast(msg: "Lütfen Tüm Alanları Doldurunuz!");
                                      }
                                      else if(sifrecontroller.text.length < 8){
                                        Fluttertoast.showToast(msg: "Şifreniz en az 8 karakter olmalıdır!",);
                                      }
                                      else {
                                        kullaniciNoEkle();
                                        Fluttertoast.showToast(msg: "Kayıt Başarılı");
                                        Navigator.pop(context);
                                      }
                                    });
                                  },
                                  child: Text('Kayıt Ol'),
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                    primary: Colors.green,
                                    onPrimary: Colors.white,
                                    shadowColor: Colors.greenAccent,
                                    elevation: 3,
                                    shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32.0)),
                                    minimumSize: Size(100, 40), 
                                  ),
                                  onPressed: () {
                                    kullaniciAdicontroller.text = "";
                                    sifrecontroller.text = "";
                                    Navigator.pop(context);
                                  },
                                  child: Text('Kapat'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    });
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    value: isChecked,
                    onChanged: (bool? value) async{
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      setState(() {
                        isChecked = value!;
                        prefs.setString("k_adi",girisKullaniciAdiController.text);
                        prefs.setString("sifre", girisSifreController.text);
                        prefs.setBool("check", isChecked);
                      });
                    },
                  ),
                  Text("Beni Hatırla", style: TextStyle(fontSize: 17.0),),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}