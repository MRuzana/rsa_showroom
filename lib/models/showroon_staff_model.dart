class ShowroomStaffModel {
  final String id;
  final String designation;
  final String name;
  final String phoneNumber;
  final String whatsappNumber;
  final int rewardPoints;
  final String showroomId;

  ShowroomStaffModel({
    required this.id,
    required this.designation,
    required this.name,
    required this.phoneNumber,
    required this.whatsappNumber,
    required this.rewardPoints,
    required this.showroomId,
  });

  /// From JSON
  factory ShowroomStaffModel.fromJson(Map<String, dynamic> json) {
    return ShowroomStaffModel(
      id: json['_id']?.toString() ?? '',
      designation: json['designation']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      phoneNumber: json['phoneNumber']?.toString() ?? '',
      whatsappNumber: json['whatsappNumber']?.toString() ?? '',
      rewardPoints: json['rewardPoints'] ?? 0,
      showroomId: json['showroomId']?.toString() ?? '',
    );
  }
}
