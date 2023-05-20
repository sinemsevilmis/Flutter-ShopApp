import 'package:shop_app/widgets/product_display_list_view.dart';
import 'package:shop_app/widgets/top_container.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: 0,
    );
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: TopContainer(
                title: 'Hi, SS',
                searchBarTitle: 'Search',
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: tabController,
                children: const [
                  ProductDisplayWidget(),
                  ProductDisplayWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
