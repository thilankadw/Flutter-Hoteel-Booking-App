import 'package:flutter/material.dart';
import 'package:rezerv/const/colors.dart';
import 'package:rezerv/const/styles.dart';

class HotelCard extends StatelessWidget {
  final String imageUrl;
  final double rating;
  final String hotelName;
  final double price;

  const HotelCard({
    Key? key,
    required this.imageUrl,
    required this.rating,
    required this.hotelName,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 330,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        surfaceTintColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                child: Image.asset(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
                // child: Image.network(
                //   imageUrl,
                //   fit: BoxFit.cover,
                // ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.star, color: mainYellow),
                        const SizedBox(width: 4),
                        Text(
                          '$rating',
                          style: secondaryTextStyle.copyWith(fontSize: 16),
                        ),
                      ],
                    ),
                    Text(
                      '\$$price/night',
                      style: secondaryTextStyle.copyWith(fontSize: 16),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SizedBox(
                  height: 50, // Set your desired height here
                  child: Text(
                    hotelName,
                    style: secondaryTextStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Example usage:
// HotelCard(
//   imageUrl: 'https://example.com/hotel_image.jpg',
//   rating: 4.5,
//   hotelName: 'Example Hotel',
//   price: 120.0,
// )
