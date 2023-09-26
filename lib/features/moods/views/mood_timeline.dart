import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:study_final/constants/emojis.dart';
import 'package:study_final/constants/routes.dart';
import 'package:study_final/features/authentication/view_models/sign_out_view_model.dart';
import 'package:study_final/features/moods/models/mood.dart';
import 'package:study_final/features/moods/view_models/mood_timeline_view_model.dart';
import 'package:timeago/timeago.dart' as timeago;

class MoodsTimelineScreen extends ConsumerStatefulWidget {
  const MoodsTimelineScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MoodsTimelineScreenState();
}

class _MoodsTimelineScreenState extends ConsumerState<MoodsTimelineScreen> {
  void _onLogoutTap() {
    ref.read(signOutProvider.notifier).signOut(context);
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(timelineProvider).when(
          loading: () => const Center(child: CircularProgressIndicator.adaptive()),
          error: (Object error, StackTrace stackTrace) => Center(
            child: Text("Could not load threads: $error"),
          ),
          data: (moods) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) => [
                    SliverAppBar(
                      title: const Text("MOODS"),
                      floating: true,
                      actions: [
                        PopupMenuButton(
                          icon: const FaIcon(FontAwesomeIcons.gears),
                          initialValue: 0,
                          itemBuilder: (context) {
                            return <PopupMenuEntry>[
                              PopupMenuItem(
                                child: const ListTile(
                                  title: Text("설정"),
                                ),
                                onTap: () => context.push(RoutePath.settings),
                              ),
                              PopupMenuItem(
                                onTap: _onLogoutTap,
                                child: ListTile(
                                  title: const Text("로그아웃"),
                                  trailing: ref.watch(signOutProvider).isLoading
                                      ? const CircularProgressIndicator.adaptive()
                                      : null,
                                ),
                              ),
                            ];
                          },
                        ),
                      ],
                    ),
                  ],
                  body: RefreshIndicator.adaptive(
                    onRefresh: _onRefresh,
                    child: ListView.separated(
                      itemCount: moods.length,
                      itemBuilder: (context, index) {
                        final mood = moods[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onLongPress: () => _onLongPress(mood.id),
                              child: SizedBox(
                                width: double.infinity,
                                child: MoodCard(mood: mood),
                              ),
                            ),
                            Text(
                              timeago.format(
                                DateTime.fromMillisecondsSinceEpoch(
                                  mood.created,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(height: 20),
                    ),
                  ),
                ),
              ),
            );
          },
        );
  }

  Future<void> _onRefresh() => ref.watch(timelineProvider.notifier).refresh();

  void _onLongPress(String moodId) {
    showAdaptiveDialog(
      context: context,
      builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CupertinoAlertDialog(
              title: const Text("Delete Mood"),
              content: const Text("Are you sure you want to do this mood?"),
              actions: [
                CupertinoDialogAction(
                  isDestructiveAction: true,
                  onPressed: () {
                    ref.read(timelineProvider.notifier).deleteMood(moodId);
                    context.pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        showCloseIcon: true,
                        content: Text("Mood가 삭제되었습니다."),
                      ),
                    );
                  },
                  child: const Text("Delete"),
                ),
                CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: _onCancel,
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _onCancel() => context.pop();
}

class MoodCard extends StatelessWidget {
  const MoodCard({
    super.key,
    required this.mood,
  });

  final MoodModel mood;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
          vertical: 4,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("MOOD: ${emojis[mood.emojiIndex]}"),
            Text(
              mood.text,
              maxLines: 10,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
