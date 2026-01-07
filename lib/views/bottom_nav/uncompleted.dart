
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rsa_showroom/core/utils/base_scafold.dart';


class UnCompletedBookings extends StatefulWidget {
  const UnCompletedBookings({super.key});

  @override
  UnCompletedBookingsState createState() => UnCompletedBookingsState();
}

class UnCompletedBookingsState extends State<UnCompletedBookings> {
  String? driverId;

  @override
  void initState() {
    super.initState();
  //  _loadDriverIdAndFetchBookings();
  }

  // Future<void> _loadDriverIdAndFetchBookings() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? id = prefs.getString('driverId');
  //   if (id != null) {
  //     setState(() {
  //       driverId = id;
  //     });
  //     // Fetch initial bookings (first 10)
  //     Provider.of<BookingListProvider>(context, listen: false).fetchBookings();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "UnCompleted Jobs",
            style: GoogleFonts.poppins(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          // leading: IconButton(onPressed: (){
      
          //   Navigator.pushReplacementNamed(context, '/home');
          // }, icon: Icon(Icons.arrow_back))
        ),
        body: SafeArea(
          child: Center(
            child: Text('Uncompleted'),
          ),
        ),
      ),
    );
  }
}
