import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rsa_showroom/core/utils/base_scafold.dart';
import 'package:rsa_showroom/models/showroon_staff_model.dart';
import 'package:rsa_showroom/services/showroom_staff_sevices.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  
  String? staffName;
  String? staffPhone;
  ShowroomStaffModel? staff;

  @override
  void initState() {
    super.initState();
    loadStaffInfo();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Profile",style: GoogleFonts.poppins(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
          ],
        ),
        body: Column(
          children: [
            // Profile Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/images/homeBg.png') as ImageProvider,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          "$staffName",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text(
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          "Trust your feelings, be a good human being",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            // Settings List
            Expanded(
              child: ListView(
                children: [
                  _buildSettingsTile(Icons.person, "Account", () {
                    if (staff != null) {
                      Navigator.pushNamed(context, '/account',
                          arguments: staff);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Staff details not loaded")),
                      );
                    }
                  }),
                  _buildSettingsTile(Icons.lock, "Privacy and security", () {}),
                  _buildSettingsTile(Icons.info, "About", () {}),
                  _buildSettingsTile(Icons.logout, "Logout", () {
                    signoutAlert(context);
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsTile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.red),
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }

  signoutAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            title: const Text(
              'Alert',
              style: TextStyle(fontSize: 14),
            ),
            content: const Text(
              'Do you want to  logout?',
              style: TextStyle(fontSize: 17),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    signout(context);
                  },
                  child: const Text('YES')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('NO')),
            ],
          );
        }));
  }

  signout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('role');
    await prefs.remove('name');
    await prefs.remove('phoneNumber');
    await prefs.remove('showroomId');
    await prefs.remove('isLoggedIn');
    await prefs.remove('staffId');
    await prefs.clear();

    Navigator.pushNamedAndRemoveUntil(context, '/signIn', (route) => false);
  }

  Future<void> loadStaffInfo() async {
    ShowroomStaffModel? staffData =
          await ShowroomStaffSevices().fetchStaffDetails();

    setState(() {
      staff = staffData;
      staffName = staffData.name;
      staffPhone = staffData.phoneNumber;
    });
  }
}
