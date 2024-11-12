import 'package:flutter/material.dart';
import 'package:flutter_image_map/flutter_image_map.dart';
import 'image_map_data.dart' show regions;

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
  final Map<String, String> _propertyOwners = {};

  void _updateName(String name) {
    setState(() {
      _name = name;
    });
  }

  void _selectProperty(String property) {
    print('_selectProperty called with: $property'); // More detailed debug print
    setState(() {
      _selectedProperty = property;
    });
  }

  void _onImageTap(TapDownDetails details, BoxConstraints constraints) {
    final RenderBox box = context.findRenderObject() as RenderBox;
    final Offset localPosition = box.globalToLocal(details.globalPosition);
    print('Tap detected at: $localPosition'); // Print tap coordinates

    // Calculate relative position within the image
    final double relativeX = localPosition.dx / constraints.maxWidth;
    final double relativeY = localPosition.dy / constraints.maxHeight;
    print('Relative position: ($relativeX, $relativeY)');

    // Check which region was tapped
    for (var region in regions) {
      if (region.path.contains(Offset(relativeX * 800, relativeY * 800))) {
        print('Region detected: ${region.title}');
        _selectProperty(region.title ?? '');
        return;
      }
    }
    print('No region detected');
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
                width: 1200,
                height: 1000,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return GestureDetector(
                      onTapDown: (details) => _onImageTap(details, constraints),
                      child: Stack(
                        children: [
                          Image.asset('lib/umlegungsplan.png', fit: BoxFit.contain),
                          ImageMap(
                            image: Image.asset('lib/umlegungsplan.png', fit: BoxFit.contain),
                            regions: regions,
                            onTap: (region) {
                              if (region.title != null) {
                                _selectProperty(region.title!);
                              }
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Selected Property: ${_selectedProperty.isNotEmpty ? _selectedProperty : "None"}',
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
