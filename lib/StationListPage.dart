import 'package:flutter/material.dart';

class StationListPage extends StatelessWidget {
  final bool isDeparture;
  final String? excludedStation;

  const StationListPage({
    super.key,
    required this.isDeparture,
    this.excludedStation,
  });

  static const List<String> stations = [
    '수서',
    '동탄',
    '평택지제',
    '천안아산',
    '오송',
    '대전',
    '김천구미',
    '동대구',
    '경주',
    '울산',
    '부산',
  ];

  @override
  Widget build(BuildContext context) {
    final filteredStations = excludedStation == null
        ? stations
        : stations.where((station) => station != excludedStation).toList();

    final isLight = Theme.of(context).brightness == Brightness.light;

    return Scaffold(
      backgroundColor:
          isLight ? Colors.white : const Color.fromARGB(255, 7, 7, 7),
      appBar: AppBar(
        backgroundColor:
            isLight ? Colors.white : const Color.fromARGB(255, 7, 7, 7),
        foregroundColor: isLight ? Colors.black : Colors.white,
        elevation: 0,
        title: Text(isDeparture ? '출발역 선택' : '도착역 선택'),
      ),
      body: ListView.builder(
        itemCount: filteredStations.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              filteredStations[index],
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.pop(context, filteredStations[index]);
            },
          );
        },
      ),
    );
  }
}
