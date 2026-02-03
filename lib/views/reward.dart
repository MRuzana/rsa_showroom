import 'package:flutter/material.dart';
import 'package:rsa_showroom/api/api_constants.dart';
import 'package:rsa_showroom/models/reward_model.dart';
import 'package:rsa_showroom/models/showroon_staff_model.dart';
import 'package:rsa_showroom/services/reward_services.dart';
import 'package:rsa_showroom/services/showroom_staff_sevices.dart';
import 'package:rsa_showroom/views/widgets/add_addresses_widget.dart';
import 'package:rsa_showroom/views/widgets/custom_appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Rewards extends StatefulWidget {
  const Rewards({super.key});

  @override
  State<Rewards> createState() => _RewardsState();
}

class _RewardsState extends State<Rewards> {
  int? rewardPoints;
  ShowroomStaffModel? showroomStaffModel;
  List<RewardModel> _allRewards = [];
  bool _sortAscending = true;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadStaffInfo();
    fetchRewards();
  }

  Future<void> fetchRewards() async {
    setState(() => _isLoading = true);

    final apiService = RewardServices();
    final fetchedRewards = await apiService.fetchAllRewards();

    setState(() {
      _allRewards = fetchedRewards
          .where((reward) => reward.rewardFor == "ShowroomStaff")
          .toList();

      _allRewards
          .sort((a, b) => a.price.compareTo(b.price)); // default ascending
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          toolbarHeight: 0,
          elevation: 0,
        ),
      
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Center(child: customHeader('REWARDS', context)),
              _buildPointsBanner(rewardPoints),
             // const SizedBox(height: 16),
              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _allRewards.isEmpty
                        ? const Center(child: Text("No rewards available"))
                        : ListView.builder(
                            itemCount: _allRewards.length,
                            itemBuilder: (context, index) {
                              return _buildRewardItem(_allRewards[index]);
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPointsBanner(int? rewardPoints) {

    double _rotationTurns = 0.0; // 0.0 for upward (ascending), 0.5 for downward (descending)
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const Text(
            "Total Reward Points",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.red),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    rewardPoints != null
                        ? rewardPoints.toString()
                        : "Loading...",
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold,color: Colors.red),
                  ),
                ),
              ),
              IconButton(
                icon: AnimatedRotation(
                  turns: _sortAscending
                      ? 0.5
                      : 0.0, // 0.0 = normal, 0.5 = 180° flip
                  duration: const Duration(milliseconds: 300),
                  child: const Icon(Icons.sort, color: Colors.red),
                ),
                onPressed: () {
                  setState(() {
                    _sortAscending = !_sortAscending;
                    _rotationTurns = _sortAscending ? 0.5 : 0.0;
                    _allRewards.sort((a, b) => _sortAscending
                        ? a.price.compareTo(b.price)
                        : b.price.compareTo(a.price));
                  });
                },
              ),
            ],
          ),
          
        ],
      ),
    );
  }

  Widget _buildRewardItem(RewardModel reward) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                ApiConstants.kBaseUrlImage + reward.image,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Image(
                  image: AssetImage('assets/images/logo.png'),
                  width: 80,
                  height: 80,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        reward.name,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text("${reward.stock} items left",
                            style: const TextStyle(fontSize: 12)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(reward.description,
                      style: const TextStyle(fontSize: 13, color: Colors.grey)),
                  const SizedBox(height: 4),
                  Text("₹ ${reward.price}"),
                  const SizedBox(height: 6),
                  Text("Points required : ${reward.pointsRequired}",
                      style:
                          const TextStyle(fontSize: 12, color: Colors.black)),
                  const SizedBox(height: 6),
                  ElevatedButton(
                    onPressed: reward.stock > 0 &&
                            rewardPoints != null &&
                            rewardPoints! >= reward.pointsRequired
                        ? () async {
                            final confirmed = await showDialog<bool>(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: const Text("Confirm Redemption"),
                                content: Text(
                                    "Redeem ${reward.name} for ${reward.pointsRequired} points?"),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, false),
                                    child: const Text("Cancel"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () =>
                                        Navigator.pop(context, true),
                                    child: const Text("Redeem"),
                                  ),
                                ],
                              ),
                            );

                            if (confirmed == true) {
                              final redemption = await RewardServices()
                                  .redeemReward(
                                    rewardId:  reward.rewardId,
                                    
                                   );

                              if (redemption) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          "Reward redeemed successfully.")),
                                );
                                await fetchRewards(); // Refresh list
                               // await loadDriverInfo(); // Refresh points
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          "Redemption failed. Please try again.")),
                                );
                              }
                            }
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      backgroundColor: Colors.red,
                    ),
                    child: const Text("Redeem",
                        style: TextStyle(fontSize: 15, color: Colors.white)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  Future<void> loadStaffInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final staffId = prefs.getString('staffId');
    if (staffId != null) {
      ShowroomStaffModel? staffData =
          await ShowroomStaffSevices().fetchStaffDetails();
      if (!mounted) return;
      if (staffData != null) {
        setState(() {
          rewardPoints = staffData.rewardPoints;
          
        });
      }
    }
  }
}
