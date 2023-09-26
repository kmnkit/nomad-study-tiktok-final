import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:study_final/features/moods/views/mood_timeline.dart';
import 'package:study_final/features/moods/views/new_mood_post.dart';

class Destination {
  final int index;
  final IconData icon;

  Destination(
    this.index,
    this.icon,
  );
}

class MainNavigationScreen extends ConsumerStatefulWidget {
  final String tab;
  const MainNavigationScreen({
    super.key,
    required this.tab,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends ConsumerState<MainNavigationScreen> {
  final List<String> _tabs = [
    "moods",
    "post",
  ];
  late int _selectedIndex = _tabs.indexOf(widget.tab);

  static List<Destination> destinations = <Destination>[
    Destination(0, FontAwesomeIcons.house),
    Destination(1, FontAwesomeIcons.penToSquare),
  ];

  late final List<Widget> destinationViews;

  void _onDestinationSelected(int index) {
    setState(
      () {
        _selectedIndex = index;
      },
    );
    context.go("/${_tabs[index]}");
  }

  @override
  void didUpdateWidget(covariant MainNavigationScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.tab != widget.tab) {
      _selectedIndex = _tabs.indexOf(widget.tab);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Offstage(
            offstage: _selectedIndex != 0,
            child: const MoodsTimelineScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: const PostMoodScreen(),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onDestinationSelected,
        destinations: destinations
            .map(
              (destination) => NavigationDestination(
                icon: FaIcon(
                  destination.icon,
                  color: Colors.grey.shade400,
                ),
                selectedIcon: FaIcon(
                  destination.icon,
                  color: Colors.black,
                ),
                label: '',
              ),
            )
            .toList(),
        elevation: 0,
      ),
    );
  }
}
