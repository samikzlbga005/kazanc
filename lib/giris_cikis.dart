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