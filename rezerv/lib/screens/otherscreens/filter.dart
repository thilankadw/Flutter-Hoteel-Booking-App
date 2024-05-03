import 'package:flutter/material.dart';
import 'package:rezerv/components/hotelcard.dart';
import 'package:rezerv/const/colors.dart';
import 'package:rezerv/const/styles.dart';
import 'package:rezerv/screens/otherscreens/hoteldetails.dart';

class FilterHotelsPage extends StatefulWidget {
  @override
  _FilterHotelsPageState createState() => _FilterHotelsPageState();
}

class _FilterHotelsPageState extends State<FilterHotelsPage> {
  String? _selectedLocation;
  double _minPrice = 0;
  double _maxPrice = 1000;
  String _selectedSorting = 'Ascending';

  List<String> _locations = ['Location A', 'Location B', 'Location C'];
  // Sample locations
  List<Map<String, dynamic>> _hotels = [
    {
      'imageUrl': 'assets/images/hotelimage.png',
      'rating': 4.5,
      'hotelName': 'Example Hotel',
      'price': 120.0,
      'location': 'Location A',
    },
    {
      'imageUrl': 'assets/images/hotelimage.png',
      'rating': 4.0,
      'hotelName': 'Hotel B',
      'price': 150.0,
      'location': 'Location B',
    },
    {
      'imageUrl': 'assets/images/hotelimage.png',
      'rating': 4.0,
      'hotelName': 'Hotel D',
      'price': 150.0,
      'location': 'Location B',
    },
    {
      'imageUrl': 'assets/images/hotelimage.png',
      'rating': 3.5,
      'hotelName': 'Hotel C',
      'price': 100.0,
      'location': 'Location C',
    },
  ]; // Sample hotel data

  List<Map<String, dynamic>> _filteredHotels = [];

  @override
  void initState() {
    super.initState();
    _filteredHotels = List.from(_hotels);
  }

  void _applyFilters() {
    setState(() {
      _filteredHotels = _hotels.where((hotel) {
        final double hotelPrice = hotel['price'];
        final String hotelLocation = hotel['location'];
        return (hotelPrice >= _minPrice &&
            hotelPrice <= _maxPrice &&
            (_selectedLocation == null || hotelLocation == _selectedLocation));
      }).toList();

      if (_selectedSorting == 'Ascending') {
        _filteredHotels.sort((a, b) => a['price'].compareTo(b['price']));
      } else {
        _filteredHotels.sort((a, b) => b['price'].compareTo(a['price']));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          style: const ButtonStyle(
            iconSize: MaterialStatePropertyAll(25.0),
            iconColor: MaterialStatePropertyAll(white),
            backgroundColor: MaterialStatePropertyAll(mainBlue),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Filter Hotels',
          style: mainTextStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Filter by Location',
              style: secondaryTextStyle,
            ),
            const SizedBox(height: 5),
            Container(
              height: 60, // Adjust the height here
              child: DropdownButtonFormField<String>(
                value: _selectedLocation,
                onChanged: (value) {
                  setState(() {
                    _selectedLocation = value;
                    _applyFilters();
                  });
                },
                items: ['All', ..._locations].map((location) {
                  return DropdownMenuItem<String>(
                    value: location == 'All' ? null : location,
                    child: Text(location),
                  );
                }).toList(),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        100), // Adjust the border radius as needed
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Filter by Price Range',
              style: secondaryTextStyle,
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50, // Adjust the height here
                    child: Container(
                      alignment: Alignment.center, // Center the text vertically
                      child: TextFormField(
                        decoration: filterFormInputDecoration.copyWith(
                          // Adjust the padding to center the text horizontally
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16.0),
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            _minPrice = double.tryParse(value) ?? 0;
                            _applyFilters();
                          });
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: SizedBox(
                    height: 50, // Adjust the height here
                    child: Container(
                      alignment: Alignment.center, // Center the text vertically
                      child: TextFormField(
                        decoration: filterFormInputDecoration.copyWith(
                          // Adjust the padding to center the text horizontally
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16.0),
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            _maxPrice = double.tryParse(value) ?? 0;
                            _applyFilters();
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Sort by',
              style: secondaryTextStyle,
            ),
            const SizedBox(height: 5),
            Container(
              height: 60, // Adjust the height here
              child: DropdownButtonFormField<String>(
                value: _selectedSorting,
                onChanged: (value) {
                  setState(() {
                    _selectedSorting = value!;
                    _applyFilters();
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        100), // Adjust the border radius as needed
                  ),
                ),
                items: ['Ascending', 'Descending'].map((sortOption) {
                  return DropdownMenuItem<String>(
                    value: sortOption,
                    child: Container(
                      alignment: Alignment.center, // Center the text vertically
                      child: Text(
                        sortOption,
                        textAlign:
                            TextAlign.center, // Center the text horizontally
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: 400,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: _filteredHotels.length,
                itemBuilder: (BuildContext context, int index) {
                  final hotel = _filteredHotels[index];
                  return GestureDetector(
                    onTap: () {
                      // Navigate to HotelDetailsPage when a hotel card is tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HotelDetailsPage(
                              // imageUrl: hotel['imageUrl'],
                              // rating: hotel['rating'],
                              // hotelName: hotel['hotelName'],
                              // price: hotel['price'],
                              ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: HotelCard(
                        imageUrl: hotel['imageUrl'],
                        rating: hotel['rating'],
                        hotelName: hotel['hotelName'],
                        price: hotel['price'],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
