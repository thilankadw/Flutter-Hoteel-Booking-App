import 'package:flutter/material.dart';
import 'package:rezerv/components/hotelcard.dart';
import 'package:rezerv/components/vehiclecadr.dart';
import 'package:rezerv/models/HotelModel.dart';
import 'package:rezerv/models/VehicleModel.dart';
import 'package:rezerv/screens/otherscreens/filter.dart';
import 'package:rezerv/screens/otherscreens/hoteldetails.dart';
import 'package:rezerv/const/colors.dart';
import 'package:rezerv/const/styles.dart';
import 'package:rezerv/screens/otherscreens/vehiclebooking.dart';
import 'package:rezerv/services/getvehicles.dart';
import 'package:rezerv/services/hotel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen();

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HotelServices _hotelServices = HotelServices();
  final VehicleServices _vehicleServices = VehicleServices();

  List<HotelModel> _hotels = [];
  bool _isLoading = true;

  List<VehicleModel> _vehicles = [];

  @override
  void initState() {
    super.initState();
    _fetchHotels();
    _fetchVehicles();
  }

  Future<void> _fetchHotels() async {
    setState(() {
      _isLoading = true;
    });

    try {
      List<HotelModel> hotels = await _hotelServices.getAllHotels();
      setState(() {
        _hotels = hotels;
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching hotels: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchVehicles() async {
    setState(() {
      _isLoading = true;
    });

    try {
      List<VehicleModel> vehicles = await _vehicleServices.getAllVehicles();
      setState(() {
        _vehicles = vehicles;
      });
    } catch (e) {
      print('Error fetching hotels: $e');
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Text(
                "REZERV",
                style: mainTextStyle.copyWith(
                    fontSize: 35, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 20),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      10.0,
                    ),
                  ),
                  child: Image.asset(
                    'assets/images/banner_image.png',
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "Hotels",
                style: mainTextStyle,
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 60,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(mainBlue),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FilterHotelsPage(),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.filter_alt,
                        color: white,
                      ),
                      const SizedBox(width: 15),
                      Text(
                        "Filter Hotels",
                        style: btnTextStyle.copyWith(color: white),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 320,
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : _hotels.isEmpty
                        ? const Center(
                            child: Text(
                              'No hotels found',
                              style: secondaryTextStyle,
                            ),
                          )
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _hotels.length,
                            itemBuilder: (BuildContext context, int index) {
                              final hotel = _hotels[index];
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
              const SizedBox(height: 30),
              const Text(
                "Vehicles",
                style: mainTextStyle,
              ),
              Container(
                height: 320,
                child: _vehicles.isEmpty
                    ? const Center(
                        child: Text(
                          'No vehicles found',
                          style: secondaryTextStyle,
                        ),
                      )
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _vehicles.length,
                        itemBuilder: (BuildContext context, int index) {
                          final vehicle = _vehicles[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => VehicleBookingPage(
                                    vehicleId: vehicle.id,
                                    price: vehicle.price,
                                    model: vehicle.model,
                                    vehicleNo: vehicle.vehicleNo,
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: VehicleCard(
                                imageUrl: vehicle.imageUrl,
                                model: vehicle.model,
                                price: vehicle.price,
                              ),
                            ),
                          );
                        },
                      ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
