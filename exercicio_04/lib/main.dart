import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exercício 04',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
      ),
      home: const FormPage(),
    );
  }
}

class FormPage extends StatelessWidget {
  const FormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Form Demo')),
      body: const Padding(
        padding: EdgeInsets.only(right: 16),
        child: PersonForm(),
      ),
    );
  }
}

class PersonForm extends StatefulWidget {
  const PersonForm({super.key});

  @override
  State<PersonForm> createState() => _PersonFormState();
}

class _PersonFormState extends State<PersonForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _dobController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year - 18),
      firstDate: DateTime(1900),
      lastDate: now,
    );
    if (date != null) {
      final day = date.day.toString().padLeft(2, '0');
      final month = date.month.toString().padLeft(2, '0');
      _dobController.text = '$day/$month/${date.year}';
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            'Name: ${_nameController.text}\n'
            'Phone: ${_phoneController.text}\n'
            'Dob: ${_dobController.text}',
          ),
        ),
      );
  }

  String? _required(String? value) =>
      value == null || value.trim().isEmpty ? 'Campo obrigatório' : null;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          FormRow(
            icon: Icons.person,
            child: TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(hintText: 'Name'),
              validator: _required,
            ),
          ),
          FormRow(
            icon: Icons.phone,
            child: TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(hintText: 'Phone'),
              validator: _required,
            ),
          ),
          FormRow(
            icon: Icons.calendar_today,
            child: TextFormField(
              controller: _dobController,
              readOnly: true,
              onTap: _pickDate,
              decoration: const InputDecoration(hintText: 'Dob'),
              validator: _required,
            ),
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                onPressed: _submit,
                child: const Text('Submit'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FormRow extends StatelessWidget {
  final IconData icon;
  final Widget child;

  const FormRow({super.key, required this.icon, required this.child});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 48,
          child: Icon(icon, color: Colors.grey.shade600),
        ),
        Expanded(child: child),
      ],
    );
  }
}
