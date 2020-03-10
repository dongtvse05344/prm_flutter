import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:prm_flutter/bloc/order.bloc.dart';
import 'package:prm_flutter/model/order.detail.dart';
import 'package:prm_flutter/service/productService.dart';
import 'package:prm_flutter/style/colors.dart';
import 'package:prm_flutter/style/texts.dart';
import 'package:prm_flutter/widget/MessageDialog.dart';
import 'package:provider/provider.dart';

class RatingDialog extends StatefulWidget {
  final OrderDetail orderDetail;

  RatingDialog(this.orderDetail);

  @override
  _RatingDialogState createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  double rating =3.5;
  TextEditingController _editingController = new TextEditingController();
  OrderBloc _orderBloc;
  void rated() {
    Navigator.pop(context);
    _orderBloc.createRate(new RatingCM(orderDetailId: widget.orderDetail.id ,
                comment:_editingController.text,
                rate: rating) );
    MessageDialog.showMessageDialog(context, "Done", "Thank you for your idea");
  }
  @override
  Widget build(BuildContext context) {
    _orderBloc = Provider.of<OrderBloc>(context);
    var size = MediaQuery.of(context).size;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
        ),
        height: 320.0,
        width: 300.0,
        child: Column(
          children: <Widget>[
            Text(
              "Do you like this Product ?",
              style: MyText.cardTitle,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Let us know what do you think",
            ),
            SizedBox(
              height: 5,
            ),
            RatingBar(
              initialRating: rating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 40,
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: MyColor.firstColor,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  this.rating = rating;
                });
              },
            ),
            Container(
                width: size.width,
                padding: EdgeInsets.all(16),
                color: Colors.white,
                child: TextFormField(
                  controller: _editingController,
                  keyboardType: TextInputType.multiline,
                  minLines: 4,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintMaxLines: 3,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                )),
            InkWell(
              onTap: rated,
              child: Container(
                height: 40,
                width: 150,
                margin: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 1,
                      color: MyColor.firstColor,
                    )),
                child: Center(
                  child: Material(
                    color: Colors.white,
                    child: Text(
                      "Send Rate",
                      style: TextStyle(
                          color: MyColor.firstColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
