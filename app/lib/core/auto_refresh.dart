import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/widgets.dart';

/// Calls [onRefresh] every [interval] while the app is in the foreground,
/// and as soon as it comes back to the foreground or the phone gets a
/// connection back, so a screen picks up changes made elsewhere (an owner
/// adding a task, say) without being reopened.
class AutoRefresh extends StatefulWidget {
  final Future<void> Function() onRefresh;
  final Duration interval;
  final Widget child;

  const AutoRefresh({
    super.key,
    required this.onRefresh,
    this.interval = const Duration(seconds: 30),
    required this.child,
  });

  @override
  State<AutoRefresh> createState() => _AutoRefreshState();
}

class _AutoRefreshState extends State<AutoRefresh> with WidgetsBindingObserver {
  late final StreamSubscription<List<ConnectivityResult>> _connectivity;

  // Runs only while the app is in the foreground; see _startTimer.
  Timer? _timer;

  // Null until the first report, so the initial state doesn't count as a
  // connection coming back.
  bool? _offline;

  // Coming back online often fires alongside a resume; one reload is enough.
  bool _refreshing = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _connectivity = Connectivity().onConnectivityChanged.listen((results) {
      final offline = results.every((r) => r == ConnectivityResult.none);
      if (_offline == true && !offline) _refresh();
      _offline = offline;
    });
    _startTimer();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _refresh();
      _startTimer();
    } else {
      // No reloads in the background, where nobody would see them.
      _timer?.cancel();
      _timer = null;
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(widget.interval, (_) {
      // Offline, a reload can only fail; reconnecting triggers one anyway.
      if (_offline != true) _refresh();
    });
  }

  Future<void> _refresh() async {
    if (_refreshing) return;
    _refreshing = true;
    try {
      await widget.onRefresh();
    } catch (_) {
      // Nobody asked for this reload, so there's no one to tell it failed;
      // the screen keeps what it has and the next one tries again.
    } finally {
      _refreshing = false;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _connectivity.cancel();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
