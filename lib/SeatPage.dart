import 'package:flutter/material.dart';

class SeatPage extends StatefulWidget {
  final String departure;
  final String arrival;

  const SeatPage({
    super.key,
    required this.departure,
    required this.arrival,
  });

  @override
  State<SeatPage> createState() => _SeatPageState();
}

class _SeatPageState extends State<SeatPage> {
  final ScrollController _scrollController = ScrollController();
  String? selectedSeat;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF4F8),
      appBar: AppBar(
        title: const Text('좌석 선택'),
        backgroundColor: const Color(0xFFFFF4F8),
        centerTitle: true,
        elevation: 0,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          // 출발역 → 도착역
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 80),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(widget.departure,
                        style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple)),
                  ),
                ),
              ),
              const Icon(Icons.arrow_circle_right_outlined, size: 30),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 80),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(widget.arrival,
                        style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple)),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // 좌석 상태 설명
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegendBox('선택됨', Colors.purple),
              const SizedBox(width: 20),
              _buildLegendBox('선택안됨', Colors.grey[300]!),
            ],
          ),
          const SizedBox(height: 12),
          // 좌석 + 스크롤 + 고정 버튼
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: 21, // 라벨 + 1~20번 좌석
              padding: const EdgeInsets.only(top: 10, bottom: 140),
              itemBuilder: (context, index) {
                if (index == 0) {
                  // ABCD 라벨
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      SizedBox(
                          width: 50,
                          height: 24,
                          child: Center(
                              child:
                                  Text('A', style: TextStyle(fontSize: 18)))),
                      SizedBox(width: 6),
                      SizedBox(
                          width: 50,
                          height: 24,
                          child: Center(
                              child:
                                  Text('B', style: TextStyle(fontSize: 18)))),
                      SizedBox(width: 70),
                      SizedBox(
                          width: 50,
                          height: 24,
                          child: Center(
                              child:
                                  Text('C', style: TextStyle(fontSize: 18)))),
                      SizedBox(width: 10),
                      SizedBox(
                          width: 50,
                          height: 24,
                          child: Center(
                              child:
                                  Text('D', style: TextStyle(fontSize: 18)))),
                    ],
                  );
                } else {
                  return _buildSeatRow(index);
                }
              },
            ),
          ),
          SafeArea(
            minimum: const EdgeInsets.only(bottom: 20, left: 16, right: 16),
            child: SizedBox(
              height: 60,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: selectedSeat == null
                    ? () {}
                    : () => _showConfirmDialog(context, selectedSeat!),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                  elevation: 8,
                  shadowColor: Colors.black45,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  textStyle: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                child: const Text('예매 하기'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendBox(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(6)),
        ),
        const SizedBox(width: 6),
        Text(label),
      ],
    );
  }

  Widget _buildSeat(String seatId) {
    final bool isSelected = selectedSeat == seatId;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedSeat = seatId;
        });
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: isSelected ? Colors.purple : Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget _buildSeatRow(int index) {
    int row = index;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildSeat('$row-A'),
          const SizedBox(width: 6),
          _buildSeat('$row-B'),
          const SizedBox(width: 8),
          SizedBox(
            width: 50,
            height: 50,
            child: Center(
              child: Text('$row', style: const TextStyle(fontSize: 18)),
            ),
          ),
          const SizedBox(width: 8),
          _buildSeat('$row-C'),
          const SizedBox(width: 6),
          _buildSeat('$row-D'),
        ],
      ),
    );
  }

  void _showConfirmDialog(BuildContext context, String seatId) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Center(
        child: Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 75),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              const Text('예매 하시겠습니까?',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text('좌석 : $seatId'),
              const SizedBox(height: 20),
              const Divider(height: 1),
              SizedBox(
                height: 48,
                child: Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('취소',
                            style: TextStyle(color: Colors.red)),
                      ),
                    ),
                    Container(
                        width: 1, height: double.infinity, color: Colors.grey),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: const Text('확인',
                            style: TextStyle(color: Colors.blue)),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
