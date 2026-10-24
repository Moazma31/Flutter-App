import 'package:flutter/material.dart';
import '../core/app_theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
final _formKey = GlobalKey<FormState>();
final _name = TextEditingController();
final _regNo = TextEditingController();
final _email = TextEditingController();
final _password = TextEditingController();
final _confirm = TextEditingController();

bool _isLogin = true;
bool _isStudent = true;
bool _hidePassword = true;
String? _department;

static const _departments = [
'Computer Science',
'Software Engineering',
'Electrical Engineering',
'Management Sciences',
'Mathematics',
];

@override
void dispose() {
_name.dispose();
_regNo.dispose();
_email.dispose();
_password.dispose();
_confirm.dispose();
super.dispose();
}

void _submit() {
if (!_formKey.currentState!.validate()) return;
ScaffoldMessenger.of(context).showSnackBar(
SnackBar(
content: Text(_isLogin ? 'Signed in (demo)' : 'Account created (demo)'),
),
);
}

InputDecoration _decoration(String label, IconData icon) {
return InputDecoration(
labelText: label,
prefixIcon: Icon(icon),
filled: true,
fillColor: Colors.white,
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(14),
borderSide: BorderSide.none,
),
);
}
Widget _buildHeader() {
return Container(
width: double.infinity,
padding: const EdgeInsets.fromLTRB(24, 70, 24, 40),
decoration: const BoxDecoration(
color: AppColors.teal,
borderRadius: BorderRadius.vertical(bottom: Radius.circular(36)),
),
child: Column(
children: [
const Icon(Icons.travel_explore_rounded, size: 64, color: Colors.white),
const SizedBox(height: 12),
const Text(
'Lost & Found @ CUI',
style: TextStyle(
fontSize: 24,
fontWeight: FontWeight.bold,
color: Colors.white,
),
),
const SizedBox(height: 6),
Text(
_isLogin ? 'Welcome back' : 'Create your account',
style: const TextStyle(color: Colors.white70),
),
],
),
);
}
List<Widget> _buildSignUpFields() {
return [
SizedBox(
width: double.infinity,
child: SegmentedButton<bool>(
segments: const [
ButtonSegment(
value: true,
label: Text('Student'),
icon: Icon(Icons.school_outlined),
),
ButtonSegment(
value: false,
label: Text('Teacher'),
icon: Icon(Icons.person_outline),
),
],
selected: {_isStudent},
onSelectionChanged: (s) => setState(() => _isStudent = s.first),
),
),
const SizedBox(height: 16),
TextFormField(
controller: _name,
decoration: _decoration('Full name', Icons.person_outline),
validator: (v) => (v ?? '').trim().isEmpty ? 'Enter your name' : null,
),
const SizedBox(height: 16),
if (_isStudent) ...[
TextFormField(
controller: _regNo,
textCapitalization: TextCapitalization.characters,
decoration: _decoration('Registration no (SP25-BCS-001)', Icons.badge_outlined),
validator: (v) {
final ok = RegExp(r'^(SP|FA)\d{2}-[A-Z]{2,4}-\d{3}$', caseSensitive: false);
return ok.hasMatch(v ?? '') ? null : 'Format: SP25-BCS-001';
},
),
const SizedBox(height: 16),
],
DropdownButtonFormField<String>(
value: _department,
isExpanded: true,
decoration: _decoration('Department', Icons.apartment_outlined),
items: _departments
.map((d) => DropdownMenuItem(value: d, child: Text(d)))
.toList(),
onChanged: (v) => setState(() => _department = v),
validator: (v) => v == null ? 'Select your department' : null,
),
const SizedBox(height: 16),
];
}
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: SingleChildScrollView(
      child: Column(
        children: [
          _buildHeader(),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  if (!_isLogin) ..._buildSignUpFields(),
                  TextFormField(
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: _decoration('Email', Icons.email_outlined),
                    validator: (v) {
                      final ok = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
                      return ok.hasMatch(v ?? '') ? null : 'Enter a valid email';
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _password,
                    obscureText: _hidePassword,
                    decoration: _decoration('Password', Icons.lock_outline).copyWith(
                      suffixIcon: IconButton(
                        icon: Icon(
                          _hidePassword ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: () =>
                            setState(() => _hidePassword = !_hidePassword),
                      ),
                    ),
                    validator: (v) =>
                    (v ?? '').length >= 8 ? null : 'At least 8 characters',
                  ),
                  if (!_isLogin) ...[
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _confirm,
                      obscureText: _hidePassword,
                      decoration: _decoration('Confirm password', Icons.lock_outline),
                      validator: (v) =>
                      v == _password.text ? null : 'Passwords do not match',
                    ),
                  ],
                  const SizedBox(height: 28),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.teal,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        _isLogin ? 'Sign In' : 'Create Account',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () => setState(() => _isLogin = !_isLogin),
                    child: Text(
                      _isLogin
                          ? 'New here? Create an account'
                          : 'Already have an account? Sign In',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
}
