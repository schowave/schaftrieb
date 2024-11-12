import 'package:flutter/material.dart';
import 'package:flutter_image_map/flutter_image_map.dart';
import '../image_map_data.dart' show regions;

class PropertyMap extends StatelessWidget {
  final Function(String) onSelectProperty;

  const PropertyMap({Key? key, required this.onSelectProperty}) : super(key: key);

  void _onImageTap(TapDownDetails details, BoxConstraints constraints, BuildContext context) {
    final RenderBox box = context.findRenderObject() as RenderBox;
    final Offset localPosition = box.globalToLocal(details.globalPosition);
    print('Tap detected at: $localPosition');

    final double relativeX = localPosition.dx / constraints.maxWidth;
    final double relativeY = localPosition.dy / constraints.maxHeight;
    print('Relative position: ($relativeX, $relativeY)');

    for (var region in regions) {
      if (region.path.contains(Offset(relativeX * 800, relativeY * 800))) {
        print('Region detected: ${region.title}');
        onSelectProperty(region.title ?? '');
        return;
      }
    }
    print('No region detected');
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1200,
      height: 1000,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return GestureDetector(
            onTapDown: (details) => _onImageTap(details, constraints, context),
            child: Stack(
              children: [
                Image.asset('lib/umlegungsplan.png', fit: BoxFit.contain),
                ImageMap(
                  image: Image.asset('lib/umlegungsplan.png', fit: BoxFit.contain),
                  regions: regions,
                  onTap: (region) {
                    if (region.title != null) {
                      onSelectProperty(region.title!);
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
