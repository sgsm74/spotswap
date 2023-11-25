import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotswap/domain/entities/profile_entity.dart';
import 'package:spotswap/domain/entities/track_entity.dart';
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
  @override
  void initState() {
    BlocProvider.of<SpotSwapBloc>(context).add(GetMyTracksEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<SpotSwapBloc, SpotSwapState>(
          listener: (context, state) {
            if (state is GetMyTracksSuccessfulState) {
              tracks = state.tracks;
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
                      Visibility(
                        visible: state is GetMyTracksSuccessfulState,
                        replacement: const SizedBox(
                          width: 10,
                          height: 10,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Color(0xff20D761),
                            ),
                          ),
                        ),
                        child: Text(
                          '${tracks.length}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Text(
                        'Tracks',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 128,
                  ),
                  Flexible(
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              BlocProvider.of<SpotSwapBloc>(context)
                                  .add(GetMyTracksEvent());
                            },
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
                              'Export',
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
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
