import 'package:flutter/material.dart';
import 'package:rezerv/const/colors.dart';
import 'package:rezerv/const/styles.dart';
import 'package:rezerv/screens/otherscreens/booking.dart';

class HotelDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                'assets/images/hotelimage.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              // Hotel rating
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star, color: Colors.yellow),
                    Text('4.5', style: secondaryTextStyle),
                  ],
                ),
              ),
              // Hotel Name
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'The Epitome',
                  style: mainTextStyle,
                ),
              ),
              // Hotel description
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed non risus. Suspendisse lectus tortor, dignissim sit amet, adipiscing nec, ultricies sed, dolor. Cras elementum ultrices diam. Maecenas ligula massa, varius a, semper congue, euismod non, mi. Proin porttitor.',
                  style: regularTextStyle,
                ),
              ),
              // Price per night
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Price per night: \$100',
                  style: secondaryTextStyle,
                ),
              ),
            ]),
          ),
        ],
      ),
      // Book Hotel button at the bottom
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
                      builder: (context) => BookingPage(),
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

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
