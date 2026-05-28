import 'package:cloud_firestore/cloud_firestore.dart';

class MedicationLogModel {
  final String id;
  final String elderId;
  final String medicationId;
  final String status; // 'taken' | 'skipped' | 'snoozed'
  final DateTime timestamp;
  final String? note;

  MedicationLogModel({
    required this.id,
    required this.elderId,
    required this.medicationId,
    required this.status,
    required this.timestamp,
    this.note,
  });

  Map<String, dynamic> toMap() {
    return {
      'elderId': elderId,
      'medicationId': medicationId,
      'status': status,
      'timestamp': Timestamp.fromDate(timestamp),
      'note': note,
    };
  }

  factory MedicationLogModel.fromMap(Map<String, dynamic> map, String id) {
    return MedicationLogModel(
      id: id,
      elderId: map['elderId'] ?? '',
      medicationId: map['medicationId'] ?? '',
      status: map['status'] ?? 'taken',
      timestamp: (map['timestamp'] as Timestamp).toDate(),
      note: map['note'],
    );
  }
}
