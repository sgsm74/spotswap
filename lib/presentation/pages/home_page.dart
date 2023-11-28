import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotswap/domain/entities/profile_entity.dart';
import 'package:spotswap/domain/entities/track_entity.dart';
import 'package:spotswap/main.dart';
import 'package:spotswap/presentation/bloc/spotswap_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.profile,
  });
  final Profile profile;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Track> tracks = [];
  List<Track> loadedTracks = [];
  @override
  void initState() {
    BlocProvider.of<SpotSwapBloc>(context).add(GetMyTracksEvent());
    BlocProvider.of<SpotSwapBloc>(context)
        .add(LoadMyTracksEvent(account: widget.profile.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<SpotSwapBloc, SpotSwapState>(
          listener: (context, state) {
            print(state);
            if (state is GetMyTracksSuccessfulState) {
              tracks = state.tracks;
            } else if (state is ExportMyTracksSuccessfulState) {
              showAdaptiveDialog(
                context: context,
                builder: (context) => AlertDialog.adaptive(
                  title: const Text('Success'),
                  content: const Text(
                    'For import these songs, please hit the below button and login to your spotify account',
                  ),
                  actions: [
                    adaptiveAction(
                      context: context,
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MyApp(),
                          ),
                        );
                      },
                      child: const Text('Login'),
                    ),
                  ],
                ),
              );
            } else if (state is LoadMyTracksSuccessfulState) {
              loadedTracks = state.tracks;
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    children: [
                      const Text(
                        'Name: ',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        widget.profile.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Wrap(
                    children: [
                      const Text(
                        'Account: ',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        widget.profile.id,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  // const Wrap(
                  //   spacing: 4,
                  //   children: [
                  //     Text(
                  //       '20',
                  //       style: TextStyle(
                  //         fontSize: 18,
                  //         fontWeight: FontWeight.bold,
                  //       ),
                  //     ),
                  //     Text(
                  //       'Playlists',
                  //       style: TextStyle(fontSize: 18),
                  //     ),
                  //   ],
                  // ),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 4,
                    children: [
                      Text(
                        '${tracks.length}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'My tracks',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Visibility(
                    visible: loadedTracks.isNotEmpty,
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 4,
                      children: [
                        Text(
                          '${loadedTracks.length}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'Tracks ready to import',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 64,
                  ),
                  Visibility(
                    visible: state is SpotSwapLoadingState,
                    child: const Center(
                      child: CircularProgressIndicator.adaptive(
                        backgroundColor: Color(0xff20D761),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 64,
                  ),
                  Visibility(
                    visible: state is GetMyTracksSuccessfulState,
                    child: Flexible(
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                BlocProvider.of<SpotSwapBloc>(context).add(
                                  ExportMyTracksEvent(
                                    tracks: tracks,
                                    account: widget.profile.id,
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff20D761),
                              ),
                              child: const Text(
                                'Export',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff20D761),
                              ),
                              child: const Text(
                                'Import',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget adaptiveAction({
    required BuildContext context,
    required VoidCallback onPressed,
    required Widget child,
  }) {
    final ThemeData theme = Theme.of(context);
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return TextButton(onPressed: onPressed, child: child);
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return CupertinoDialogAction(onPressed: onPressed, child: child);
    }
  }
}
