class ElderModel {
  final String uid;
  final String name;
  final String email;
  final String phone;
  final int age;
  final String bloodType;
  final List<String> medicalConditions;
  final List<String> caregiverIds; // User IDs of caregivers

  // New fields
  final List<String> allergies;
  final double? heightCm;
  final double? weightKg;
  final String? primaryDoctorId;
  final Map<String, dynamic>? emergencyContact; // {name, phone, relation}
  final Map<String, dynamic>? baselineVitals; // e.g. {'heartRate': {'low':50,'high':90}, ...}
  final Map<String, dynamic> accessibilityPreferences; // {largeText: bool, highContrast: bool, tts: bool}

  ElderModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.phone,
    required this.age,
    required this.bloodType,
    required this.medicalConditions,
    required this.caregiverIds,
    this.allergies = const [],
    this.heightCm,
    this.weightKg,
    this.primaryDoctorId,
    this.emergencyContact,
    this.baselineVitals,
    Map<String, dynamic>? accessibilityPreferences,
  }) : accessibilityPreferences = accessibilityPreferences ?? {'largeText': false, 'highContrast': false, 'tts': false};

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phone': phone,
      'age': age,
      'bloodType': bloodType,
      'medicalConditions': medicalConditions,
      'caregiverIds': caregiverIds,
      'allergies': allergies,
      'heightCm': heightCm,
      'weightKg': weightKg,
      'primaryDoctorId': primaryDoctorId,
      'emergencyContact': emergencyContact,
      'baselineVitals': baselineVitals,
      'accessibilityPreferences': accessibilityPreferences,
    };
  }

  factory ElderModel.fromMap(Map<String, dynamic> map, String id) {
    return ElderModel(
      uid: id,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      age: map['age'] ?? 0,
      bloodType: map['bloodType'] ?? '',
      medicalConditions: List<String>.from(map['medicalConditions'] ?? []),
      caregiverIds: List<String>.from(map['caregiverIds'] ?? []),
      allergies: List<String>.from(map['allergies'] ?? []),
      heightCm: map['heightCm'] == null ? null : (map['heightCm'] as num).toDouble(),
      weightKg: map['weightKg'] == null ? null : (map['weightKg'] as num).toDouble(),
      primaryDoctorId: map['primaryDoctorId'],
      emergencyContact: map['emergencyContact'] == null ? null : Map<String, dynamic>.from(map['emergencyContact'] as Map),
      baselineVitals: map['baselineVitals'] == null ? null : Map<String, dynamic>.from(map['baselineVitals'] as Map),
      accessibilityPreferences: Map<String, dynamic>.from(map['accessibilityPreferences'] ?? {'largeText': false, 'highContrast': false, 'tts': false}),
    );
  }
}
