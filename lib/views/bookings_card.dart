import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rsa_showroom/controllers/booking_provider.dart';
import 'package:rsa_showroom/core/constants/spacing_constants.dart';
import 'package:rsa_showroom/models/booking_model.dart';

class BookingCard extends StatefulWidget {
  final BookingModel bookings;
  const BookingCard({super.key, required this.bookings});

  @override
  State<BookingCard> createState() => _BookingCardState();
}

class _BookingCardState extends State<BookingCard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //loadDriverInfo();
  }

  @override
  Widget build(BuildContext context) {
    final bookingListProvider = Provider.of<BookingListProvider>(context);
    String timestamp = widget.bookings.createdAt;
    DateTime dateTime = DateTime.parse(timestamp).toLocal();
    String formattedDate =
        DateFormat('MMM dd, yyyy').format(dateTime); // Corrected date format
    String formattedTime = DateFormat('h:mm a').format(dateTime);

    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // File ID & Date/Time Row

            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  formattedDate,
                  style: const TextStyle(color: Colors.grey),
                ),
                kWidth5,
                Text(
                  formattedTime,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            kHeight5,

            Tooltip(
              message: widget.bookings.fileNumber,
              child: Text(
                "File ID : ${widget.bookings.fileNumber}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.red),
              ),
            ),

            kHeight5,
             Tooltip(
              message: widget.bookings.customerName,
              child: Text(
                "CustomerName : ${widget.bookings.customerName}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Tooltip(
              message: widget.bookings.customerVehicleNumber,
              child: Text(
                "Customer Vehicle No : ${widget.bookings.customerVehicleNumber}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            
           
            Tooltip(
              message: widget.bookings.customerName,
              child: Text(
                "Phone Number : ${widget.bookings.mob1}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            kHeight5,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Current status : ${widget.bookings.status}",
                  style: const TextStyle(
                      color: Colors.green, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            
          ],
        ),
      ),
    );
  }
}
