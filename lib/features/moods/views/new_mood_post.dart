import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:study_final/constants/emojis.dart';
import 'package:study_final/constants/routes.dart';
import 'package:study_final/features/moods/view_models/new_mood_view_model.dart';

import 'package:study_final/features/moods/views/widgets/mood_block.dart';

const List<Widget> brightnessIcons = <Widget>[
  FaIcon(FontAwesomeIcons.solidSun),
  FaIcon(FontAwesomeIcons.solidMoon),
];

class PostMoodScreen extends ConsumerStatefulWidget {
  const PostMoodScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PostMoodScreenState();
}

class _PostMoodScreenState extends ConsumerState<PostMoodScreen> {
  int _selectedIndex = 0;
  String _text = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController()
      ..addListener(() {
        _text = _controller.text;
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('🔥 MOOD 🔥'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 60,
              ),
              const Text(
                'How do you feel?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      maxLength: 140,
                      maxLines: 4,
                      validator: _validator,
                      controller: _controller,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        hintText: "Write it down here!",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      "What's your mood?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Flex(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        emojis.length,
                        (index) => Flexible(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () => _onMoodTap(index),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: MoodBlockWidget(
                                edge: width,
                                isSelected: _selectedIndex == index,
                                emoji: emojis[index],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: _onSubmit,
                  child: const Text(
                    "Post",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onMoodTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onSubmit() async {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        ref.read(postNewMoodForm.notifier).state = {
          'text': _text,
          'emojiIndex': _selectedIndex,
        };
        await ref.watch(newMoodProvider.notifier).postNewMood(context);
        _controller.clear();
        if (!context.mounted) return;
        context.go(RoutePath.moods);
      }
    }
  }

  String? _validator(String? value) {
    if (value == null || value.isEmpty) return "1글자 이상 입력해 주세요.";
    return null;
  }
}
