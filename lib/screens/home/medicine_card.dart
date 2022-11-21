import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:medicine/database/repository.dart';
import 'package:medicine/models/pill.dart';

class MedicineCard extends StatelessWidget {

  final Pill medicine;
  final Function setData;
  MedicineCard(this.medicine,this.setData);

  @override
  Widget build(BuildContext context) {
    //check if the medicine time is lower than actual
    final bool isEnd = DateTime.now().millisecondsSinceEpoch > medicine.time;

    return Card(
        elevation: 1,
        margin: EdgeInsets.symmetric(vertical: 8.0),
        color: Colors.yellow,
        child: ListTile(
            onLongPress: () =>
                _showDeleteDialog(context, medicine),
            contentPadding:
                EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
            title: Text(
              medicine.name,
              style: Theme.of(context).textTheme.headline1.copyWith(
                  color: Colors.black,
                  fontSize: 20.0,
                  decoration: isEnd ? TextDecoration.lineThrough : null),
              maxLines: 1,
            ),
            subtitle: Text(
              "${medicine.amount} ${medicine.medicineForm}",
              style: Theme.of(context).textTheme.headline5.copyWith(
                  color: Colors.grey[600],
                  fontSize: 15.0,
                  decoration: isEnd ? TextDecoration.lineThrough : null),
              maxLines: 1,
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  DateFormat("HH:mm").format(
                      DateTime.fromMillisecondsSinceEpoch(medicine.time)),
                  style: TextStyle(
                      color: Colors.grey[500],
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      decoration: isEnd ? TextDecoration.lineThrough : null),
                )
              ],
            ),
            leading: Container(
              width: 60.0,
              height: 60.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                        isEnd ? Colors.white : Colors.transparent,
                        BlendMode.saturation),
                    child: Image.asset(
                      medicine.image
                    )),
              ),
            )
        ));
  }


  //--------------------------| SHOW THE DELETE DIALOG ON THE SCREEN |-----------------------

  void _showDeleteDialog(BuildContext context, Pill medicine) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("حذف ?"),
              content: Text("اطمینان دارید حذف شود ${medicine.name} دارو?"),
              contentTextStyle:
                  TextStyle(fontSize: 17.0, color: Colors.grey[800]),
              actions: [
                FlatButton(
                  splashColor: Theme.of(context).primaryColor.withOpacity(0.3),
                  child: Text(
                    "لغو",
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  splashColor: Theme.of(context).primaryColor.withOpacity(0.3),
                  child: Text("حذف",
                      style: TextStyle(color: Theme.of(context).primaryColor)),
                  onPressed: () {
                    Pill.pills.remove(medicine.id);
                    setData();
                    Navigator.pop(context);
                  },
                ),
              ],
            ));
  }
  //============================================================================================


}
