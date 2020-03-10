import 'package:flutter/material.dart';
import 'package:prm_flutter/model/useraddress.dart';

class AddressCard extends StatefulWidget {
  final UserAddress address;
  final int value;
  final int groupValue;
  final Function(int) onChange;

  AddressCard(this.address,this.value,this.groupValue,this.onChange);

  @override
  _AddressCardState createState() => _AddressCardState();
}

class _AddressCardState extends State<AddressCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          widget.value !=null ? Expanded(
            flex: 1,
            child: Radio(
              value: widget.value,
              groupValue: widget.groupValue,
              onChanged: widget.onChange,
            ),
          ): Container(),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("${widget.address.name} - ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      Text("${widget.address.phoneNumber}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Text("${widget.address.address}")
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
