import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resman_mobile_customer/src/blocs/cartBloc/bloc.dart';
import 'package:resman_mobile_customer/src/blocs/cartBloc/event.dart';
import 'package:resman_mobile_customer/src/blocs/cartBloc/state.dart';
import 'package:resman_mobile_customer/src/models/dailyDish.dart';

class AddCartButton extends StatefulWidget {
  final DailyDish dailyDish;

  const AddCartButton({Key key, @required this.dailyDish})
      : assert(dailyDish != null),
        super(key: key);

  @override
  _AddCartButtonState createState() => _AddCartButtonState();
}

class _AddCartButtonState extends State<AddCartButton> {
  CartBloc _cartBloc = CartBloc();
  bool isCreating = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BlocListener(
      bloc: _cartBloc,
      listener: (BuildContext context, state) {
        if (state is CartBlocSaving)
          setState(() {
            isCreating = true;
          });
        else
          Future.delayed(Duration(seconds: 1)).then((_) {
            setState(() {
              isCreating = false;
            });
          });
      },
      child: MaterialButton(
        color: Theme.of(context).primaryColor,
        onPressed: () {
          if (!isCreating)
            _cartBloc.dispatch(AddDishIntoCart(widget.dailyDish));
        },
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 30,
              height: 30,
              child: isCreating
                  ? CircularProgressIndicator(
                      backgroundColor: colorScheme.onPrimary,
                    )
                  : Icon(
                      Icons.add_shopping_cart,
                      color: Colors.white,
                    ),
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              'Thêm vào hoá đơn',
              style: TextStyle(color: Colors.white, fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
