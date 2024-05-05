import 'package:flutter/material.dart';
import 'package:rezerv/components/hotelcard.dart';
import 'package:rezerv/const/colors.dart';
import 'package:rezerv/const/styles.dart';
import 'package:rezerv/models/HotelModel.dart';
import 'package:rezerv/screens/otherscreens/hoteldetails.dart';
import 'package:rezerv/services/hotel.dart';

class FilterHotelsPage extends StatefulWidget {
  @override
  _FilterHotelsPageState createState() => _FilterHotelsPageState();
}

class _FilterHotelsPageState extends State<FilterHotelsPage> {
  final HotelServices _hotelServices = HotelServices();
  List<HotelModel> _hotels = [];
  bool _isLoading = true;
  String? _selectedLocation;
  double _minPrice = 0;
  double _maxPrice = 1000;
  String _selectedSorting = 'Ascending';

  List<String> _locations = [];

  List<HotelModel> _filteredHotels = [];

  Future<void> _fetchHotels() async {
    setState(() {
      _isLoading = true;
    });
    try {
      List<HotelModel> hotels = await _hotelServices.getAllHotels();
      setState(() {
        _hotels = hotels;
        _locations = _getLocations();
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching hotels: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchHotels();
    _filteredHotels = List.from(_hotels);
  }

  void _applyFilters() {
    setState(() {
      _filteredHotels = _hotels.where((hotel) {
        final double hotelPrice = hotel.pricePerNight;
        final String hotelLocation = hotel.location;
        return (hotelPrice >= _minPrice &&
            hotelPrice <= _maxPrice &&
            (_selectedLocation == null || hotelLocation == _selectedLocation));
      }).toList();

      if (_selectedSorting == 'Ascending') {
        _filteredHotels
            .sort((a, b) => a.pricePerNight.compareTo(b.pricePerNight));
      } else {
        _filteredHotels
            .sort((a, b) => b.pricePerNight.compareTo(a.pricePerNight));
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
              height: 60,
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
                    borderRadius: BorderRadius.circular(100),
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
                    height: 50,
                    child: Container(
                      alignment: Alignment.center,
                      child: TextFormField(
                        decoration: filterFormInputDecoration.copyWith(
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
                    height: 50,
                    child: Container(
                      alignment: Alignment.center,
                      child: TextFormField(
                        decoration: filterFormInputDecoration.copyWith(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16.0),
                          hintText: 'Max Price',
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
              height: 60,
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
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                items: ['Ascending', 'Descending'].map((sortOption) {
                  return DropdownMenuItem<String>(
                    value: sortOption,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        sortOption,
                        textAlign: TextAlign.center,
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              HotelDetailsPage(hotelId: hotel.id),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: HotelCard(
                        imageUrl: hotel.imageUrl,
                        rating: hotel.rating,
                        hotelName: hotel.name,
                        price: hotel.pricePerNight,
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

  List<String> _getLocations() {
    Set<String> locationsSet = Set();
    for (var hotel in _hotels) {
      locationsSet.add(hotel.location);
    }
    return locationsSet.toList();
  }
}
