import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rsa_showroom/controllers/location_provider.dart';
import 'package:rsa_showroom/core/constants/spacing_constants.dart';
import 'package:rsa_showroom/core/utils/base_scafold.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreenContent extends StatefulWidget {
  const HomeScreenContent({super.key});

  @override
  State<HomeScreenContent> createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<HomeScreenContent> {
  String? staffName;
  String? staffPhone;

  @override
  void initState() {
    super.initState();
    final locationProvider =
        Provider.of<LocationProvider>(context, listen: false);
    locationProvider.startLocationUpdates(); // Starts location updates
    // startService();
    loadStaffInfo();
    // _sendFcmToken();
  }

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);
    //  final position = locationProvider.currentPosition;
    final city = locationProvider.currentCity;

    return Scaffold(
      backgroundColor: Colors.white,
      body: BaseScaffold(
        child: SafeArea(
          child: Column(
            children: [
              // Top Profile Section

              _buildTopProfileSection(city ?? ""),

              // Main Content Section
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30)),
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 10)
                    ],
                  ),
                  child: LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      int crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
                      return GridView.count(
                        crossAxisCount: crossAxisCount,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                        childAspectRatio: 1.2,
                        children: [
                          _buildCard(Icons.local_shipping, "Add Booking",
                              "Add new bookings", Colors.redAccent, () {
                            Navigator.pushNamed(context, '/addBookings');
                          }),
                          _buildCard(Icons.assignment_turned_in, "Ongoing",
                              "Review completed trips", Colors.blueAccent, () {
                            Navigator.pushNamed(context, '/finished');
                          }),
                          _buildCard(
                              Icons.pending_actions,
                              "Scheduled",
                              "Manage scheduled trips",
                              Colors.orangeAccent, () {
                            Navigator.pushNamed(context, '/pending');
                          }),
                          _buildCard(Icons.account_balance_wallet, "Completed",
                              "View unpaid bookings", Colors.greenAccent, () {
                            Navigator.pushNamed(context, '/notPaid');
                          }),
                          _buildCard(
                              Icons.list_alt,
                              "Pending",
                              "Browse all your bookings",
                              Colors.purpleAccent, () {
                            Navigator.pushNamed(context, '/allJobs');
                          }),
                          _buildCard(Icons.bar_chart, "Report",
                              "View your reports", Colors.grey, () {
                            Navigator.pushNamed(context, '/report');
                          }),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Future<void> _sendFcmToken() async {
  //   String? fcmToken = await FirebaseMessaging.instance.getToken();
  //   if (fcmToken != null) {
  //     final prefs = await SharedPreferences.getInstance();
  //     final driverId = prefs.getString('driverId');
  //     if (driverId != null && driverId.isNotEmpty) {
  //       await DriverServices().sendFCMToken(fcmToken);
  //     }
  //   }
  // }

  Widget _buildCard(IconData icon, String title, String subtitle, Color color,
      VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
        ),
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Icon(icon, color: color, size: 26),
            SizedBox(height: 8),
            Text(title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Expanded(
                child: Text(subtitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 11, color: Colors.black54))),
          ],
        ),
      ),
    );
  }

  Widget _buildTopProfileSection(String city) {
    return Stack(
      children: [
        Container(
          height: 230,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/homeBg.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: 230,
          padding: kpaddingL10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: kpadding8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('$city',
                        style: TextStyle(color: Colors.white, fontSize: 14)),
                    Icon(Icons.location_on, color: Colors.white, size: 18),
                  ],
                ),
              ),
              Spacer(),
              Text("WELCOME",
                  style: TextStyle(color: Colors.white, fontSize: 18)),
              Container(
                height: 2,
                width: 100,
                color: Colors.white,
              ),
              kHeight10,
              Text(
                staffName ?? "Loading...",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              Text(
                staffPhone != null
                    ? "Phone: $staffPhone"
                    : "Fetching details...",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              SizedBox(height: 10),
              // Row(
              //   children: [
              //     Icon(Icons.notifications, color: Colors.redAccent),
              //   ],
              // ),
              kHeight10,
            ],
          ),
        ),
      ],
    );
  }

  Future<void> loadStaffInfo() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      staffName = prefs.getString('name');
      staffPhone = prefs.getString('phoneNumber');
    });
  }
}
