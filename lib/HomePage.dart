import 'package:flutter/material.dart';
import 'StationListPage.dart';
import 'SeatPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? departure;
  String? arrival;

  void _selectStation(bool isDeparture) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StationListPage(
          isDeparture: isDeparture,
          excludedStation: isDeparture ? arrival : departure,
        ),
      ),
    );

    if (result != null && result is String) {
      setState(() {
        if (isDeparture) {
          departure = result;
        } else {
          arrival = result;
        }
      });
    }
  }

  void _goToSeatPage() {
    if (departure != null && arrival != null) {
      print('Navigating to SeatPage: $departure → $arrival');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SeatPage(
            departure: departure!,
            arrival: arrival!,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('출발역과 도착역을 선택해주세요.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text("기차 예매"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xffffff4f8),
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStationColumn(
                      "출발역", departure, () => _selectStation(true)),
                  Container(
                    width: 2,
                    height: 50,
                    color: Colors.grey[400],
                  ),
                  _buildStationColumn(
                      "도착역", arrival, () => _selectStation(false)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: _goToSeatPage,
                child: const Text(
                  '좌석 선택',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStationColumn(String label, String? value, VoidCallback onTap) {
    final isSelected = value != null && value.isNotEmpty;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            value ?? '선택',
            style: TextStyle(
              fontSize: 40,
              color: isSelected ? Colors.black : Colors.grey,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
