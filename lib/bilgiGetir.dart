class info{

  late String userNo, workNo, itemSelected, enteredDate, enteredTime, exitDate, exitTime, totalMoney, stateButton;


  info(this.userNo,this.workNo,this.itemSelected,this.enteredDate,this.enteredTime,this.exitDate,this.exitTime,
  this.totalMoney,this.stateButton);

  info.fromJson(Map<String,dynamic>json) : 
  userNo = json["userNo"],
  workNo = json["workNo"],
  itemSelected = json["itemSelected"],
  enteredDate = json["userNo"],
  enteredTime = json["enteredTime"],
  exitDate = json["exitDate"],
  exitTime = json["exitTime"],
  totalMoney = json["totalMoney"],
  stateButton = json["stateButton"];

  Map<String, dynamic> toJson() => {
    "userNo": userNo,
    "workNo": workNo,
    "itemSelected": itemSelected,
    "enteredDate": enteredDate,
    "enteredTime": enteredTime,
    "exitDate": exitDate,
    "exitTime": exitTime,
    "totalMoney": totalMoney,
    "stateButton": stateButton,
  };



}