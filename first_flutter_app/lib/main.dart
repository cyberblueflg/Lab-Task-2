import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const StudentInfoApp());
}

class StudentInfoApp extends StatelessWidget {
  const StudentInfoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CSS3344 Lab 02',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const StudentProfileScreen(),
    );
  }
}

class StudentProfileScreen extends StatelessWidget {
  const StudentProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CSS3344 Mobile App Dev - Lab 02'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return orientation == Orientation.portrait
              ? _buildPortraitView()
              : _buildLandscapeView();
        },
      ),
    );
  }

  Widget _buildPortraitView() {
    return ListView(
      children: const [
        StudentDetailsSection(),
        TitleSection(
          name: 'Bukit Aup Jubilee Park',
          location: 'Jalan Inai, 96000 Sibu, Sarawak, Malaysia',
          starCount: 41,
        ),
        ImageSection(imagePath: 'assets/images/place.jpg'),
        PickersSection(),
      ],
    );
  }

  Widget _buildLandscapeView() {
    return Row(
      children: [
        Expanded(
          child: ListView(
            children: const [
              StudentDetailsSection(),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            children: const [
              TitleSection(
                name: 'Bukit Aup Jubilee Park',
                location: 'Jalan Inai, 96000 Sibu, Sarawak, Malaysia',
                starCount: 41,
              ),
              ImageSection(imagePath: 'assets/images/place.jpg'),
              PickersSection(),
            ],
          ),
        ),
      ],
    );
  }
}

class StudentDetailsSection extends StatelessWidget {
  const StudentDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.indigo,
      elevation: 4,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipOval(
              child: Image.asset(
                'assets/images/profile.png',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                const CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 50, color: Colors.indigo),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // TODO: Replace with your Full Name
            const Text(
              'Gordon Wong Kee Zhen',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            // TODO: Replace with your Student ID
            const Text(
              'Student ID: BCS24090044',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
            const Divider(height: 32, thickness: 1, color: Colors.white54),
            const Text(
              'Personal Life Goal / Quote:',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            // TODO: Replace with your goal/quote
            const Text(
              '"To be able to live life in a relaxed and carefree way"',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontStyle: FontStyle.italic,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TitleSection extends StatelessWidget {
  final String name;
  final String location;
  final int starCount;

  const TitleSection({
    super.key,
    required this.name,
    required this.location,
    required this.starCount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  location,
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          Icon(Icons.star, color: Colors.red[500]),
          const SizedBox(width: 4),
          Text('$starCount'),
        ],
      ),
    );
  }
}

class ImageSection extends StatelessWidget {
  final String imagePath;

  const ImageSection({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          imagePath,
          height: 220,
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            height: 220,
            color: Colors.grey[300],
            alignment: Alignment.center,
            child: const Text('Image not found'),
          ),
        ),
      ),
    );
  }
}

class PickersSection extends StatefulWidget {
  const PickersSection({super.key});

  @override
  State<PickersSection> createState() => _PickersSectionState();
}

class _PickersSectionState extends State<PickersSection> {
  final List<String> _houses = [
    'Walking',
    'Jogging',
    'Picnic',
    'Cycling',
  ];

  DateTime _selectedDate = DateTime.now();
  String _selectedHouse = 'Walking';

  String get _dateText => _selectedDate.toString().split(' ')[0];

  Future<void> _selectMaterialDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _showCupertinoDatePicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (popupContext) => Container(
        height: 280,
        color: CupertinoColors.systemBackground.resolveFrom(popupContext),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: CupertinoButton(
                onPressed: () => Navigator.of(popupContext).pop(),
                child: const Text('Done'),
              ),
            ),
            Expanded(
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: _selectedDate,
                onDateTimeChanged: (DateTime newDate) {
                  setState(() => _selectedDate = newDate);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCupertinoHousePicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (popupContext) => Container(
        height: 240,
        color: CupertinoColors.systemBackground.resolveFrom(popupContext),
        child: DefaultTextStyle(
          style: TextStyle(
            fontSize: 20,
            color: CupertinoColors.label.resolveFrom(popupContext),
            decoration: TextDecoration.none,
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: CupertinoButton(
                  onPressed: () => Navigator.of(popupContext).pop(),
                  child: const Text('Done'),
                ),
              ),
              Expanded(
                child: CupertinoPicker(
                  scrollController: FixedExtentScrollController(
                    initialItem: _houses.indexOf(_selectedHouse),
                  ),
                  itemExtent: 32,
                  onSelectedItemChanged: (int index) {
                    setState(() => _selectedHouse = _houses[index]);
                  },
                  children:
                  _houses.map((h) => Center(child: Text(h))).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Interactive Pickers (Lab 2.2)',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const Divider(height: 24),
            Text(
              'Selected Date: $_dateText',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Selected Activity: $_selectedHouse',
              style: const TextStyle(fontSize: 12, color: Colors.indigo),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () => _selectMaterialDate(context),
              icon: const Icon(Icons.calendar_today, size: 16),
              label: const Text('Material Date Picker'),
            ),
            OutlinedButton.icon(
              onPressed: () => _showCupertinoDatePicker(context),
              icon: const Icon(Icons.date_range, size: 16),
              label: const Text('Cupertino Date Picker (Modal Sheet)'),
            ),
            Row(
              children: [
                const Text('Material Dropdown: '),
                DropdownButton<String>(
                  value: _selectedHouse,
                  items: _houses.map((String house) {
                    return DropdownMenuItem<String>(
                      value: house,
                      child: Text(house),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() => _selectedHouse = newValue);
                    }
                  },
                ),
              ],
            ),
            OutlinedButton.icon(
              onPressed: () => _showCupertinoHousePicker(context),
              icon: const Icon(Icons.tune, size: 16),
              label: const Text('Cupertino House Wheel Picker'),
            ),
          ],
        ),
      ),
    );
  }
}