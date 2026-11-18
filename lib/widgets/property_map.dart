// Stays on the SDK Material library (deprecated since Flutter 3.47) until
// flutter_image_map moves to material_ui: mixing both breaks its InkWell/Theme.
// ignore: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_image_map/flutter_image_map.dart';
import '../image_map_data.dart' show regions;

class PropertyMap extends StatelessWidget {
  final Function(String) onSelectProperty;

  const PropertyMap({super.key, required this.onSelectProperty});

  void _onImageTap(TapDownDetails details, BoxConstraints constraints,
      BuildContext context) {
    final RenderBox box = context.findRenderObject() as RenderBox;
    final Offset localPosition = box.globalToLocal(details.globalPosition);
    debugPrint('Tap detected at: $localPosition');

    final double relativeX = localPosition.dx / constraints.maxWidth;
    final double relativeY = localPosition.dy / constraints.maxHeight;
    debugPrint('Relative position: ($relativeX, $relativeY)');

    for (var region in regions) {
      if (region.path.contains(Offset(relativeX * 800, relativeY * 800))) {
        debugPrint('Region detected: ${region.title}');
        onSelectProperty(region.title ?? '');
        return;
      }
    }
    debugPrint('No region detected');
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
                  image:
                      Image.asset('lib/umlegungsplan.png', fit: BoxFit.contain),
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
