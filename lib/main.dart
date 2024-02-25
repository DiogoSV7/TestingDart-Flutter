import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Barriga Tanquinho Experiment',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 225, 5, 5)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Barriguinha Tanquinho'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    SearchPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: _pages[_currentIndex],
      ),
      // Add Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: Colors.red,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 700,
        height: 200,
        color: Colors.grey,
        padding: EdgeInsets.all(16),
        child: Text('Criar plano de treino personalizado'),
      ),
    );
  }
}

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Search Page'),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _name = 'John Doe';
  String _address = '123 Main St, City, Country';
  String _age = '30 years';
  String _weight = '70 kg';
  String _height = '180 cm';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(
                    'https://via.placeholder.com/150'), // Placeholder image
              ),
            ),
            Text(
              _name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildDetailRow(context, 'Address', _address),
            _buildDetailRow(context, 'Age', _age),
            _buildDetailRow(context, 'Weight', _weight),
            _buildDetailRow(context, 'Height', _height),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditProfilePage(
                            name: _name,
                            address: _address,
                            age: _age,
                            weight: _weight,
                            height: _height,
                            onSave: _updateProfile,
                          )),
                );
              },
              child: const Text('Edit Profile'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 18),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  void _updateProfile(String newName, String newAddress, String newAge,
      String newWeight, String newHeight) {
    setState(() {
      _name = newName;
      _address = newAddress;
      _age = newAge;
      _weight = newWeight;
      _height = newHeight;
    });
  }
}

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({
    Key? key,
    required this.name,
    required this.address,
    required this.age,
    required this.weight,
    required this.height,
    required this.onSave,
  }) : super(key: key);

  final String name;
  final String address;
  final String age;
  final String weight;
  final String height;
  final Function(String, String, String, String, String) onSave;

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _addressController;
  late TextEditingController _ageController;
  late TextEditingController _weightController;
  late TextEditingController _heightController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _addressController = TextEditingController(text: widget.address);
    _ageController = TextEditingController(text: widget.age);
    _weightController = TextEditingController(text: widget.weight);
    _heightController = TextEditingController(text: widget.height);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _ageController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextFormField(
              controller: _addressController,
              decoration: const InputDecoration(labelText: 'Address'),
            ),
            TextFormField(
              controller: _ageController,
              decoration: const InputDecoration(labelText: 'Age'),
            ),
            TextFormField(
              controller: _weightController,
              decoration: const InputDecoration(labelText: 'Weight'),
            ),
            TextFormField(
              controller: _heightController,
              decoration: const InputDecoration(labelText: 'Height'),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Save changes logic here
                  widget.onSave(
                    _nameController.text,
                    _addressController.text,
                    _ageController.text,
                    _weightController.text,
                    _heightController.text,
                  );
                  Navigator.pop(context);
                },
                child: const Text('Save Changes'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
