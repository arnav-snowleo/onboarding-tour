import 'package:flutter/material.dart';
import 'package:onboarding_overlay/onboarding_overlay.dart';

void main() {
  // timeDilation = 2;

  runApp(App());
}

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class App extends StatefulWidget {
  final GlobalKey<OnboardingState> onboardingKey = GlobalKey<OnboardingState>();

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  late List<FocusNode> focusNodes;

  @override
  void initState() {
    super.initState();

    focusNodes = List<FocusNode>.generate(
      7,
      (int i) => FocusNode(debugLabel: 'Onboarding Focus Node $i'),
      growable: false,
    );
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Onboarding(
          key: widget.onboardingKey,
          autoSizeTexts: true,
          steps: <OnboardingStep>[
            OnboardingStep(
              focusNode: focusNodes[0],
              title: 'Tap anywhere to continue ',
              titleTextColor: Colors.black,
              bodyText: 'Tap anywhere to continue Tap anywhere to continue',
              labelBoxPadding: const EdgeInsets.all(16.0),
              labelBoxDecoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  color: const Color(0xFF00E1FF),
                  border: Border.all(
                    color: const Color(0xFF1E05FB),
                    width: 1.0,
                    style: BorderStyle.solid,
                  )),
              arrowPosition: ArrowPosition.bottom,
              hasArrow: true,
              hasLabelBox: true,
              fullscreen: true,
            ),
            OnboardingStep(
              focusNode: focusNodes[1],
              title: 'start-tour',
              bodyText: 'Tap to continue',
              shape: const CircleBorder(),
              fullscreen: false,
              overlayColor: Colors.blue.withOpacity(0.9),
              overlayShape: const CircleBorder(),
            ),
            OnboardingStep(
              focusNode: focusNodes[2],
              title: 'Easy to customize',
              bodyText: 'Easy to customize',
              overlayColor: Colors.red.withOpacity(0.9),
              labelBoxPadding: const EdgeInsets.all(16.0),
              labelBoxDecoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  color: const Color(0xFF1100FF),
                  border: Border.all(
                    color: const Color(0xFFE2FB05),
                    width: 1.0,
                    style: BorderStyle.solid,
                  )),
              arrowPosition: ArrowPosition.top,
              hasArrow: true,
              hasLabelBox: true,
              textAlign: TextAlign.center,
            ),
            OnboardingStep(
              focusNode: focusNodes[3],
              title: 'tour',
              bodyText: 'take the tour to get started',
              overlayColor: Colors.green.withOpacity(0.9),
              shape: const CircleBorder(),
              overlayBehavior: HitTestBehavior.translucent,
            ),
            OnboardingStep(
              focusNode: focusNodes[4],
              title: 'Menu',
              shape: const CircleBorder(),
              bodyText: 'Click here to access menu',
              fullscreen: false,
              overlayColor: Colors.black.withOpacity(0.8),
              overlayShape: const CircleBorder(),
            ),
            OnboardingStep(
              focusNode: focusNodes[5],
              title: 'Logout',
              bodyText: 'press to logout',
              labelBoxPadding: const EdgeInsets.all(16.0),
              labelBoxDecoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  color: const Color(0xFF1100FF),
                  border: Border.all(
                    color: const Color(0xFFE2FB05),
                    width: 1.0,
                    style: BorderStyle.solid,
                  )),
              arrowPosition: ArrowPosition.bottom,
              hasArrow: true,
              hasLabelBox: true,
            ),
            OnboardingStep(
              focusNode: focusNodes[6],
              title: "You're all done!",
              bodyText:
                  "you're all set to have a seamless expereince usin our app",
              margin: EdgeInsets.zero,
              labelBoxPadding: const EdgeInsets.all(8.0),
            ),
          ],
          onChanged: (int index) {
            if (index == 5) {
              // close the drawer
              if (scaffoldKey.currentState?.isDrawerOpen ?? false) {
                scaffoldKey.currentState?.openEndDrawer();
              }
              // interrupt onboarding on specific step
              // widget.onboardingKey.currentState.hide();
            }
          },
          child: Home(
            focusNodes: focusNodes,
          ),
        ),
      );
}

class Home extends StatefulWidget {
  const Home({
    Key? key,
    required this.focusNodes,
  }) : super(key: key);

  final List<FocusNode> focusNodes;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          focusNode: widget.focusNodes[4],
          icon: const Icon(Icons.menu),
          onPressed: () {
            scaffoldKey.currentState?.openDrawer();
          },
        ),
        title: Focus(
          focusNode: widget.focusNodes[3],
          child: const Text('Onboarding Tour'),
        ),
        actions: [
          IconButton(
            focusNode: widget.focusNodes[5],
            icon: const Icon(Icons.logout),
            onPressed: () {},
          )
        ],
      ),
      drawer: const Drawer(
        child: Center(
          child: Text('Menu'),
        ),
      ),
      body: Center(
        child: Container(
          child: Text('Hello 👋 '),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        focusNode: widget.focusNodes[1],
        onPressed: () {
          final OnboardingState? onboarding = Onboarding.of(context);
          if (onboarding != null) {
            onboarding.show();
          }
        },
        child: const Icon(Icons.ac_unit),
      ),
    );
  }
}
