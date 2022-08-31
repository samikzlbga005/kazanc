/*
import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
class islerim extends StatefulWidget{
  late int kullanici_no;
  islerim(this.kullanici_no);
  @override
  State<StatefulWidget> createState() => _islerim();
}

class _islerim extends State<islerim> {
  

  late List<int>list = [];
  @override
  void initState() {
    super.initState();
    
    ref.where("islerim",isEqualTo: {widget.kullanici_no:null}).limit(1).get().then(
      (QuerySnapshot querySnapshot){
        for(int i = 0; i< querySnapshot.size;i++){
          if(querySnapshot.docs.isEmpty){
            return "İş Bulunamadı";
          }
          else{
            if(widget.kullanici_no == querySnapshot.docChanges[i].doc["Kullanıcı No"]){
              list.add(querySnapshot.docChanges[i].doc["isNo"]);
            }
          }
        }
      }
    );
  }

  final isAdiController = TextEditingController();
  final UcretController = TextEditingController();

  late String isAdi = "";
  late var ucret = "";


  CollectionReference ref = FirebaseFirestore.instance.collection('islerim');
  final Stream<QuerySnapshot> _userStream = FirebaseFirestore.instance.collection('islerim').snapshots();

  bool isNodogrula = true;
  int isNo = 0;
  
  
  void isNoHesapla()async{
    QuerySnapshot querySnapshot = await ref.get();
    int random = Random().nextInt(99);
    List<int>list = [];
    isNo = random;
    for(int i = 0; i< querySnapshot.size;i++){
      isNodogrula = false;
      break;
    }
    if(isNodogrula){
      isEkle(isNo);
    }
    else{
      isNo = random;
      isNodogrula = true;
      isEkle(isNo);
    }
  }

  void isEkle(int isNo){
    setState(() {
    isAdi = isAdiController.text;
    ucret = UcretController.text;
    isAdiController.clear();
    UcretController.clear();

    ref.add({
        "Kullanıcı No": widget.kullanici_no,
        "isNo": isNo,
        "IsAdi": isAdi,
        "Ucret": ucret,
      });
    });
  }
  
  listele()async{
    /*
    return await FirebaseFirestore.instance
    .collection("Doctor")
    .where("name", isEqualTo: widget.kullanici_no)
    .get();*/
    
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text("İşlerim"),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: ref.get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.docs.length == 0) {
              return Center(
                child: Text(
                  "Henüz bir iş eklemediniz",
                  style: TextStyle(
                    color: Colors.white70,
                  ),
                ),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
               
                return InkWell(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("İş No: "),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text("Loading..."),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: (){
          showDialog(
                    context: context,
                    builder: (context) {
                    return SingleChildScrollView(
                      child: AlertDialog(
                        title: Text('İş Ekleme Formu'),
                        content: Container(
                          height: 100,
                          child: Column(
                            children: <Widget>[
                              TextField(
                                controller: isAdiController,
                                decoration: InputDecoration(
                                hintText: 'İş Adı',
                                ),
                              ),
                              TextField(
                                controller: UcretController,
                                decoration: InputDecoration(
                                hintText: 'Saatlik Ücret',
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
                                    if((isAdiController.text == "") | (isAdiController.text == "")){
                                      Fluttertoast.showToast(msg: "Lütfen Tüm Alanları Doldurunuz!");
                                    }
                                    else {
                                      isNoHesapla();
                                      Fluttertoast.showToast(msg: "Kayıt Başarılı");
                                      Navigator.pop(context);
                                    }
                                  });
                                },
                                child: Text('Kaydet'),
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
                                  isAdiController.text = "";
                                  UcretController.text = "";
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
        tooltip: 'Increment',
        child: const Icon(Icons.add),
        ),
    );
  }
}*/



import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class giris_cikis extends StatefulWidget{
  late int kullanici_no;
  giris_cikis(this.kullanici_no);
  @override
  State<StatefulWidget> createState() => _giris_cikis();
}

class _giris_cikis extends State<giris_cikis> {
  CollectionReference ref = FirebaseFirestore.instance.collection('islerim');
  CollectionReference refgririsCikis = FirebaseFirestore.instance.collection('girisCikis');
  late String _selectedItem;
  List<String> card = [];
  double money = 0;
  String yazdir = "0";
  int Noo = 0;
  //int ucretKazandi = 0;
  late DateTime newStartDate;
  late AsyncSnapshot<QuerySnapshot> snapshot2;


  void baslat(int isNoGelen, String ucretKazandi){
    setState(() {
      String start = DateFormat("hh:mm").format(DateTime.now());
      DateTime startDate = DateFormat("hh:mm").parse(start);
      newStartDate = startDate;
      String girisTarih = DateFormat('dd/MM/yyyy').format(DateTime.now());

      refgririsCikis.add({
        "Kullanıcı No": widget.kullanici_no,
        "İş No": isNoGelen,
        "İş Adı": _selectedItem,
        "Giriş Tarihi": girisTarih,
        "Giriş Saati": start,
        "Çıkış Tarihi": "",
        "Çıkış Saati": "",
        "Kazanılan Ücret": ucretKazandi,
      });
    });
  }

  
  void bitir(String id){
    String end = DateFormat("hh:mm").format(DateTime.now());
    DateTime endDate = DateFormat("hh:mm").parse(end);
    String cikisTarih = DateFormat('dd/MM/yyyy').format(DateTime.now());
    int dif = endDate.difference(newStartDate).inMinutes.remainder(60).abs();
    int dif2 = endDate.difference(newStartDate).inHours.toInt().abs();
    debugPrint("${dif2}" + "." + "${dif}");
    money = dif2.toDouble() * 13;
    money = (money + ((13 * dif.toDouble())/60));
    yazdir = money.toStringAsFixed(2);
    card.add(yazdir);

    FirebaseFirestore.instance.collection('GirisCikis').doc(id.toString()).update({
      "Çıkış Tarihi": cikisTarih,
      "Çıkış Saati": end,
      "Kazanılan Ücret": yazdir,
    });
  }

  @override
   void initState() {
    super.initState();
    _selectedItem = "İş seçin";
  }
  @override
  Widget build(BuildContext context) {
    
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection('islerim')
        .where(
          'Kullanıcı No',
          isEqualTo: widget.kullanici_no,
        ).snapshots();

    final Stream<QuerySnapshot> _userStreamGiris = FirebaseFirestore.instance
        .collection('girisCikis')
        .where(
          'Kullanıcı No',
          isEqualTo: widget.kullanici_no,
        ).snapshots();
        
    List<String> list = [];
    List<int> listIsNo = [];
    List<String> listid =[];


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text("İş Başlat"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Kazanılan Para
            Container(
              padding: EdgeInsets.all(20),
              alignment: Alignment.center,
              child: Text(r"$" + "${yazdir}", style: TextStyle(fontSize: 30.0,color: Color.fromARGB(255, 201, 0, 0),fontStyle: FontStyle.italic),),
            ),
            
            //Dropdown list
            Container(
              height: 50,
              padding: EdgeInsets.only(left: 16.0,right: 16.0,),
              decoration: BoxDecoration(border: Border.all(color: Colors.black)),
              child: StreamBuilder(
                stream: _usersStream,
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text("something is wrong");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Container(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (_, index) {
                          list = ["İş seçin"];
                          for(int i = 0; i<snapshot.data!.docs.length;i++){
                            list.add(snapshot.data!.docChanges[i].doc["IsAdi"]);
                            listIsNo.add(snapshot.data!.docChanges[i].doc["isNo"]);
                          }
                          snapshot2 = snapshot;
                          debugPrint(list[0]);
                          debugPrint(_selectedItem);
                          return SizedBox(
                            child: DropdownButton(
                              value: _selectedItem,
                              icon: const Icon(Icons.arrow_drop_down),
                              iconSize: 25,
                              elevation: 5,
                              hint: Text("İş seçin", style: TextStyle(fontSize: 25.0,color: Color.fromARGB(255, 255, 0, 0)),),
                              style: const TextStyle(color: Colors.black,fontSize: 20.0),
                              items: list.map((value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (value) {
                                _selectedItem = value.toString();
                               
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),

            //Start Buton
            Container(
              padding: EdgeInsets.all(20.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  onPrimary: Colors.white,
                  shadowColor: Colors.greenAccent,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0)),
                  minimumSize: Size(160, 50), 
                ),
                onPressed: (){
                  baslat(listIsNo[0],yazdir);
                  Fluttertoast.showToast(msg: "$_selectedItem" + "Adlı işe başladınız");
                },
                child: Text('İşi Başlat',style: TextStyle(fontSize: 18.0),),
              ),
            ),
            
            //Stop Buton
            Container(
              padding: EdgeInsets.only(bottom: 15),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  onPrimary: Colors.white,
                  shadowColor: Colors.greenAccent,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0)),
                  minimumSize: Size(160, 50), 
                ),
                onPressed: () {
                  setState(() {
                    if((_selectedItem == null) |( _selectedItem == "İş seçin")){
                      Fluttertoast.showToast(msg: "Lütfen İş Seçiniz");
                    }
                    else{
                      card.add(_selectedItem.toString());
                      bitir(listid[0].toString());
                    }
                  });
                },
                child: Text('İşi Bitir',style: TextStyle(fontSize: 18.0),),
              ),
            ),
            /*
            //Sonuç listele
            Expanded(
              child: StreamBuilder(
                stream: _userStreamGiris,
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                  if (snapshot.hasError) {
                    return Text("something is wrong");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Container(
                    padding: EdgeInsets.fromLTRB(10,0,10,0),
                    height: 100,
                    width: double.maxFinite,
                    child: Card(
                      color: Color.fromARGB(255, 187, 255, 190),
                      elevation: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text("İş Adı: " + isAdii, style: TextStyle(fontSize: 17.0),),
                          //Text("Ücret: " + snapshot.data!.docChanges[index].doc['Kazanılan Ücret'].toString(), style: TextStyle(fontSize: 17.0),),
                        ],
                      ),
                    )
                  );
                },
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}



/*

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:kazanc/bilgiGetir.dart';
import 'package:shared_preferences/shared_preferences.dart';


class giris_cikis extends StatefulWidget{
  late int kullanici_no;
  giris_cikis(this.kullanici_no);
  @override
  State<StatefulWidget> createState() => _giris_cikis();
}

class _giris_cikis extends State<giris_cikis> {

  late SharedPreferences sharedPreferences;
  @override
  void initState(){
    super.initState();
    initGetSavedData();

  }

  

  
  CollectionReference ref = FirebaseFirestore.instance.collection('islerim');
  CollectionReference refgririsCikis = FirebaseFirestore.instance.collection('girisCikis');

  
  List<String> isListele = ["İş Seçin"];
  late String _selectedItem = "İş Seçin";
  List<String> isAdi = ["1"];
  List<String> isNo = ["1"];
  List<String> isUcret = ["1"];
  List<String> id = ["1"];
  List<bool> durum = [false];
  List<String>genel = [];

  

  void isBilgileri(AsyncSnapshot<QuerySnapshot> snapshot){
    isListele.clear();
    isListele.add("İş Seçin");
    isNo.clear();
    isNo.add("1");
    isUcret.clear();
    isUcret.add("1");
    
    for(int i = 0; i< snapshot.data!.docs.length; i++) {
      isListele.add(snapshot.data!.docChanges[i].doc["IsAdi"]);
      isNo.add(snapshot.data!.docChanges[i].doc["isNo"].toString());
      isUcret.add(snapshot.data!.docChanges[i].doc["Ucret"]);
    }
  }

  void idGetir(AsyncSnapshot<QuerySnapshot> snapshot2){
    id.clear();
    id.add("1");
    durum.clear();
    durum.add(false);
    for(int i = 0; i < snapshot2.data!.docs.length;i++){
      id.add(snapshot2.data!.docs[i].id.toString());
      durum.add(snapshot2.data!.docChanges[i].doc["butonDurum"]);
    }
    print(durum);
  }
*/
  
  /*
  DateTime newStartDate = DateFormat("hh:mm").parse("10:00");

  late String girisTarih2 = DateFormat('dd/MM/yyyy').format(DateTime.now());
  late String start2 = DateFormat("hh:mm").format(DateTime.now());

  void baslat(String isNoGelen, String ucretKazandi,bool butonDurumm){
    setState(() {
      String start = DateFormat("hh:mm").format(DateTime.now());
      DateTime startDate = DateFormat("hh:mm").parse(start);
      String girisTarih = DateFormat('dd/MM/yyyy').format(DateTime.now());
      
    });
  }



  
  void bitir(String id,bool butonDurumm){
    String end = DateFormat("hh:mm").format(DateTime.now());
    String cikisTarih = DateFormat('dd/MM/yyyy').format(DateTime.now());
    DateTime endDate = DateFormat("hh:mm").parse(end);
    int dif = endDate.difference(newStartDate).inMinutes.remainder(60).abs();
    int dif2 = endDate.difference(newStartDate).inHours.toInt().abs();
    debugPrint("${dif2}" + "." + "${dif}");
    money = dif2.toDouble() * int.parse(girisCikisUcret);
    money = (money + ((int.parse(girisCikisUcret) * dif.toDouble())/60));
    yazdir = money.toStringAsFixed(2);
    
  }*/
  /*
  void storeData(){
    info bilgiler = info(
    widget.kullanici_no.toString(), 
    isNoGelen, 
    _selectedItem, 
    girisTarih2, 
    start2, 
    "", 
    "", 
    yazdir, 
    butonDurum.toString());
    String data = jsonEncode(bilgiler);
    sharedPreferences.setString("data", data);
  }
  
  void initGetSavedData()async{
    sharedPreferences = await SharedPreferences.getInstance();

    Map<String,dynamic> jsondatais = jsonDecode(sharedPreferences.getString('data')!);
    info getData = info.fromJson(jsondatais);

    textGoster = getData.exitDate;
  }

  @override
  Widget build(BuildContext context) {

    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('islerim')
          .where(
          'Kullanıcı No',
          isEqualTo: widget.kullanici_no,
        ).snapshots();

    final Stream<QuerySnapshot> _userStreamGiris = FirebaseFirestore.instance.collection('girisCikis')
        .where(
          'Kullanıcı No',
          isEqualTo: widget.kullanici_no,
        ).snapshots();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text("İş Başlat"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Günlük Kazanç Miktarı
            Container(
              padding: EdgeInsets.all(15),
              alignment: Alignment.center,
              child: Text(r"$" + "$textGoster", style: TextStyle(fontSize: 30.0, color: Colors.red)),
            ),

            Container(
              padding: EdgeInsets.all(10),
              child: StreamBuilder(
                stream: _usersStream,
                builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
                  
                  if (snapshot.hasError) {
                    return Text("something is wrong");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  isBilgileri(snapshot);
                  if (butonDurum == false) {
                    return Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("İş Durumu: ",style: TextStyle(fontSize: 17),),
                          Icon(Icons.close, color: Colors.red,),
                        ],
                      ),
                    );
                  }
                  
                  return Center(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("İş Durumu: ",style: TextStyle(fontSize: 17),),
                          Icon(Icons.check_sharp, color: Colors.green,),
                        ],
                      ),
                  );
                },
              ),
            ),

            Container(
              height: 50,
              padding: EdgeInsets.only(left: 16.0,right: 16.0,),
              decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                child: StreamBuilder(
                stream: _userStreamGiris,
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot2){
                  if(snapshot2.hasError){
                    return Text("something is wrong");
                  }
                  if(snapshot2.connectionState == ConnectionState.waiting){
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  idGetir(snapshot2);
                  _snapshot2 = snapshot2;
                  return DropdownButton(
                    value: _selectedItem,
                    icon: const Icon(Icons.arrow_drop_down),
                    iconSize: 25,
                    hint: Text("İş seçin", style: TextStyle(fontSize: 25.0,color: Color.fromARGB(255, 255, 0, 0)),),
                    style: TextStyle(color: Colors.black,fontSize: 20.0),
                    items: isListele.map((value){
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (deger){
                      setState(() {
                        _selectedItem = deger.toString();
                        for(int i = 0; i < isListele.length;i++){
                          if(_selectedItem == isListele[i]){
                            isNoGelen = isNo[i];
                            girisCikisUcret = isUcret[i];
                            GirisCikisid = id[i].toString();
                            butonDurum = durum[i];
                          }
                        }
                        print(GirisCikisid);
                      });
                    },
                  );
                },
              ),
            ),

            //Start Buton
            Container(
              padding: EdgeInsets.all(20.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  onPrimary: Colors.white,
                  shadowColor: Colors.greenAccent,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0)),
                  minimumSize: Size(160, 50), 
                ),
                
                onPressed: (){
                  setState(() {
                    textGoster = "0";
                    if((_selectedItem == "İş Seçin") | (isAdi == isListele[0])){
                      Fluttertoast.showToast(msg: "Lütfen İş Seçin(başlat buton uyarısı)");
                    }
                    else{
                      if((butonDurum == true)){
                        Fluttertoast.showToast(msg: "zaten bir iştesiniz.");
                      }
                      else{
                          butonDurum = true;
                          Fluttertoast.showToast(msg: "$_selectedItem" + " adlı işe başladınız");
                          baslat(isNoGelen, yazdir, butonDurum);
                      }
                    }
                    });
                  },
                  child: Text('İşi Başlat',style: TextStyle(fontSize: 18.0),),
              ),
            ),

            //STOP Buton
            Container(
              padding: EdgeInsets.all(20.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  onPrimary: Colors.white,
                  shadowColor: Colors.greenAccent,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0)),
                  minimumSize: Size(160, 50), 
                ),
                onPressed: (){
                  setState(() {
                    if((_selectedItem == null) | (_selectedItem == "İş seçin")){
                      Fluttertoast.showToast(msg: "Lütfen İş Seçiniz");
                    }
                    else{
                      if((butonDurum == false)){
                        Fluttertoast.showToast(msg: "Lütfen Önce Bir iş başlatın");
                      }
                      else{
                        Fluttertoast.showToast(msg: "$_selectedItem" + " adlı işi bitirdiniz.");
                        butonDurum = false;
                        bitir(GirisCikisid, butonDurum);
                        _selectedItem = isListele[0];
                        initGetSavedData();
                      }
                    }
                  });
                },
                child: Text('İşi Bitir',style: TextStyle(fontSize: 18.0),),
              ),
            ),
             /*Container(
              child: StreamBuilder(
                stream: _userStreamGiris,
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                  if((_selectedItem == "İş Seçin") & (butonDurum != false)){
                    return Text("no data");
                  }
                  return Container(
                    padding: EdgeInsets.fromLTRB(10,0,10,0),
                    height: 150,
                    width: double.maxFinite,
                    child: Card(
                      color: Color.fromARGB(255, 187, 255, 190),
                      elevation: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                child: TextButton(
                                child: Text("sil"),
                                onPressed: (){

                                  },
                                ),
                              ),
                            ],
                          ),
                          Text("iş Adı: $_selectedItem"),
                          Text("$yazdir"),
                          Text("Giriş Tarihi: $girisTarih2 - $start2"),
                        ],
                      ),
                    ),
                  );
                }
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}


 */




/*
  import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:kazanc/bilgiGetir.dart';
import 'package:shared_preferences/shared_preferences.dart';


class giris_cikis extends StatefulWidget{
  late int kullanici_no;
  giris_cikis(this.kullanici_no);
  @override
  State<StatefulWidget> createState() => _giris_cikis();
}

class _giris_cikis extends State<giris_cikis> {
  

  CollectionReference ref = FirebaseFirestore.instance.collection('islerim');
  CollectionReference refgririsCikis = FirebaseFirestore.instance.collection('girisCikis');
  CollectionReference refkayit = FirebaseFirestore.instance.collection('isKayit');

  
  List<String> isListele = ["İş Seçin"];
  late String _selectedItem = "İş Seçin";
  List<String> isAdi = [];
  List<String> isNo = [];
  List<String> isUcret = [];
  bool butonDurum = false;
  var is_ucret = "";
  var is_no = "";
  var is_adi = "";
  var kullanici_no = "";
  
  
  late DateTime dt3 = DateTime.now();
  late double sonuc = 0;

  late int saat = 0;
  late int dakika = 0;
  late String sifir= "";



  void getIslerim(AsyncSnapshot<QuerySnapshot>snapshot)async{
    isListele.clear();
    isListele.add("İş Seçin");
    isNo.clear();
    isNo.add("-");
    isUcret.clear();
    isUcret.add("-");
    for(int i = 0;i<snapshot.data!.docs.length;i++){
      isNo.add(snapshot.data!.docChanges[i].doc["isNo"].toString());
      isListele.add(snapshot.data!.docChanges[i].doc["IsAdi"]);
      isUcret.add(snapshot.data!.docChanges[i].doc["Ucret"]);
    }
  }

  
  void getShared()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedItem = prefs.getString("item").toString();
      is_adi = prefs.getString("is_adi").toString();
      is_no = prefs.getString("is_no").toString();
      is_ucret = prefs.getString("is_ucret").toString();
      kullanici_no = prefs.getString("kullanici_no").toString();
      butonDurum = prefs.getBool("butonDurum") ?? false;
      sonuc = prefs.getDouble("sonuc")?? 0;
      sifir = prefs.getString("sifir").toString();

      if(kullanici_no != widget.kullanici_no.toString()){
        kullanici_no = widget.kullanici_no.toString();
        _selectedItem = "İş Seçin";
        is_adi = "";
        is_no = "";
        is_ucret = "";
        butonDurum = false;
        sonuc = 0;
        sifir = "";
      }

      if((is_adi == "İş Seçin") | (is_no == "-") | (is_ucret == "-")){
        is_adi = "";
        is_no = "";
        is_ucret = "";
      }
    });
  }

  void setShared(String _selectedItem)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("item", _selectedItem);
    prefs.setString("kullanici_no", widget.kullanici_no.toString());
    prefs.setString("is_adi", is_adi);
    prefs.setString("is_no", is_no);
    prefs.setString("is_ucret", is_ucret);
    prefs.setBool("butonDurum", butonDurum);
    

  }

  void setSharedBitir()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _selectedItem = isListele[0];
    butonDurum = false;
    prefs.setString("item", _selectedItem);
    prefs.setString("is_adi", is_adi);
    prefs.setString("is_no", is_no);
    prefs.setString("is_ucret", is_ucret);
    prefs.setBool("butonDurum", butonDurum);
    prefs.setDouble("sonuc", sonuc);
    prefs.setString("sifir", sifir);
  }
  
  void veriEsitle(List<String> dizi){
    for(int i = 0; i< dizi.length;i++){
      if(_selectedItem == dizi[i]){  
        is_no = isNo[i];
        is_ucret = isUcret[i];
        is_adi = dizi[i];
        print(is_ucret);
      }
    }
    butonDurum = true;
  }
  
  void IsiBaslat(){
      final String now = DateTime.now().toString();
      DateTime dt1 = DateTime.parse(now);
      dt3 = dt1;
  }
  void IsiBitir(double isUcrett){
      final String now = DateTime.now().toString();
      DateTime dt2 = DateTime.parse(now); 
      double diff = dt2.difference(dt3).inMinutes.remainder(60).toDouble().abs();
      sonuc = isUcrett / 60;
      sonuc = (diff * sonuc);
      sonuc = double.parse(sonuc.toStringAsFixed(2));

      saat =  (diff / 60).toInt();
      dakika = (diff % 60).toInt();
      if(dakika == 60){
        dakika = 0;
        saat++;
      }
      if((dakika < 10) & (dakika != 0)){
        sifir = "0";
      }
      else{
        sifir = "";
      }
      print(saat);
      print(dakika);     

      String giris = "${dt3.day}/" + "${dt3.month}/" + "${dt3.year} " + "${dt3.hour}:" + "${dt3.minute}";
      String cikis = "${dt2.day}/" + "${dt2.month}/" + "${dt2.year} " + "${dt2.hour}:" + "${dt2.minute}";
      refkayit.add({
        "kullanıcı No": widget.kullanici_no,
        "İş no": is_no,
        "iş Adı": is_adi,
        "iş Ücret": is_ucret,
        "giriş tarih": giris,
        "çıkış tarih": cikis,
        "kazanılan Ücret": sonuc,
        "saat": saat,
        "dakika": dakika
      });
      
  }

  @override
  void initState(){
    super.initState();
    getShared();
    
  }

  @override
  Widget build(BuildContext context) {

    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('islerim')
          .where(
          'Kullanıcı No',
          isEqualTo: widget.kullanici_no,
        ).snapshots();

    final Stream<QuerySnapshot> _userStreamGiris = FirebaseFirestore.instance.collection('girisCikis')
        .where(
          'Kullanıcı No',
          isEqualTo: widget.kullanici_no,
        ).snapshots();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text("İş Başlat"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Günlük Kazanç Miktarı
            Container(
              padding: EdgeInsets.all(15),
              alignment: Alignment.center,
              child: Text(r"$" + "${sonuc}", style: TextStyle(fontSize: 30.0, color: Colors.red)),
            ),

            Container(
              padding: EdgeInsets.all(10),
              child: StreamBuilder(
                stream: _usersStream,
                builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
                  
                  if (snapshot.hasError) {
                    return Text("something is wrong");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  getIslerim(snapshot);
                  print(isNo);
                  if (butonDurum == false) {
                    return Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("İş Durumu: ",style: TextStyle(fontSize: 17),),
                          Icon(Icons.close, color: Colors.red,),
                        ],
                      ),
                    );
                  }

                  return Center(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("İş Durumu: ",style: TextStyle(fontSize: 17),),
                          Icon(Icons.check_sharp, color: Colors.green,),
                        ],
                      ),
                  );
                },
              ),
            ),

            Container(
              height: 50,
              padding: EdgeInsets.only(left: 16.0,right: 16.0,),
              decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                child: StreamBuilder(
                stream: _usersStream,
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot2){
                  if(snapshot2.hasError){
                    return Text("something is wrong");
                  }
                  if(snapshot2.connectionState == ConnectionState.waiting){
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  
                  return DropdownButton(
                    value: _selectedItem,
                    icon: const Icon(Icons.arrow_drop_down),
                    iconSize: 25,
                    hint: Text("İş Seçin", style: TextStyle(fontSize: 25.0,color: Color.fromARGB(255, 255, 0, 0)),),
                    style: TextStyle(color: Colors.black,fontSize: 20.0),
                    items: isListele.map((value){
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (deger){
                      setState(() {
                        _selectedItem = deger.toString();
                        sonuc = 0;
                      });
                    },
                  );
                },
              ),
            ),

            //Start Buton
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
                  minimumSize: Size(160, 50), 
                ),
                
                onPressed: (){
                  setState(() {
                    if((_selectedItem == "İş Seçin") ){
                      Fluttertoast.showToast(msg: "Lütfen Önce İş Seçin");
                    }
                    else if(butonDurum == true){
                      Fluttertoast.showToast(msg: "Zaten bir iştesiniz.");
                    }
                    else{
                      veriEsitle(isListele);
                      setShared(_selectedItem);
                      IsiBaslat();
                    }
                   });
                  },
                  child: Text('İşi Başlat',style: TextStyle(fontSize: 18.0),),
              ),
            ),

            //STOP Buton
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
                  minimumSize: Size(160, 50), 
                ),
                onPressed: (){
                  setState(() {
                    if(butonDurum == false){
                      Fluttertoast.showToast(msg: "Lütfen İş seçin");
                    }
                    else{
                      IsiBitir(double.parse(is_ucret));
                      setSharedBitir();
                    }
                  });
                },
                child: Text('İşi Bitir',style: TextStyle(fontSize: 18.0),),
              ),
            ),
             Container(
              child: StreamBuilder(
                stream: _userStreamGiris,
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                  
                  return Container(
                    padding: EdgeInsets.fromLTRB(10,0,10,0),
                    height: 120,
                    width: double.maxFinite,
                    child: Card(
                      color: Color.fromARGB(255, 187, 255, 190),
                      elevation: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text("İş Adı: " + "$is_adi",style: TextStyle(fontSize: 18.0),),
                          Text("İş No: "+ "$is_no",style: TextStyle(fontSize: 18.0),),
                          Text(r"Ücret: $" + "$is_ucret",style: TextStyle(fontSize: 18.0),),
                          Text("Kazanılan Para: " + r"$" + "$sonuc",style: TextStyle(fontSize: 18.0),),
                          Text("Çalışılan Süre: " + "$saat" + "." +  "$sifir$dakika" + " Saat",style: TextStyle(fontSize: 18.0),),
                        ],
                      ),
                    ),
                  );
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}

 */