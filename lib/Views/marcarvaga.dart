import 'package:flutter/material.dart';

void main() => runApp(const ParkWiseApp());

class ParkWiseApp extends StatelessWidget {
  const ParkWiseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MarkSlotScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MarkSlotScreen extends StatelessWidget {
  final List<String> days = ['seg', 'Terc', 'Quar', 'Quin', 'Sext', 'Sab', 'Dom'];
  final List<String> hours = ['11:00', '7:30', '8:00'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu, color: Colors.black),
        title: const Text(
          'ParkWise',
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.notifications_none, color: Colors.black),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Marcar Vaga',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.calendar_today_outlined, size: 18),
                SizedBox(width: 8),
                Icon(Icons.local_parking_outlined, size: 20),
              ],
            ),
            const SizedBox(height: 16),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Abril, 2025',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: days.map((day) {
                return Column(
                  children: [
                    Text(day, style: const TextStyle(fontWeight: FontWeight.w500)),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: day == 'Quar'
                          ? BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(8),
                      )
                          : null,
                      child: const Text('11'),
                    ),
                  ],
                );
              }).toList(),
            ),
            const Divider(height: 32),
            ...hours.map((hour) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(hour, style: const TextStyle(fontSize: 18)),
              ),
            )),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  onPressed: () {},
                  child: const Icon(Icons.add),
                  backgroundColor: Colors.blue,
                  mini: true,
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              child: const Text(
                'Gerar Vaga',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
