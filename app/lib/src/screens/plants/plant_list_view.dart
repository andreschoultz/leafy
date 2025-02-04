import 'package:flutter/material.dart';
import 'package:leafy_demo/src/screens/plants/filters/filter_appbar_toggle_btn_widget.dart';
import 'package:leafy_demo/src/screens/plants/filters/size_filter_bottom_sheet_widget.dart';
import 'package:leafy_demo/src/screens/plants/filters/sunlight_filter_bottom_sheet_widget.dart';
import 'package:leafy_demo/src/state/plant_state.dart';
import 'package:provider/provider.dart';

import 'plant_list/plant_list_bottom_appbar_widget.dart';
import 'plant_list/plant_list_widget.dart';

class PlantListView extends StatefulWidget {
  const PlantListView({
    super.key,
  });

  static const routeName = '/plant/list';

  @override
  State<PlantListView> createState() => _PlantListViewState();
}

class _PlantListViewState extends State<PlantListView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<PlantModel>(context, listen: false).getList();
    });
  }

  Future<void> onRefreshPage() async {
    await Provider.of<PlantModel>(context, listen: false).getList();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(241, 245, 249, 1),
          surfaceTintColor: const Color.fromRGBO(241, 245, 249, 1),
          automaticallyImplyLeading: false,
          toolbarHeight: 80,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SearchBar(
              leading: const Icon(Icons.search),
              trailing: [IconButton(onPressed: () {}, icon: const Icon(Icons.close))],
              constraints: const BoxConstraints(maxHeight: 44),
              elevation: const WidgetStatePropertyAll(0.3),
              padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 12)),
              hintText: 'Search plants',
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size(MediaQuery.of(context).size.width, 40),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 19),
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                physics: const AlwaysScrollableScrollPhysics(),
                child: Row(
                  children: [
                    FilterAppBarToggleBtn(
                        label: 'Size',
                        onPressed: () {
                          showModalBottomSheet(context: context, builder: (context) => SizeFilterBottomSheet(onApply: onRefreshPage));
                        }),
                    FilterAppBarToggleBtn(
                        label: 'Sunlight',
                        onPressed: () {
                          showModalBottomSheet(context: context, builder: (context) => const SunlightFilterBottomSheet());
                        }),
                  ],
                ),
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          tooltip: 'Create',
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50))),
          backgroundColor: Colors.white,
          foregroundColor: Colors.indigo,
          child: const Icon(Icons.flip),
        ),
        bottomNavigationBar: const PlantListBottomAppBar(
          fabLocation: FloatingActionButtonLocation.centerDocked,
          shape: CircularNotchedRectangle(),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 0),
          child: RefreshIndicator(
            child: PlantListItemView(),
            onRefresh: onRefreshPage,
            displacement: 0,
          ),
        ),
      ),
    );
  }
}