class RewardModel {
  final String rewardId;
  final String name;
  final int price;
  final String description;
  final int pointsRequired;
  final int stock;
  final String rewardFor;
  final String image;
  final int totalRedeem;


  RewardModel({
    required this.rewardId,
    required this.name,
    required this.price,
    required this.description,
    required this.pointsRequired,
    required this.stock,
    required this.rewardFor,
    required this.image,
    required this.totalRedeem,

  });

  factory RewardModel.fromJson(Map<String, dynamic> json) {
    return RewardModel(
      rewardId: json['_id'].toString(),
      name: json['name'] ?? '',
      price: json['price'] ?? 0,
      description: json['description'] ?? '',
      pointsRequired: json['pointsRequired'] ?? 0,
      stock: json['stock'] ?? 0,
      rewardFor: json['rewardFor'] ?? '',
      image: json['image'] ?? '',
      totalRedeem: json['TotalRedeem'] ?? 0,
   
    );
  }

  
}