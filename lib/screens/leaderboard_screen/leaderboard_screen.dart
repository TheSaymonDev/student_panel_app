import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_panel/screens/leaderboard_screen/controllers/leaderboard_controller.dart';
import 'package:student_panel/screens/leaderboard_screen/widgets/today_widget.dart';
import 'package:student_panel/widgets/custom_app_bar/custom_app_bar_with_title.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final _leaderboardController = Get.find<LeaderboardController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWithTitle(
          onPressed: () => Get.back(), title: 'Leaderboard'),
      body: Column(
        children: [
          TabBar(
            dividerColor: Colors.transparent,
            controller: _tabController,
            onTap: (index) {
              final filters = ['today', 'week', 'month'];
             _leaderboardController.fetchLeaderboard(filters[index]);
            },
            tabs: const <Widget>[
              Tab(text: 'Today'),
              Tab(text: 'Week'),
              Tab(text: 'Month'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                LeaderboardWidget(),
                LeaderboardWidget(),
                LeaderboardWidget(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
