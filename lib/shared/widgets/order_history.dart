import 'package:flutter/material.dart';
import 'package:orbital_app/models/order.dart';
import 'package:orbital_app/screens/drawer/order_view_history.dart';



class OrderTile extends StatelessWidget {
  final Order info;

  OrderTile({
    this.info
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.black, width: 1.0))
            ),
      padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
      child: ListTile(
        title: Text(info.fromName, style: TextStyle(fontSize: 20.0)),
        subtitle: Text(info.order,style: TextStyle(fontSize: 20.0)),
        trailing: Text('\$ ${info.fee}', style: TextStyle(fontSize: 20.0),),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => OrderHistoryPopUp(order: info))),
      )
    );
  }
  
}