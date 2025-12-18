import 'package:flutter/material.dart';
import 'package:g_e_t_i_n_scanner/backend/supabase/database/tables/events.dart';
import 'package:g_e_t_i_n_scanner/components/event_page_components/event_title/event_title_model.dart'
    show EventTitleModel;
import 'package:g_e_t_i_n_scanner/components/ticket_category/ticket_category_model.dart'
    show TicketCategoryModel;

import '/flutter_flow/flutter_flow_util.dart';
import 'event_page_purchaser_details_widget.dart'
    show EventPagePurchaserDetailsWidget;

class EventPagePurchaserDetailsModel
    extends FlutterFlowModel<EventPagePurchaserDetailsWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for EventTitle component.
  late EventTitleModel eventTitleModel;

  // Model for ticketCategory component.
  late TicketCategoryModel ticketCategoryModel1;

  // Model for ticketCategory component.
  late TicketCategoryModel ticketCategoryModel2;

  EventsRow? event = null;

  TextEditingController phoneController = TextEditingController();

  TextEditingController fullNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  String? phoneNumber;

  String? countryCode;

  String? dialCode;

  bool get isFullNameEmpty  => fullNameController.text.isEmpty;

  bool get isPhoneNoEmpty => phoneController.text.isEmpty;

  bool get isEmailEmpty => emailController.text.isEmpty;

  @override
  void initState(BuildContext context) {
    eventTitleModel = createModel(context, () => EventTitleModel());
    ticketCategoryModel1 = createModel(context, () => TicketCategoryModel());
    ticketCategoryModel2 = createModel(context, () => TicketCategoryModel());
  }

  @override
  void dispose() {
    eventTitleModel.dispose();
    ticketCategoryModel1.dispose();
    ticketCategoryModel2.dispose();
  }

  String? fullNameControllerValidator(String? name) {
    if (name == null || name.isEmpty) {
      return null;
    }
    if (name.length < 2) {
      return 'Name must be at least 2 characters long';
    }

    return null;
  }

  String? phoneNoValidator(String? phone) {
    if (phone == null || phone.isEmpty) {
      return null;
    }
    final phoneRegExp = RegExp(r'^\+?[0-9]{7,15}$');
    if (!phoneRegExp.hasMatch(phone)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  String? emailControllerValidator(String? email) {
    if (email == null || email.isEmpty) {
      return null;
    }
    final emailRegExp =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegExp.hasMatch(email)) {
      return 'Please enter a valid email address';
    }
    return null;
  }
}
