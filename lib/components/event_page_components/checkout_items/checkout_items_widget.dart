import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'checkout_items_model.dart';
export 'checkout_items_model.dart';

class CheckoutItemsWidget extends StatefulWidget {
  const CheckoutItemsWidget({super.key});

  @override
  State<CheckoutItemsWidget> createState() => _CheckoutItemsWidgetState();
}

class _CheckoutItemsWidgetState extends State<CheckoutItemsWidget> {
  late CheckoutItemsModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CheckoutItemsModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
