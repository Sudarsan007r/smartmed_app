import 'package:flutter/material.dart';
import 'package:smartmed_app/models/elder_model.dart';
import 'package:smartmed_app/services/firestore_service.dart';

class ElderProfileScreen extends StatefulWidget {
  final ElderModel elder;
  const ElderProfileScreen({super.key, required this.elder});

  @override
  State<ElderProfileScreen> createState() => _ElderProfileScreenState();
}

class _ElderProfileScreenState extends State<ElderProfileScreen> {
  final _fs = FirestoreService();
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameC;
  late TextEditingController _phoneC;
  late TextEditingController _ageC;
  late TextEditingController _bloodC;
  late TextEditingController _conditionsC;
  late TextEditingController _allergiesC;
  late TextEditingController _heightC;
  late TextEditingController _weightC;
  late TextEditingController _emContactNameC;
  late TextEditingController _emContactPhoneC;
  late TextEditingController _emContactRelationC;
  late TextEditingController _primaryDoctorC;

  bool _largeText = false;
  bool _highContrast = false;
  bool _tts = false;

  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _nameC = TextEditingController(text: widget.elder.name);
    _phoneC = TextEditingController(text: widget.elder.phone);
    _ageC = TextEditingController(text: widget.elder.age.toString());
    _bloodC = TextEditingController(text: widget.elder.bloodType);
    _conditionsC = TextEditingController(text: widget.elder.medicalConditions.join(", "));
    _allergiesC = TextEditingController(text: widget.elder.allergies.join(", "));
    _heightC = TextEditingController(text: widget.elder.heightCm?.toString() ?? '');
    _weightC = TextEditingController(text: widget.elder.weightKg?.toString() ?? '');
    _emContactNameC = TextEditingController(text: widget.elder.emergencyContact?['name'] ?? '');
    _emContactPhoneC = TextEditingController(text: widget.elder.emergencyContact?['phone'] ?? '');
    _emContactRelationC = TextEditingController(text: widget.elder.emergencyContact?['relation'] ?? '');
    _primaryDoctorC = TextEditingController(text: widget.elder.primaryDoctorId ?? '');
    _largeText = widget.elder.accessibilityPreferences['largeText'] ?? false;
    _highContrast = widget.elder.accessibilityPreferences['highContrast'] ?? false;
    _tts = widget.elder.accessibilityPreferences['tts'] ?? false;
  }

  Future<void> _update() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);

    try {
      final patch = <String, dynamic>{
        'name': _nameC.text,
        'phone': _phoneC.text,
        'age': int.tryParse(_ageC.text) ?? 0,
        'bloodType': _bloodC.text,
        'medicalConditions': _conditionsC.text.split(",").map((e) => e.trim()).where((s) => s.isNotEmpty).toList(),
        'allergies': _allergiesC.text.split(",").map((e) => e.trim()).where((s) => s.isNotEmpty).toList(),
        'heightCm': _heightC.text.isEmpty ? null : double.tryParse(_heightC.text),
        'weightKg': _weightC.text.isEmpty ? null : double.tryParse(_weightC.text),
        'primaryDoctorId': _primaryDoctorC.text.isEmpty ? null : _primaryDoctorC.text,
        'emergencyContact': {
          'name': _emContactNameC.text,
          'phone': _emContactPhoneC.text,
          'relation': _emContactRelationC.text,
        },
        'accessibilityPreferences': {
          'largeText': _largeText,
          'highContrast': _highContrast,
          'tts': _tts,
        }
      };

      await _fs.updateElderProfile(widget.elder.uid, patch);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Profile updated!")));
        Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Profile")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(children: [
            TextFormField(controller: _nameC, decoration: const InputDecoration(labelText: "Full Name")),
            TextFormField(controller: _phoneC, decoration: const InputDecoration(labelText: "Phone")),
            TextFormField(controller: _ageC, decoration: const InputDecoration(labelText: "Age"), keyboardType: TextInputType.number),
            TextFormField(controller: _bloodC, decoration: const InputDecoration(labelText: "Blood Type")),
            TextFormField(controller: _conditionsC, decoration: const InputDecoration(labelText: "Medical Conditions (comma separated)")),
            const SizedBox(height: 12),
            TextFormField(controller: _allergiesC, decoration: const InputDecoration(labelText: "Allergies (comma separated)")),
            Row(children: [
              Expanded(child: TextFormField(controller: _heightC, decoration: const InputDecoration(labelText: "Height (cm)"), keyboardType: TextInputType.number)),
              const SizedBox(width: 8),
              Expanded(child: TextFormField(controller: _weightC, decoration: const InputDecoration(labelText: "Weight (kg)"), keyboardType: TextInputType.number)),
            ]),
            const SizedBox(height: 12),
            TextFormField(controller: _emContactNameC, decoration: const InputDecoration(labelText: "Emergency Contact Name")),
            TextFormField(controller: _emContactPhoneC, decoration: const InputDecoration(labelText: "Emergency Contact Phone")),
            TextFormField(controller: _emContactRelationC, decoration: const InputDecoration(labelText: "Emergency Contact Relation")),
            const SizedBox(height: 12),
            TextFormField(controller: _primaryDoctorC, decoration: const InputDecoration(labelText: "Primary Doctor ID (optional)")),
            const SizedBox(height: 12),
            SwitchListTile(title: const Text('Large text'), value: _largeText, onChanged: (v) => setState(() => _largeText = v)),
            SwitchListTile(title: const Text('High contrast'), value: _highContrast, onChanged: (v) => setState(() => _highContrast = v)),
            SwitchListTile(title: const Text('TTS enabled'), value: _tts, onChanged: (v) => setState(() => _tts = v)),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _loading ? null : _update,
              child: _loading ? const CircularProgressIndicator() : const Text("Update Profile"),
            ),
          ]),
        ),
      ),
    );
  }
}
