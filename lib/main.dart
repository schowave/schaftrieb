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
        ..moveTo(317, 640)..lineTo(356, 679)..lineTo(459, 683)..lineTo(425, 804)
        ..lineTo(407, 813)..lineTo(387, 808)..lineTo(310, 767)..lineTo(288, 708)
        ..lineTo(269, 690)..close(),
      color: Colors.red.withOpacity(0.3),
      title: '11522',
    ),
    ImageMapRegion(
      shape: ImageMapShape.poly,
      path: Path()
        ..moveTo(319, 639)..lineTo(358, 676)..lineTo(462, 683)..lineTo(470, 626)
        ..lineTo(380, 620)..lineTo(355, 600)..close(),
      color: Colors.green.withOpacity(0.3),
      title: '11521',
    ),
    ImageMapRegion(
      shape: ImageMapShape.poly,
      path: Path()
        ..moveTo(378, 573)..lineTo(477, 580)..lineTo(469, 625)..lineTo(378, 621)
        ..lineTo(356, 599)..close(),
      color: Colors.blue.withOpacity(0.3),
      title: '11520',
    ),
    ImageMapRegion(
      shape: ImageMapShape.poly,
      path: Path()
        ..moveTo(383, 542)..lineTo(480, 548)..lineTo(477, 578)..lineTo(377, 572)
        ..close(),
      color: Colors.yellow.withOpacity(0.3),
      title: '11519',
    ),
    ImageMapRegion(
      shape: ImageMapShape.poly,
      path: Path()
        ..moveTo(384, 510)..lineTo(484, 517)..lineTo(481, 548)..lineTo(384, 542)
        ..close(),
      color: Colors.purple.withOpacity(0.3),
      title: '11518',
    ),
    ImageMapRegion(
      shape: ImageMapShape.poly,
      path: Path()
        ..moveTo(386, 502)..lineTo(389, 447)..lineTo(491, 454)..lineTo(485, 507)
        ..close(),
      color: Colors.orange.withOpacity(0.3),
      title: '11517',
    ),
    ImageMapRegion(
      shape: ImageMapShape.poly,
      path: Path()
        ..moveTo(389, 446)..lineTo(390, 415)..lineTo(496, 422)..lineTo(491, 453)
        ..close(),
      color: Colors.pink.withOpacity(0.3),
      title: '11516',
    ),
    ImageMapRegion(
      shape: ImageMapShape.poly,
      path: Path()
        ..moveTo(391, 414)..lineTo(393, 383)..lineTo(497, 389)..lineTo(494, 420)
        ..close(),
      color: Colors.teal.withOpacity(0.3),
      title: '11515',
    ),
    ImageMapRegion(
      shape: ImageMapShape.poly,
      path: Path()
        ..moveTo(392, 382)..lineTo(397, 303)..lineTo(515, 309)..lineTo(499, 387)
        ..close(),
      color: Colors.indigo.withOpacity(0.3),
      title: '11514',
    ),
    ImageMapRegion(
      shape: ImageMapShape.poly,
      path: Path()
        ..moveTo(401, 217)..lineTo(414, 215)..lineTo(521, 221)..lineTo(530, 230)
        ..lineTo(517, 310)..lineTo(397, 300)..close(),
      color: Colors.lime.withOpacity(0.3),
      title: '11513',
    ),
    // Add more regions here...
  ];

  // Add these additional regions to the _regions list
  ..addAll([
    ImageMapRegion(
      shape: ImageMapShape.poly,
      path: Path()
        ..moveTo(250, 672)..lineTo(349, 571)..lineTo(123, 558)..lineTo(130, 573)
        ..lineTo(129, 580)..close(),
      color: Colors.cyan.withOpacity(0.3),
      title: '11511',
    ),
    ImageMapRegion(
      shape: ImageMapShape.poly,
      path: Path()
        ..moveTo(350, 571)..lineTo(357, 550)..lineTo(359, 514)..lineTo(354, 498)
        ..lineTo(343, 493)..lineTo(303, 493)..lineTo(298, 567)..close(),
      color: Colors.amber.withOpacity(0.3),
      title: '11510',
    ),
    // Continue adding more regions...
  ]);

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
