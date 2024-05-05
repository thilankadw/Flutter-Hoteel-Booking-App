import 'package:flutter/material.dart';
import 'package:rezerv/const/colors.dart';
import 'package:rezerv/const/styles.dart';
import 'package:rezerv/models/HotelModel.dart';
import 'package:rezerv/screens/otherscreens/booking.dart';
import 'package:rezerv/services/hotel.dart';

class HotelDetailsPage extends StatelessWidget {
  final String hotelId;

  const HotelDetailsPage({required this.hotelId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<HotelModel?>(
      future: HotelServices().getHotelById(hotelId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Center(child: Text('Hotel not found'));
        } else {
          final hotel = snapshot.data!;

          return Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    style: const ButtonStyle(
                      iconSize: MaterialStatePropertyAll(25.0),
                      iconColor: MaterialStatePropertyAll(white),
                      backgroundColor: MaterialStatePropertyAll(mainBlue),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  expandedHeight: 200,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.asset(
                      hotel.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    // Hotel rating
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.star, color: Colors.yellow),
                          Text(
                            hotel.rating.toString(),
                            style: secondaryTextStyle,
                          ),
                        ],
                      ),
                    ),
                    // Hotel Name
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        hotel.name,
                        style: mainTextStyle,
                      ),
                    ),
                    // Hotel description
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        hotel.description,
                        style: regularTextStyle,
                      ),
                    ),
                    // Price per night
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Price per night: \$${hotel.pricePerNight.toString()}',
                        style: secondaryTextStyle,
                      ),
                    ),
                  ]),
                ),
              ],
            ),
            floatingActionButton: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: FloatingActionButton.extended(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookingPage(
                              hotelId: hotelId,
                              priceperNight: hotel.pricePerNight.toString(),
                              hotelName: hotel.name,
                              location: 'Colombo',
                            ),
                          ),
                        );
                      },
                      label: Text(
                        'Book Hotel',
                        style: btnTextStyle.copyWith(color: white),
                      ),
                      backgroundColor: mainBlue,
                    ),
                  ),
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
        }
      },
    );
  }
}
