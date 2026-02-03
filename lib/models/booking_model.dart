
class BookingModel {
  final String bookingId;
  final String fileNumber;
  final String createdAt;
  final String updatedAt;
  final String customerVehicleNumber;
  final String customerName;
  final String latitudeAndLongitude;
  final String location;
  final String dropoffLatitudeAndLongitude;
  final String dropoffLocation;
  final String mob1;
  final String mob2;
  final String driverSalary;
  final String totalAmount;
  final String status;
  final String vehicleNumber;
  final String workType;
  final bool cashPending;
  final bool verified;
  final String companyName;
  final bool pickupImagePending;
  final bool dropoffImagePending;
  final bool inventoryImagePending;
  final bool partialPayment;
  final String pickupDistence;
  final List pickupImages;
  final List dropoffImages;
  final String inventoryImage;
  final String partialAmount;

  BookingModel({
    required this.bookingId,
    required this.fileNumber,
    required this.createdAt,
    required this.updatedAt,
    required this.customerVehicleNumber,
    required this.customerName,
    required this.latitudeAndLongitude,
    required this.location,
    required this.dropoffLatitudeAndLongitude,
    required this.dropoffLocation,
    required this.mob1,
    required this.mob2,
    required this.driverSalary,
    required this.totalAmount,
    // required this.payableAmountForProvider,
    required this.status,
    required this.vehicleNumber,
    required this.workType,
    required this.cashPending,
    required this.verified,
    required this.partialPayment,
    required this.companyName,
    required this.dropoffImagePending,
    required this.pickupImagePending,
    required this.inventoryImagePending,
    required this.pickupDistence,
    required this.pickupImages,
    required this.dropoffImages,
    required this.inventoryImage,
    required this.partialAmount,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      bookingId: json['_id'].toString(),
      fileNumber: json['fileNumber'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      customerVehicleNumber: json['customerVehicleNumber'] ?? '',
      customerName: json['customerName'] ?? 'null',
      latitudeAndLongitude: json['latitudeAndLongitude'] ?? '',
      location: json['location'] ?? 'null',
      dropoffLatitudeAndLongitude: json['dropoffLatitudeAndLongitude'] ?? '',
      dropoffLocation: json['dropoffLocation'] ?? '',
      mob1: json['mob1'] ?? '',
      mob2: json['mob2'] ?? '',
      driverSalary: json['driverSalary'].toString(),
      totalAmount: json['totalAmount'].toString(),
      // payableAmountForProvider: json['payableAmountForProvider'].toString(),
      status: json['status'] ?? 'null',
      vehicleNumber: json['vehicleNumber'] ?? '',
      workType: json['workType'] ?? '',
      cashPending: json['cashPending'] ?? false,
      verified: json['verified'] ?? false,
      companyName: json['companyName'] ?? '',
      pickupImagePending: json['pickupImagePending'] == true,
      partialPayment: json['partialPayment'] == true,
      dropoffImagePending: json['dropoffImagePending'] == true,
      inventoryImagePending: json['inventoryImagePending'] == true,
      pickupDistence: (json['pickupDistence'] != null) ? json['pickupDistence'].toString() : '0',
      pickupImages: json['pickupImages'] ?? [],
      dropoffImages: json['dropoffImages'] ?? [],
      partialAmount: json['partialAmount'].toString(),
      inventoryImage: json['inventoryImage'] ??'',
    );
  }

  // Add the copyWith method
  BookingModel copyWith({
    String? bookingId,
    String? fileNumber,
    String? createdAt,
    String? updatedAt,
    String? customerVehicleNumber,
    String? customerName,
    String? latitudeAndLongitude,
    String? location,
    String? dropoffLatitudeAndLongitude,
    String? dropoffLocation,
    String? mob1,
    String? mob2,
    String? driverSalary,
    String? totalAmount,
    // String? payableAmountForProvider,
    String? status,
    String? vehicleNumber,
    String? workType,
    bool? cashPending,
    bool? verified,
    String? companyName,
    bool? pickupImagePending,
    bool? dropoffImagePending,
    bool? inventoryImagePending,
    bool? partialPayment,
    String? pickupDistence,
    List? pickupImages,
    List? dropoffImages,
    String? partialAmount,
    String? inventoryImage,

  }) {
    return BookingModel(
      bookingId: bookingId ?? this.bookingId,
      fileNumber: fileNumber ?? this.fileNumber,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      customerVehicleNumber: customerVehicleNumber ?? this.customerVehicleNumber,
      customerName: customerName ?? this.customerName,
      latitudeAndLongitude: latitudeAndLongitude ?? this.latitudeAndLongitude,
      location: location ?? this.location,
      dropoffLatitudeAndLongitude:
          dropoffLatitudeAndLongitude ?? this.dropoffLatitudeAndLongitude,
      dropoffLocation: dropoffLocation ?? this.dropoffLocation,
      mob1: mob1 ?? this.mob1,
      mob2: mob2 ?? this.mob2,
      driverSalary: driverSalary ?? this.driverSalary,
      totalAmount: totalAmount ?? this.totalAmount,
      // payableAmountForProvider: payableAmountForProvider ?? this.payableAmountForProvider,
      status: status ?? this.status,
      vehicleNumber: vehicleNumber ?? this.vehicleNumber,
      workType: workType ?? this.workType,
      cashPending: cashPending ?? this.cashPending,
      verified: verified ?? this.verified,
      companyName: companyName ?? this.companyName,
      pickupImagePending: pickupImagePending ?? this.pickupImagePending,
      dropoffImagePending: dropoffImagePending ?? this.dropoffImagePending,
      inventoryImagePending: inventoryImagePending ?? this.inventoryImagePending,
      pickupDistence: pickupDistence ?? this.pickupDistence,
      pickupImages: pickupImages ?? this.pickupImages,
      dropoffImages: dropoffImages ?? this.dropoffImages,
      partialAmount: partialAmount ?? this.partialAmount,
      partialPayment: partialPayment ?? this.partialPayment,
      inventoryImage: inventoryImage ?? this.inventoryImage,
    );
  }
}























// class BookingModel{
//   final String bookingId;
//   final String fileNumber;
//   final String createdAt;
//   final String customerVehicleNumber;
//   final String customerName;
//   final String latitudeAndLongitude;
//   final String location;
//   final String dropoffLatitudeAndLongitude;
//   final String dropoffLocation;
//   final String mob1;
//   final String mob2;
//   final String driverSalary;
//   final String totalAmount;
//   // final String payableAmountForProvider;
//   final String status;
//   final String vehicleNumber;
//   final String workType;
//   final bool cashPending;


//   BookingModel({
//     required this.bookingId,
//     required this.fileNumber, 
//     required this.createdAt,
//     required this.customerVehicleNumber, 
//     required this.customerName,
//     required this.latitudeAndLongitude, 
//     required this.location, 
//     required this.dropoffLatitudeAndLongitude, 
//     required this.dropoffLocation, 
//     required this.mob1, 
//     required this.mob2, 
//     required this.driverSalary, 
//     required this.totalAmount,
//    // required this.payableAmountForProvider,
//     required this.status,
//     required this.vehicleNumber,
//     required this.workType,
//     required this.cashPending,
//   });
  
//   factory BookingModel.fromJson(Map<String, dynamic> json){
//     return BookingModel(
//       bookingId: json['_id'].toString(),
//       fileNumber: json['fileNumber'] ?? 'null', 
//       createdAt: json['createdAt'] ?? 'null',
//       customerVehicleNumber: json['customerVehicleNumber'] ?? 'null',
//       customerName: json['customerName'] ?? 'null',
//       latitudeAndLongitude: json['latitudeAndLongitude'] ?? 'null',
//       location: json['location'] ?? 'null',
//       dropoffLatitudeAndLongitude: json['dropoffLatitudeAndLongitude']?? 'null',
//       dropoffLocation: json['dropoffLocation'] ?? 'null',
//       mob1: json['mob1'] ?? 'null', 
//       mob2: json['mob2'] ?? 'null', 
//       driverSalary: json['driverSalary'].toString(),
//       totalAmount: json['totalAmount'].toString(),
//       //payableAmountForProvider: json['payableAmountForProvider'].toString(),
//       status: json['status'] ?? 'null',
//       vehicleNumber: json['vehicleNumber'] ?? 'null',
//       workType :json['workType'] ?? 'null',
//       cashPending: json['cashPending'],
//       );
//   }

// }



