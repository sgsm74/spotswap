import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotswap/core/consts/consts.dart';
import 'package:spotswap/core/dependency_injection/dependency_injection.dart';
import 'package:spotswap/presentation/bloc/spotswap_bloc.dart';
import 'package:spotswap/presentation/pages/home_page.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:spotswap/core/dependency_injection/dependency_injection.dart'
    as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SpotSwapBloc>(),
      child: MaterialApp(
        title: 'SpotSwap',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff20D761)),
          useMaterial3: true,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String initialLink = '';
  String link = '';
  String code = '';
  @override
  void initState() {
    initUniLinks();
    super.initState();
  }

  Future<void> initUniLinks() async {
    try {
      initialLink = await getInitialLink() ?? '';
    } catch (_) {}

    if (initialLink.isNotEmpty) {
      _handleDeepLink(initialLink);
    }
    linkStream.listen((String? link) {
      if (link != null) {
        _handleDeepLink(link);
      }
    });
  }

  void _handleDeepLink(String link) {
    Uri uri = Uri.parse(link);
    code = uri.queryParameters['code'].toString();
    setState(() {});
    BlocProvider.of<SpotSwapBloc>(context).add(AuthenticationEvent(code: code));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: BlocConsumer<SpotSwapBloc, SpotSwapState>(
            listener: (context, state) {
              if (state is AuthenticationSuccessfulState) {
                BlocProvider.of<SpotSwapBloc>(context).add(GetProfileEvent());
              } else if (state is GetProfileSuccessfulState) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(
                      profile: state.profile,
                    ),
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is SpotSwapLoadingState) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(
                    backgroundColor: Color(0xff20D761),
                  ),
                );
              }
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            ImageAssets.spotify,
                            height: 150,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          const Text(
                            'SpotSwap',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 64,
                          ),
                          const Text(
                            'Swap your Spotify liked musics between your accounts easily.',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: ElevatedButton(
                        onPressed: () {
                          launchUrl(
                            Uri.parse(
                              AuthorizeParameters.url,
                            ),
                            mode: LaunchMode.externalApplication,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff20D761),
                          minimumSize: const Size(
                            double.maxFinite,
                            kMinInteractiveDimension,
                          ),
                          maximumSize: const Size(
                            double.maxFinite,
                            kMinInteractiveDimension,
                          ),
                        ),
                        child: const Text(
                          'Login with Spotify',
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
              );
            },
          ),
        ),
      ),
    );
  }
}
