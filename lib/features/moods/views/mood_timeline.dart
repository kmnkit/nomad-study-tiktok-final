import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:study_final/constants/routes.dart';
import 'package:study_final/features/authentication/repositories/auth_repo.dart';
import 'package:study_final/features/authentication/view_models/sign_out_view_model.dart';
import 'package:study_final/features/moods/view_models/love_mood_view_model.dart';

import 'package:study_final/features/moods/view_models/mood_timeline_view_model.dart';
import 'package:study_final/features/moods/views/widgets/mood_card.dart';
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

  void _onLoveTap(String moodId) =>
      ref.watch(loveMoodProvider(moodId).notifier).loveMood();

  @override
  Widget build(BuildContext context) {
    bool isVisible = false;
    String? userUid = ref.read(authRepo).user?.uid;
    return ref.watch(realtimeProvider).when(
          loading: () => const Center(child: CircularProgressIndicator.adaptive()),
          error: (Object error, StackTrace stackTrace) => Center(
            child: Text("Could not load moods: $error"),
          ),
          data: (moods) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: NestedScrollView(
                  headerSliverBuilder: (context, _) => [
                    SliverAppBar(
                      title: const Text("😍 MOODS 😍"),
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
                  body: NotificationListener<UserScrollNotification>(
                    onNotification: (notification) {
                      final ScrollDirection direction = notification.direction;
                      setState(() {
                        if (direction == ScrollDirection.reverse) {
                          isVisible = false;
                        } else {
                          isVisible = true;
                        }
                      });
                      return true;
                    },
                    child: Stack(
                      children: [
                        Positioned(
                          top: 20,
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 500),
                            opacity: isVisible ? 1 : 0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.red.shade100,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              width: MediaQuery.sizeOf(context).width / 2,
                              height: 80,
                            ),
                          ),
                        ),
                        ListView.separated(
                          itemCount: moods.length,
                          itemBuilder: (context, index) {
                            final mood = moods[index];
                            final isMine = userUid == mood.creatorUid;
                            return ref.watch(loveMoodProvider(mood.id)).when(
                                  data: (isLoved) => Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Slidable(
                                        key: ValueKey(index),
                                        endActionPane: ActionPane(
                                          extentRatio: isMine ? 0.5 : 0.25,
                                          motion: const ScrollMotion(),
                                          children: [
                                            SlidableAction(
                                              flex: 1,
                                              onPressed: (context) =>
                                                  _onLoveTap(mood.id),
                                              backgroundColor: Colors.blue,
                                              foregroundColor:
                                                  isLoved ? Colors.red : Colors.white,
                                              icon: FontAwesomeIcons.solidHeart,
                                              label: 'Love',
                                            ),
                                            if (isMine)
                                              SlidableAction(
                                                flex: 1,
                                                onPressed: (context) => ref
                                                    .watch(timelineProvider.notifier)
                                                    .deleteMood(
                                                        context, mood.id, userUid!),
                                                backgroundColor: Colors.pink,
                                                foregroundColor: Colors.white,
                                                icon: Icons.delete,
                                                label: 'Delete',
                                              ),
                                          ],
                                        ),
                                        child: GestureDetector(
                                          onLongPress: () => _onLongPress(mood.id,
                                              userUid!, mood.creatorUid == userUid),
                                          child: SizedBox(
                                            width: double.infinity,
                                            child: MoodCard(
                                              mood: mood,
                                              onLoveTap: () => _onLoveTap(mood.id),
                                              isLoved: isLoved,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            timeago.format(
                                              DateTime.fromMillisecondsSinceEpoch(
                                                mood.created,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  error: (e, st) =>
                                      const CircularProgressIndicator.adaptive(),
                                  loading: () =>
                                      const CircularProgressIndicator.adaptive(),
                                );
                          },
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 20),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
  }

  void _onLongPress(String moodId, String userUid, bool isMine) {
    showAdaptiveDialog(
      context: context,
      builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CupertinoAlertDialog(
              title: Text(isMine ? "Delete Mood" : "You can't delete"),
              content: Text(isMine
                  ? "Are you sure you want to do this mood?"
                  : "You can delete only your own mood."),
              actions: [
                if (isMine)
                  CupertinoDialogAction(
                    isDestructiveAction: true,
                    onPressed: () {
                      ref
                          .read(timelineProvider.notifier)
                          .deleteMood(context, moodId, userUid);
                      context.pop();
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
