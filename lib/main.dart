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
    for (var region in _regions) {
      if (region.path.contains(Offset(relativeX * 800, relativeY * 800))) {
        print('Region detected: ${region.title}');
        _selectProperty(region.title ?? '');
        return;
      }
    }
    print('No region detected');
  }

  final List<ImageMapRegion> _regions = [
    ImageMapRegion(
      shape: ImageMapShape.poly,
      path: Path()
        ..moveTo(316, 642)
        ..lineTo(355, 681)
        ..lineTo(453, 686)
        ..lineTo(467, 632)
        ..lineTo(374, 622)
        ..lineTo(352, 603)
        ..close(),
      color: Colors.red.withOpacity(0.3),
      title: '11521',
    ),
    ImageMapRegion(
      shape: ImageMapShape.poly,
      path: Path()
        ..moveTo(375, 577)
        ..lineTo(475, 582)
        ..lineTo(466, 629)
        ..lineTo(376, 621)
        ..lineTo(353, 600)
        ..close(),
      color: Colors.green.withOpacity(0.3),
      title: '11520',
    ),
    ImageMapRegion(
      shape: ImageMapShape.poly,
      path: Path()
        ..moveTo(382, 545)
        ..lineTo(374, 576)
        ..lineTo(474, 579)
        ..lineTo(478, 551)
        ..close(),
      color: Colors.blue.withOpacity(0.3),
      title: '11519',
    ),
    ImageMapRegion(
      shape: ImageMapShape.poly,
      path: Path()
        ..moveTo(383, 515)
        ..lineTo(481, 521)
        ..lineTo(477, 550)
        ..lineTo(380, 545)
        ..close(),
      color: Colors.yellow.withOpacity(0.3),
      title: '11518',
    ),
    ImageMapRegion(
      shape: ImageMapShape.poly,
      path: Path()
        ..moveTo(383, 505)
        ..lineTo(386, 450)
        ..lineTo(488, 457)
        ..lineTo(481, 512)
        ..close(),
      color: Colors.purple.withOpacity(0.3),
      title: '11517',
    ),
    ImageMapRegion(
      shape: ImageMapShape.poly,
      path: Path()
        ..moveTo(386, 449)
        ..lineTo(390, 394)
        ..lineTo(494, 401)
        ..lineTo(488, 456)
        ..close(),
      color: Colors.orange.withOpacity(0.3),
      title: '11516',
    ),
    ImageMapRegion(
      shape: ImageMapShape.poly,
      path: Path()
        ..moveTo(390, 393)
        ..lineTo(394, 338)
        ..lineTo(500, 345)
        ..lineTo(494, 400)
        ..close(),
      color: Colors.pink.withOpacity(0.3),
      title: '11515',
    ),
    ImageMapRegion(
      shape: ImageMapShape.poly,
      path: Path()
        ..moveTo(394, 337)
        ..lineTo(398, 282)
        ..lineTo(506, 289)
        ..lineTo(500, 344)
        ..close(),
      color: Colors.teal.withOpacity(0.3),
      title: '11514',
    ),
    ImageMapRegion(
      shape: ImageMapShape.poly,
      path: Path()
        ..moveTo(398, 281)
        ..lineTo(402, 226)
        ..lineTo(512, 233)
        ..lineTo(506, 288)
        ..close(),
      color: Colors.indigo.withOpacity(0.3),
      title: '11513',
    ),
    ImageMapRegion(
      shape: ImageMapShape.poly,
      path: Path()
        ..moveTo(402, 225)
        ..lineTo(406, 170)
        ..lineTo(518, 177)
        ..lineTo(512, 232)
        ..close(),
      color: Colors.lime.withOpacity(0.3),
      title: '11512',
    ),
  ];

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
                          Image.asset('lib/new_image_name.png', fit: BoxFit.contain),
                          ImageMap(
                            image: Image.asset('lib/new_image_name.png', fit: BoxFit.contain),
                            regions: _regions,
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
