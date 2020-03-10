import 'package:flutter/material.dart';
import 'package:prm_flutter/model/order.detail.dart';
import 'package:prm_flutter/screen/order/widget/rating.dialog.dart';
import 'package:prm_flutter/service/apiEnv.dart';

class ProductCard extends StatefulWidget {
  final OrderDetail orderDetail;

  ProductCard(this.orderDetail);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {


  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Image.network("${Env.imageEndPoint}${widget.orderDetail.image}"),
        ),
        Expanded(
          flex: 6,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: Text("Product: ")),
                  Expanded(
                    flex: 4,
                    child: Container(
                        child:   Text("${widget.orderDetail.productName}", textAlign: TextAlign.right,)
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Color: "),
                  Text("${widget.orderDetail.color}",)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Size: "),
                  Text("${widget.orderDetail.size}",)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Quantity: "),
                  Text("${widget.orderDetail.quantity}",)
                ],
              ),
              Divider(),
            ],
          ),
        ),
      ],
    );
  }
}
