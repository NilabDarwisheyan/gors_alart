import 'dart:math';

class Pill {
  int id;
  String name;
  String amount;
  String type;
  int howManyWeeks;
  String medicineForm;
  int time;
  int notifyId;

  Pill(
      {this.id,
      this.howManyWeeks,
      this.time,
      this.amount,
      this.medicineForm,
      this.name,
      this.type,
      this.notifyId});


  static int _idAutoGen = 4;
  static void addPill(Pill pill){
    pill.id = _idAutoGen;
    pills[_idAutoGen] = pill;
    _idAutoGen++;
  }
  static Map<int,Pill> pills = {
    1:Pill(
        id:1,
        name: "paracetamol",
        amount:"2",
        type: "pills",
        howManyWeeks:2,
        medicineForm: "Pill",
        time: 1669062926954,
        notifyId: 123123),
    2:Pill(
        id:2,
        name: "paracetamol",
        amount:"2",
        type: "ml",
        howManyWeeks:2,
        medicineForm: "Syrup",
        time: 1669062826954,
        notifyId: 123123),
    3:Pill(
        id:3,
        name: "paracetamol",
        amount:"2",
        type: "pills",
        howManyWeeks:2,
        medicineForm: "Capsule",
        time: 1669062726954,
        notifyId: 123123),
  };


   String get image{
    switch(this.medicineForm){
      case "Syrup": return "assets/images/syrup.png"; break;
      case "Pill":return "assets/images/pills.png"; break;
      case "Capsule":return "assets/images/capsule.png"; break;
      case "Cream":return "assets/images/cream.png"; break;
      case "Drops":return "assets/images/drops.png"; break;
      case "Syringe":return "assets/images/syringe.png"; break;
      default : return "assets/images/pills.png"; break;
    }
  }
  //=============================================================================
}
