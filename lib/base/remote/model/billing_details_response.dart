// To parse this JSON data, do
//
//     final billingDetailsResponse = billingDetailsResponseFromJson(jsonString);

import 'dart:convert';

BillingDetailsResponse billingDetailsResponseFromJson(String str) =>
    BillingDetailsResponse.fromJson(json.decode(str));

String billingDetailsResponseToJson(BillingDetailsResponse data) =>
    json.encode(data);

class BillingDetailsResponse {
  List<Billing> billings;
  WalletHistory walletHistory;

  BillingDetailsResponse({
    required this.billings,
    required this.walletHistory,
  });

  factory BillingDetailsResponse.fromJson(Map<String, dynamic> json) =>
      BillingDetailsResponse(
        billings: List<Billing>.from(
            json["billings"].map((x) => Billing.fromJson(x))),
        walletHistory: WalletHistory.fromJson(json["wallet_history"]),
      );

// factory BillingDetailsResponse.fromJson(Map<String, dynamic> json) =>
//     BillingDetailsResponse(
//       billings: json["billings"] != null
//           ? List<Billing>.from(json["billings"].map((x) => Billing.fromJson(x)))
//           : [],
//       walletHistory:  WalletHistory.fromJson(json["wallet_history"],
//     )
/*Map<String, dynamic> toJson() => {
        "billings": List<dynamic>.from(billings.map((x) => x.toJson())),
        "wallet_history": walletHistory.toJson(),
      };*/
}

class Billing {
  int? id;
  int? saleReferenceId;
  int? accountId;
  String? ticketNo;
  String? customerPhoneNumber;
  String? tableNo;
  String? floorNo;
  int? guestCount;
  DateTime? businessDate;
  DateTime? openDate;
  DateTime? closeDate;
  String? customerName;
  double grossAmount;
  double chargeAmount;
  double taxAmount;
  double discountAmount;
  double totalAmount;
  double ncAmount;
  dynamic? grossAmountFmt;
  dynamic? chargeAmountFmt;
  dynamic? taxAmountFmt;
  dynamic? discountAmountFmt;
  dynamic? roundOffFmt;
  dynamic? totalAmountFmt;
  dynamic? ncAmountFmt;
  String? tipAmount;
  List<Item> items;
  List<Tax> taxes;
  List<Payment> payments;
  List<Charge> charges;

  //dynamic otherData;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? walletHistoryId;

  Billing({
    required this.id,
    required this.saleReferenceId,
    required this.accountId,
    required this.ticketNo,
    required this.customerPhoneNumber,
    required this.tableNo,
    required this.floorNo,
    required this.guestCount,
    required this.businessDate,
    required this.openDate,
    required this.closeDate,
    required this.customerName,
    required this.grossAmount,
    required this.chargeAmount,
    required this.taxAmount,
    required this.discountAmount,
    required this.totalAmount,
    required this.ncAmount,
    required this.grossAmountFmt,
    required this.chargeAmountFmt,
    required this.taxAmountFmt,
    required this.discountAmountFmt,
    required this.roundOffFmt,
    required this.totalAmountFmt,
    required this.ncAmountFmt,
    required this.tipAmount,
    required this.items,
    required this.taxes,
    required this.payments,
    required this.charges,
    //required this.otherData,
    required this.createdAt,
    required this.updatedAt,
    required this.walletHistoryId,
  });

  factory Billing.fromJson(Map<String, dynamic> json) => Billing(
        id: json["id"],
        saleReferenceId: json["sale_reference_id"],
        accountId: json["account_id"],
        ticketNo: json["ticket_no"],
        customerPhoneNumber: json["customer_phone_number"],
        tableNo: json["table_no"],
        floorNo: json["floor_no"],
        guestCount: json["guest_count"],
        businessDate: DateTime.parse(json["business_date"]),
        openDate: DateTime.parse(json["open_date"]),
        closeDate: DateTime.parse(json["close_date"]),
        customerName: json["customer_name"],
        grossAmount: json["gross_amount"],
        chargeAmount: json["charge_amount"],
        taxAmount: json["tax_amount"],
        discountAmount: json["discount_amount"],
        totalAmount: json["total_amount"],
        ncAmount: json["nc_amount"],
        grossAmountFmt: json["gross_amount_fmt"],
        chargeAmountFmt: json["charge_amount_fmt"],
        taxAmountFmt: json["tax_amount_fmt"],
        discountAmountFmt: json["discount_amount_fmt"],
        roundOffFmt: json["round_off_fmt"],
        totalAmountFmt: json["total_amount_fmt"],
        ncAmountFmt: json["nc_amount_fmt"],
        tipAmount: json["tip_amount"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        taxes: List<Tax>.from(json["taxes"].map((x) => Tax.fromJson(x))),
        payments: List<Payment>.from(
            json["payments"].map((x) => Payment.fromJson(x))),
        charges:
            List<Charge>.from(json["charges"].map((x) => Charge.fromJson(x))),
        //otherData: json["other_data"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        walletHistoryId: json["wallet_history_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sale_reference_id": saleReferenceId,
        "account_id": accountId,
        "ticket_no": ticketNo,
        "customer_phone_number": customerPhoneNumber,
        "table_no": tableNo,
        "floor_no": floorNo,
        "guest_count": guestCount,
        "business_date":
            "${businessDate?.year?.toString().padLeft(4, '0')}-${businessDate?.month?.toString().padLeft(2, '0')}-${businessDate?.day?.toString().padLeft(2, '0')}",
        "open_date": openDate?.toIso8601String(),
        "close_date": closeDate?.toIso8601String(),
        "customer_name": customerName,
        "gross_amount": grossAmount,
        "charge_amount": chargeAmount,
        "tax_amount": taxAmount,
        "discount_amount": discountAmount,
        "total_amount": totalAmount,
        "nc_amount": ncAmount,
        "gross_amount_fmt": grossAmountFmt,
        "charge_amount_fmt": chargeAmountFmt,
        "tax_amount_fmt": taxAmountFmt,
        "discount_amount_fmt": discountAmountFmt,
        "round_off_fmt": roundOffFmt,
        "total_amount_fmt": totalAmountFmt,
        "nc_amount_fmt": ncAmountFmt,
        "tip_amount": tipAmount,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "taxes": List<dynamic>.from(taxes.map((x) => x.toJson())),
        "payments": List<dynamic>.from(payments.map((x) => x.toJson())),
        "charges": List<dynamic>.from(charges.map((x) => x.toJson())),
        //"other_data": otherData,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "wallet_history_id": walletHistoryId,
      };
}

class Charge {
  int? id;
  String? name;
  String? taxes;
  int? amount;
  dynamic amountFmt;
  String? taxAmount;

  Charge({
    required this.id,
    required this.name,
    required this.taxes,
    required this.amount,
    required this.amountFmt,
    required this.taxAmount,
  });

  factory Charge.fromJson(Map<String, dynamic> json) => Charge(
        id: json["id"],
        name: json["name"],
        taxes: json["taxes"],
        amount: json["amount"],
        amountFmt: json["amount_fmt"],
        taxAmount: json["tax_amount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "taxes": taxes,
        "amount": amount,
        "amount_fmt": amountFmt,
        "tax_amount": taxAmount,
      };
}

class Item {
  List<Tax> taxes;
  int? status;
  int? voidBy;
  dynamic discount;
  int? quantity;
  int? ncAmount;
  int? taxAmount;
  int? kotSentBy;
  String? voidReason;
  int? grossAmount;
  int? menuItemId;
  int? totalAmount;
  int? chargeAmount;
  String? kotSentDate;
  dynamic? ncAmountFmt;
  String? menuItemName;
  dynamic taxAmountFmt;
  int? discountAmount;
  LedgerCategory? ledgerCategory;
  int? servingSizeId;
  dynamic grossAmountFmt;
  ModifierReceipe? modifierReceipe;
  dynamic totalAmountFmt;
  dynamic chargeAmountFmt;
  dynamic discountAmountFmt;

  Item({
    required this.taxes,
    required this.status,
    required this.voidBy,
    required this.discount,
    required this.quantity,
    required this.ncAmount,
    required this.taxAmount,
    required this.kotSentBy,
    required this.voidReason,
    required this.grossAmount,
    required this.menuItemId,
    required this.totalAmount,
    required this.chargeAmount,
    required this.kotSentDate,
    required this.ncAmountFmt,
    required this.menuItemName,
    required this.taxAmountFmt,
    required this.discountAmount,
    required this.ledgerCategory,
    required this.servingSizeId,
    required this.grossAmountFmt,
    required this.modifierReceipe,
    required this.totalAmountFmt,
    required this.chargeAmountFmt,
    required this.discountAmountFmt,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        taxes: List<Tax>.from(json["taxes"].map((x) => Tax.fromJson(x))),
        status: json["status"],
        voidBy: json["void_by"],
        discount: json["discount"],
        quantity: json["quantity"],
        ncAmount: json["nc_amount"],
        taxAmount: json["tax_amount"],
        kotSentBy: json["kot_sent_by"],
        voidReason: json["void_reason"],
        grossAmount: json["gross_amount"],
        menuItemId: json["menu_item_id"],
        totalAmount: json["total_amount"],
        chargeAmount: json["charge_amount"],
        kotSentDate: json["kot_sent_date"],
        ncAmountFmt: json["nc_amount_fmt"],
        menuItemName: json["menu_item_name"],
        taxAmountFmt: json["tax_amount_fmt"],
        discountAmount: json["discount_amount"],
        ledgerCategory: LedgerCategory.fromJson(json["ledger_category"]),
        servingSizeId: json["serving_size_id"],
        grossAmountFmt: json["gross_amount_fmt"],
        modifierReceipe: json["modifier_receipe"] == null
            ? null
            : ModifierReceipe.fromJson(json["modifier_receipe"]),
        totalAmountFmt: json["total_amount_fmt"],
        chargeAmountFmt: json["charge_amount_fmt"],
        discountAmountFmt: json["discount_amount_fmt"],
      );

  Map<String, dynamic> toJson() => {
        "taxes": List<dynamic>.from(taxes.map((x) => x.toJson())),
        "status": status,
        "void_by": voidBy,
        "discount": discount,
        "quantity": quantity,
        "nc_amount": ncAmount,
        "tax_amount": taxAmount,
        "kot_sent_by": kotSentBy,
        "void_reason": voidReason,
        "gross_amount": grossAmount,
        "menu_item_id": menuItemId,
        "total_amount": totalAmount,
        "charge_amount": chargeAmount,
        "kot_sent_date": kotSentDate,
        "nc_amount_fmt": ncAmountFmt,
        "menu_item_name": menuItemName,
        "tax_amount_fmt": taxAmountFmt,
        "discount_amount": discountAmount,
        "ledger_category": ledgerCategory?.toJson(),
        "serving_size_id": servingSizeId,
        "gross_amount_fmt": grossAmountFmt,
        "modifier_receipe": modifierReceipe?.toJson(),
        "total_amount_fmt": totalAmountFmt,
        "charge_amount_fmt": chargeAmountFmt,
        "discount_amount_fmt": discountAmountFmt,
      };
}

class LedgerCategory {
  int? id;
  Name? name;

  LedgerCategory({
    required this.id,
    required this.name,
  });

  factory LedgerCategory.fromJson(Map<String, dynamic> json) => LedgerCategory(
        id: json["id"],
        name: nameValues.map[json["name"]]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": nameValues.reverse[name],
      };
}

enum Name { OTHERS }

final nameValues = EnumValues({"Others": Name.OTHERS});

class ModifierReceipe {
  int? id;
  String? name;
  int? totalAmount;
  dynamic? totalAmountFmt;

  //dynamic optionalModifierGroups;
  List<MandatoryModifierGroup>? mandatoryModifierGroups;

  ModifierReceipe({
    required this.id,
    required this.name,
    required this.totalAmount,
    required this.totalAmountFmt,
    //required this.optionalModifierGroups,
    required this.mandatoryModifierGroups,
  });

  factory ModifierReceipe.fromJson(Map<String, dynamic> json) =>
      ModifierReceipe(
        id: json["id"],
        name: json["name"],
        totalAmount: json["total_amount"],
        totalAmountFmt: json["total_amount_fmt"],
        //optionalModifierGroups: json["optional_modifier_groups"],
        mandatoryModifierGroups: json["mandatory_modifier_groups"] == null
            ? []
            : List<MandatoryModifierGroup>.from(
                json["mandatory_modifier_groups"]!
                    .map((x) => MandatoryModifierGroup.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "total_amount": totalAmount,
        "total_amount_fmt": totalAmountFmt,
        //"optional_modifier_groups": optionalModifierGroups,
        "mandatory_modifier_groups": mandatoryModifierGroups == null
            ? []
            : List<dynamic>.from(
                mandatoryModifierGroups!.map((x) => x.toJson())),
      };
}

class MandatoryModifierGroup {
  int? amount;
  List<Modifier>? modifiers;
  dynamic? amountFmt;
  int? taxAmount;
  dynamic? taxAmountFmt;
  int? servingSizeId;
  int? modifierGroupId;

  MandatoryModifierGroup({
    required this.amount,
    required this.modifiers,
    required this.amountFmt,
    required this.taxAmount,
    required this.taxAmountFmt,
    required this.servingSizeId,
    required this.modifierGroupId,
  });

  factory MandatoryModifierGroup.fromJson(Map<String, dynamic> json) =>
      MandatoryModifierGroup(
        amount: json["amount"],
        modifiers: List<Modifier>.from(
            json["modifiers"].map((x) => Modifier.fromJson(x))),
        amountFmt: json["amount_fmt"],
        taxAmount: json["tax_amount"],
        taxAmountFmt: json["tax_amount_fmt"],
        servingSizeId: json["serving_size_id"],
        modifierGroupId: json["modifier_group_id"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "modifiers": List<dynamic>.from(modifiers!.map((x) => x.toJson())),
        "amount_fmt": amountFmt,
        "tax_amount": taxAmount,
        "tax_amount_fmt": taxAmountFmt,
        "serving_size_id": servingSizeId,
        "modifier_group_id": modifierGroupId,
      };
}

class Modifier {
  int? id;
  String? name;
  int? amount;
  dynamic? amountFmt;
  int? taxAmount;
  dynamic? taxAmountFmt;
  int? servingSizeId;

  Modifier({
    required this.id,
    required this.name,
    required this.amount,
    required this.amountFmt,
    required this.taxAmount,
    required this.taxAmountFmt,
    required this.servingSizeId,
  });

  factory Modifier.fromJson(Map<String, dynamic> json) => Modifier(
        id: json["id"],
        name: json["name"],
        amount: json["amount"],
        amountFmt: json["amount_fmt"],
        taxAmount: json["tax_amount"],
        taxAmountFmt: json["tax_amount_fmt"],
        servingSizeId: json["serving_size_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "amount": amount,
        "amount_fmt": amountFmt,
        "tax_amount": taxAmount,
        "tax_amount_fmt": taxAmountFmt,
        "serving_size_id": servingSizeId,
      };
}

class Tax {
  int? taxId;
  TaxName? taxName;
  bool? inclusive;
  int? totalTaxAmount;
  dynamic totalTaxAmountFmt;

  Tax({
    required this.taxId,
    required this.taxName,
    required this.inclusive,
    required this.totalTaxAmount,
    required this.totalTaxAmountFmt,
  });

  factory Tax.fromJson(Map<String, dynamic> json) => Tax(
        taxId: json["tax_ID"],
        taxName: taxNameValues.map[json["tax_name"]]!,
        inclusive: json["inclusive"],
        totalTaxAmount: json["total_tax_amount"],
        totalTaxAmountFmt: json["total_tax_amount_fmt"],
      );

  Map<String, dynamic> toJson() => {
        "tax_ID": taxId,
        "tax_name": taxNameValues.reverse[taxName],
        "inclusive": inclusive,
        "total_tax_amount": totalTaxAmount,
        "total_tax_amount_fmt": totalTaxAmountFmt,
      };
}

enum TaxName { CGST_FOOD_BEVERAGES, SGST_FOOD_BEVERAGES }

final taxNameValues = EnumValues({
  "CGST - Food & Beverages": TaxName.CGST_FOOD_BEVERAGES,
  "SGST - Food & Beverages": TaxName.SGST_FOOD_BEVERAGES
});

class Payment {
  int? amount;
  int? status;
  String? drawerId;
  dynamic? amountFmt;
  int? tipAmount;
  int? receivedBy;
  String? paymentName;
  String? paymentType;
  dynamic tipAmountFmt;

  Payment({
    required this.amount,
    required this.status,
    required this.drawerId,
    required this.amountFmt,
    required this.tipAmount,
    required this.receivedBy,
    required this.paymentName,
    required this.paymentType,
    required this.tipAmountFmt,
  });

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        amount: json["amount"],
        status: json["status"],
        drawerId: json["drawer_id"],
        amountFmt: json["amount_fmt"],
        tipAmount: json["tip_amount"],
        receivedBy: json["received_by"],
        paymentName: json["payment_name"],
        paymentType: json["payment_type"],
        tipAmountFmt: json["tip_amount_fmt"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "status": status,
        "drawer_id": drawerId,
        "amount_fmt": amountFmt,
        "tip_amount": tipAmount,
        "received_by": receivedBy,
        "payment_name": paymentName,
        "payment_type": paymentType,
        "tip_amount_fmt": tipAmountFmt,
      };
}

class WalletHistory {
  int? id;
  String? status;
  int? walletId;
  DateTime? processedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic redeemedPoint;
  dynamic? earnedPoint;
  String? billingDate;

  WalletHistory({
    required this.id,
    required this.status,
    required this.walletId,
    required this.processedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.redeemedPoint,
    required this.earnedPoint,
    required this.billingDate,
  });

  factory WalletHistory.fromJson(Map<String, dynamic> json) => WalletHistory(
        id: json["id"],
        status: json["status"],
        walletId: json["wallet_id"],
        processedAt: DateTime.parse(json["processed_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        redeemedPoint: json["redeemed_point"],
        earnedPoint: json["earned_point"],
        billingDate: json["billing_date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "wallet_id": walletId,
        "processed_at": processedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "redeemed_point": redeemedPoint,
        "earned_point": earnedPoint,
        "billing_date": billingDate,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
