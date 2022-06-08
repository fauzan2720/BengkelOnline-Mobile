class CallMechanicModel {
  int? id;
  String? mechanic;
  String? typeOfWork;
  String? detailProblem;
  String? paymentMethod;
  String? totalPayment;
  String? status;
  String? vehicleId;
  // late VehicleModel? vehicle;
  // late LocationModel? location;
  // late ProductModel? product;
  DateTime? createdAt;
  DateTime? updatedAt;

  CallMechanicModel({
    this.id,
    this.mechanic,
    this.typeOfWork,
    this.detailProblem,
    this.paymentMethod,
    this.totalPayment,
    this.status,
    this.vehicleId,
    // this.location,
    // this.product,
    this.createdAt,
    this.updatedAt,
  });

  CallMechanicModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mechanic = json['mechanic'];
    typeOfWork = json['type_of_work'];
    detailProblem = json['detail_problem'];
    paymentMethod = json['payment_method'];
    totalPayment = json['total_payment'];
    status = json['status'];
    vehicleId = json['vehicle_id'];
    // vehicle = VehicleModel.fromJson(json['vehicle']);
    // location = LocationModel.fromJson(json['location']);
    // product = ProductModel.fromJson(json['location']);
    createdAt = DateTime.parse(json['created_at']);
    updatedAt = DateTime.parse(json['updated_at']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'mechanic': mechanic,
      'type_of_work': typeOfWork,
      'detail_problem': detailProblem,
      'payment_method': paymentMethod,
      'total_payment': totalPayment,
      'status': status,
      'vehicle': vehicleId,
      // 'vehicle': vehicle!.toJson(),
      // 'location': location!.toJson(),
      // 'product': product!.toJson(),
      'created_at': createdAt.toString(),
      'updated_at': updatedAt.toString(),
    };
  }
}
