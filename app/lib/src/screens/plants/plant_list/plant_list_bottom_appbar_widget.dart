import 'package:flutter/material.dart';
import 'package:leafy_demo/src/screens/authentication/user_login_view.dart';
import 'package:provider/provider.dart';

import '../../../state/user_state.dart';

class PlantListBottomAppBar extends StatelessWidget {
  const PlantListBottomAppBar({
    super.key, 
    this.fabLocation = FloatingActionButtonLocation.endDocked,
    this.shape = const CircularNotchedRectangle(),
  });

  final FloatingActionButtonLocation fabLocation;
  final NotchedShape? shape;

  static final List<FloatingActionButtonLocation> centerLocations = <FloatingActionButtonLocation>
  [
    FloatingActionButtonLocation.centerDocked,
    FloatingActionButtonLocation.centerFloat,
  ];

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: shape,
      color: Colors.white,
      child: IconTheme(
        data: const IconThemeData(color: Colors.black54, size: 40),
        child: Row(
          children: [
            IconButton(
              tooltip: 'Open navigation menu',
              icon: const Icon(Icons.home_rounded),
              padding: const EdgeInsets.only(left: 80),
              onPressed: () {},
            ),
            if (centerLocations.contains(fabLocation)) const Spacer(),
            IconButton(
              tooltip: 'Profile',
              icon: const Icon(Icons.person),
              onPressed: () async {
                await Provider.of<UserModel>(context, listen: false).logout();

                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UserLoginView()));
              },
              padding: const EdgeInsets.only(right: 80),
            ),
          ],
        ),
      ),
    );
  }
}