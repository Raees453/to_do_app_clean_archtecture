import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_app/core/commons/extensions/build_extension.dart';
import 'package:to_do_app/core/commons/widgets/base_scaffold.dart';
import 'package:to_do_app/src/auth/data/models/local_user_model.dart';
import 'package:to_do_app/src/auth/presentation/provider/auth_provider.dart';
import 'package:to_do_app/src/home/presentation/views/create_task_screen.dart';
import 'package:to_do_app/src/home/presentation/widgets/home_screen_widget.dart';
import 'package:to_do_app/src/home/presentation/widgets/profile_screen_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const String routeName = '/home';

  const HomeScreen({super.key});

  @override
  ConsumerState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late final LocalUserModel _user;

  final _screens = const [HomeScreenWidget(), ProfileScreenWidget()];

  int _currentIndex = 0;

  @override
  void initState() {
    _user = ref.read(authStateProvider).user!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onBottomNavBarPressed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      floatingActionButton: _currentIndex == 0
          ? FloatingActionButton(onPressed: _onAddTaskPressed, child: const Icon(Icons.add))
          : null,
      appBar: AppBar(title: Text(_user.name), backgroundColor: context.theme.primaryColor),
      child: _screens.elementAt(_currentIndex),
    );
  }

  void _onBottomNavBarPressed(int index) {
    if (_currentIndex == index) return;

    setState(() => _currentIndex = index);
  }

  void _onAddTaskPressed() => context.navigator.pushNamed(CreateTaskScreen.routeName);
}
