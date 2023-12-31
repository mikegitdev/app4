import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app4/bloc/theme/theme_bloc.dart';
import 'package:app4/data/repositories/song_repository.dart';
import 'package:app4/presentation/components/home_card.dart';
import 'package:app4/presentation/components/player_bottom_app_bar.dart';

import 'package:app4/presentation/pages/home/views/songs_view.dart';
import 'package:app4/presentation/utils/app_router.dart';
import 'package:app4/presentation/utils/theme/themes.dart';
import 'package:on_audio_query/on_audio_query.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  late final SongRepository songRepository;
  late TabController _tabController;
  bool _hasPermission = false;

  @override
  void initState() {
    super.initState();
    checkAndRequestPermissions();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  Future checkAndRequestPermissions({bool retry = false}) async {
    // The param 'retryRequest' is false, by default.
    _hasPermission = await _audioQuery.checkAndRequest(
      retryRequest: retry,
    );

    // Only call update the UI if application has all required permissions.
    _hasPermission ? setState(() {}) : checkAndRequestPermissions(retry: true);
  }

  final tabs = [
    'Songs',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return Scaffold(
          extendBody: true,
          appBar: AppBar(
            backgroundColor: Themes.getTheme().primaryColor,
            title: const Text('Meloplay'),
          ),

          // current song, play/pause button, song progress bar, song queue button
          bottomNavigationBar: const PlayerBottomAppBar(),
          body: Ink(
            decoration: BoxDecoration(
              gradient: Themes.getTheme().linearGradient,
            ),
            child: _hasPermission
                ? Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            // HomeCard(
                            //   title: 'Favorites',
                            //   icon: Icons.favorite_rounded,
                            //   color: const Color(0xFF5D2285),
                            //   onTap: () {},
                            // ),
                            const SizedBox(width: 16),

                            const SizedBox(width: 16),
                            // HomeCard(
                            //   title: 'Recents',
                            //   icon: Icons.history,
                            //   color: const Color(0xFFD4850D),
                            //   onTap: () {
                            //     Navigator.of(context).pushNamed(
                            //       AppRouter.recentsRoute,
                            //     );
                            //   },
                            // ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      TabBar(
                        controller: _tabController,
                        tabs: tabs.map((e) => Tab(text: e)).toList(),
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: const [
                            SongsView(),
                          ],
                        ),
                      ),
                    ],
                  )
                : const Center(
                    child: Text('No permission to access library'),
                  ),
          ),
        );
      },
    );
  }
}
