import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rsa_showroom/controllers/booking_provider.dart';
import 'package:rsa_showroom/core/utils/base_scafold.dart';
import 'package:rsa_showroom/views/bookings_card.dart';
import 'package:rsa_showroom/views/widgets/custom_appbar.dart';
import 'package:rsa_showroom/views/widgets/search_bar.dart';

class OnGoing extends StatefulWidget {
  const OnGoing({super.key});

  @override
  OnGoingState createState() => OnGoingState();
}

class OnGoingState extends State<OnGoing> {
  @override
  void initState() {
    super.initState();
    // Provider.of<BookingListProvider>(context, listen: false).fetchBookings(reset: true);
    WidgetsBinding.instance.addPostFrameCallback((_) {
    Provider.of<BookingListProvider>(context, listen: false)
        .fetchBookings(reset: true);
  });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          elevation: 0,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: customHeader('ONGOING', context)),
                // kHeight10,
                SearchBarWidget(),
                Expanded(
                  child: Consumer<BookingListProvider>(
                    builder: (context, bookingListProvider, _) {
                      if (bookingListProvider.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (bookingListProvider.errorMessage != null) {
                        return Center(
                            child: Text(
                                'Error: ${bookingListProvider.errorMessage!}'));
                      }

                      final newBookings = bookingListProvider.bookings
                          .where((booking) =>
                              //  booking.status == 'called to customer' ||
                              booking.status == 'Booking Added')
                          .toList()
                        ..sort((a, b) => DateTime.parse(b.updatedAt)
                            .compareTo(DateTime.parse(a.updatedAt)));

                      if (newBookings.isEmpty) {
                        return const Center(child: Text('No new bookings.'));
                      }

                      return RefreshIndicator(
                        onRefresh: () async {
                          await bookingListProvider.fetchBookings(reset: true);
                        },
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                itemCount: newBookings.length +
                                    (bookingListProvider.hasMore ? 1 : 0),
                                itemBuilder: (context, index) {
                                  if (index == newBookings.length) {
                                    return bookingListProvider.isLoadingMore
                                        ? const Padding(
                                            padding: EdgeInsets.all(16.0),
                                            child: Center(
                                                child:
                                                    CircularProgressIndicator()),
                                          )
                                        : TextButton(
                                            onPressed: () {
                                              bookingListProvider
                                                  .loadMoreBookings();
                                            },
                                            child: const Text("Load More"),
                                          );
                                  }

                                  final booking = newBookings[index];
                                  return BookingCard(bookings: booking);
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
