import 'package:flutter/material.dart';
import 'package:flutter_image_map/flutter_image_map.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Property Name App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const PropertyNamePage(title: 'Property Name App'),
    );
  }
}

class PropertyNamePage extends StatefulWidget {
  const PropertyNamePage({super.key, required this.title});

  final String title;

  @override
  State<PropertyNamePage> createState() => _PropertyNamePageState();
}

class _PropertyNamePageState extends State<PropertyNamePage> {
  String _name = '';
  String _selectedProperty = '';
  Map<String, String> _propertyOwners = {};

  void _updateName(String name) {
    setState(() {
      _name = name;
    });
  }

  void _selectProperty(String property) {
    setState(() {
      _selectedProperty = property;
    });
  }

  void _savePropertyOwner() {
    if (_name.isNotEmpty && _selectedProperty.isNotEmpty) {
      setState(() {
        _propertyOwners[_selectedProperty] = _name;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Property owner saved: $_name for $_selectedProperty')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 400,
                height: 400,
                child: ImageMap(
                  image: Image.asset('lib/umlegungsplan.png'),
                  onTap: (region) => _selectProperty(region.title ?? ''),
                  regions: [
                    ImageMapRegion(
                      shape: ImageMapShape.rect,
                      path: Path()
                        ..moveTo(0, 0)
                        ..lineTo(100, 0)
                        ..lineTo(100, 100)
                        ..lineTo(0, 100)
                        ..close(),
                      color: Colors.blue.withOpacity(0.3),
                      title: 'Property 1',
                    ),
                    ImageMapRegion(
                      shape: ImageMapShape.rect,
                      path: Path()
                        ..moveTo(100, 0)
                        ..lineTo(200, 0)
                        ..lineTo(200, 100)
                        ..lineTo(100, 100)
                        ..close(),
                      color: Colors.green.withOpacity(0.3),
                      title: 'Property 2',
                    ),
                    // Add more regions as needed
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Selected Property: $_selectedProperty',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter your name',
                ),
                onChanged: _updateName,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _savePropertyOwner,
                child: const Text('Save Property Owner'),
              ),
              const SizedBox(height: 20),
              Text(
                'Property Owners:',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              for (var entry in _propertyOwners.entries)
                Text('${entry.key}: ${entry.value}'),
            ],
          ),
        ),
      ),
    );
  }
}
