import 'dart:ui';

import 'package:flutter/material.dart';

import '../../utils/constants/assets_constants.dart';

class PlantMoreDetailsView extends StatelessWidget {
  const PlantMoreDetailsView({
    super.key,
  });

  static const routeName = '/';

  static const List<String> chipNames = [
    'Indoor',
    'Garden',
    'Office',
    'Pet Friendly',
    'Air Purifier'
  ];

static const List<InfoPillItemData> infoPillItems = [
  InfoPillItemData('Humidity', '64%', Icons.water_drop),
  InfoPillItemData('Height', '1.7m', Icons.height),
  InfoPillItemData('Diameter', '0.6m', Icons.vertical_align_center),
  InfoPillItemData('Sunlight', '5.8k', Icons.sunny),
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(241, 245, 249, 1),
        surfaceTintColor: const Color.fromRGBO(241, 245, 249, 1),
      ),
      floatingActionButton: BottomButton(onPressed: () => ()),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 36, right: 36, bottom: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CoreImageContainer(infoPillItems: infoPillItems),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 18),
              child: Text('Peace Lily Plant', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ),
            Wrap(
              spacing: 14,
              runSpacing: 14,
              children: [
                ...chipNames.map((label) => DescriptiveChipItem(label: label)),
                const Padding(
                  padding: EdgeInsets.only(top: 18),
                  child: Text(
                    'Peace lilies make excellent houseplants for the home or office. These lovely plants not only brighten up a living space, but are also excellent at cleaning the air in the room.',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DescriptiveChipItem extends StatelessWidget {
  const DescriptiveChipItem({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Chip(
        label: Text(
          label,
          style: const TextStyle(fontSize: 18),
        ),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(18))),
        side: const BorderSide(color: Color.fromRGBO(222, 222, 222, 1), width: 0.5),
        backgroundColor: Colors.white,
        padding: const EdgeInsets.all(12),
        
      ),
    );
  }
}

class BottomButton extends StatelessWidget {
  const BottomButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.only(left: 36, right: 36),
      child: SizedBox.expand(
        child: FilledButton(
          onPressed: onPressed,
          style: ButtonStyle(padding: WidgetStateProperty.all<EdgeInsets>(const EdgeInsets.all(14))),
          child: const Text('Add To My Plant', style: TextStyle(fontSize: 24)),
        ),
      ),
    );
  }
}

class CoreImageContainer extends StatelessWidget {
  const CoreImageContainer({
    super.key,
    required this.infoPillItems
    });

final List<InfoPillItemData> infoPillItems;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      transform: Matrix4.translationValues(-36, 0, 0),
      height: 380,
      width: 1000,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(199, 193, 193, 0.3),
            spreadRadius: 0.7,
            blurRadius: 12,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Image container
          Positioned(
            left: -40,
            top: -30,
            child: Image(
              image: AssetImage(Asset.flowers['peaceLily']!),
              width: 320,
            ),
          ),
          // Button overlay container
          Positioned(
            right: -50, // Align to the middle-right
            top: 50, // Adjust this value to position vertically
            child: Container(
              child: Wrap(
                direction: Axis.vertical,
                spacing: 14,
                children: [
                  ...infoPillItems.map((item) => InfoPillItem(item: item))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InfoPillItemData {
  const InfoPillItemData(
    this.label,
    this.descriptiveValue,
    this.icon
  );

  final String label;
  final String descriptiveValue;
  final IconData icon;
}

class InfoPillItem extends StatelessWidget {
  const InfoPillItem({
    super.key,
    required this.item
    });

final InfoPillItemData item;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      child: FilledButton.tonalIcon(
        onPressed: () => print('${item.label} pressed'),
        icon: Icon(item.icon),
        style: ButtonStyle(
          padding: WidgetStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(5)),
          iconSize: WidgetStateProperty.all(30),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
          backgroundColor: WidgetStateProperty.all<Color>(Theme.of(context).buttonTheme.colorScheme?.primary.withOpacity(0.15) ?? Colors.amber),
        ),
        label: Text.rich(
            style: const TextStyle(fontSize: 16),
            TextSpan(children: [
              TextSpan(text: '${item.label} \n'),
              TextSpan(text: item.descriptiveValue, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            ]),
          
        ),
        ),
    );
  }
}
