class TransactionModel {
  int? id;
  String? status;
  String? totalPayment;
  DateTime? createdAt;
  DateTime? updatedAt;
  late List<TransactionItemModel>? items;

  TransactionModel({
    this.id,
    this.status,
    this.totalPayment,
    this.createdAt,
    this.updatedAt,
    this.items,
  });

  TransactionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    totalPayment = json['total_payment'];
    items = json['items']
        .map<TransactionItemModel>(
            (items) => TransactionItemModel.fromJson(items))
        .toList();
    createdAt = DateTime.parse(json['created_at']);
    updatedAt = DateTime.parse(json['updated_at']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'total_payment': totalPayment,
      'items': items?.map((items) => items.toJson()).toList(),
      'created_at': createdAt.toString(),
      'updated_at': updatedAt.toString(),
    };
  }
}

class TransactionItemModel {
  int? id;
  int? quantity;
  // late ProductModel? product;

  TransactionItemModel({
    this.id,
    this.quantity,
    // this.product,
  });

  TransactionItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    // product = ProductModel.fromJson(json['product']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quantity': quantity,
      // 'product': product?.toJson(),
    };
  }
}
