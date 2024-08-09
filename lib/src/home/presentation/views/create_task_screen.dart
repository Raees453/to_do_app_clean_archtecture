import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_app/core/commons/extensions/build_extension.dart';
import 'package:to_do_app/core/commons/widgets/base_scaffold.dart';
import 'package:to_do_app/core/commons/widgets/text_field.dart';
import 'package:to_do_app/src/home/presentation/providers/tasks_provider.dart';

import '../../domain/usecases/create_task_usecase.dart';

class CreateTaskScreen extends ConsumerStatefulWidget {
  static const String routeName = '/create-task';

  const CreateTaskScreen({super.key});

  @override
  ConsumerState createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends ConsumerState<CreateTaskScreen> {
  final _nameController = TextEditingController();
  final _dateController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  DateTime? _selectedDate;

  @override
  void initState() {
    if (kDebugMode) {
      _nameController.text = 'Hello World';
      _dateController.text = DateTime.now().toString();
      _selectedDate = DateTime.now();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: AppBar(title: const Text('Create Task')),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextField(
              title: 'Task Name',
              hintText: 'Enter name',
              controller: _nameController,
            ),
            const SizedBox(height: 24),
            CustomTextField(
              enabled: false,
              title: 'Task Date',
              hintText: 'Select Date',
              controller: _dateController,
              suffix: IconButton(
                onPressed: _onSelectTaskDatePressed,
                icon: GestureDetector(
                  onTap: _onSelectTaskDatePressed,
                  child: const Icon(Icons.calendar_month),
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(onPressed: _onCreateTaskPressed, child: const Text('Create Task')),
          ],
        ),
      ),
    );
  }

  Future<void> _onSelectTaskDatePressed() async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime.now().subtract(const Duration(days: 90)),
      lastDate: DateTime.now().add(const Duration(days: 90)),
      initialDate: DateTime.now(),
    );

    if (date == null) return;

    _selectedDate = date;
    _dateController.text = date.toString();
  }

  Future<void> _onCreateTaskPressed() async {
    // assuming everything is a valid value
    if (!_formKey.currentState!.validate()) return;

    final name = _nameController.text.trim();

    final params = CreateTaskParams(name: name, date: _selectedDate!);
    final navigator = context.navigator;

    final status = await ref.read(tasksProvider.notifier).createTask(params);

    if (status) navigator.pop();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dateController.dispose();
    super.dispose();
  }
}
