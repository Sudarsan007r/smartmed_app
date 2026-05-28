# Elderly Experience & Health Improvements

## Current Elder Flow (What Exists)
- **Profile**: `ElderProfileScreen` edits name/phone/age/blood type/conditions; updates reuse `createElderProfile()` (full overwrite).
- **Dashboard**: `ElderDashboard` shows latest vitals, meds, alerts, and allows logging vitals and adding meds.
- **Details**: `ElderDetailScreen` shows vitals/meds; doctors can prescribe.
- **Data Model**: `ElderModel` holds basic info (age, blood type, conditions, caregiver IDs).
- **Alerts**: `AlertService` uses fixed thresholds; no escalation/acknowledgement workflow.
- **Reminders**: Med schedules are stored as string times (e.g., `"08:00"`); no adherence tracking.

## Gaps & Risks (Elderly-Specific)
- **Usability**: No large-text mode, contrast toggle, voice assistance, or simplified flow.
- **Safety**: Hardcoded vitals thresholds; no personalized baselines or escalation policies.
- **Medication adherence**: No tracking for taken/skipped/snoozed doses.
- **Health analytics**: No trends, risk scoring, or variability analysis.
- **Data completeness**: Missing allergies, weight/height, emergency contacts, primary doctor.
- **Caregiver workflow**: No care plan tasks or confirmation loops.
- **Reliability**: Profile updates overwrite instead of merging changes.

## Recommended Improvements (Prioritized)

### 1) Elder Safety & Clinical Quality (High Impact)
- **Personalized thresholds**: Store per-elder normal ranges for vitals.
- **Alert escalation**: Tiered escalation (caregiver → doctor → emergency) with acknowledgement.
- **Risk scoring**: Compute daily risk from vitals + missed meds + alert frequency.
- **Vitals trend view**: 7/30‑day trends and anomaly detection.

### 2) Medication Adherence (High Impact)
- **Dose logging**: Taken / Skipped / Snoozed with timestamps.
- **Missed dose alerts**: Notify caregivers after X misses.
- **Medication history**: Track med changes, start/stop dates, prescriber notes.
- **Structured schedules**: Use schedule objects vs. time strings.

### 3) Elder UX & Accessibility (High Impact)
- **Large-text mode**: User-configurable typography scaling.
- **High contrast mode**: Toggle for low vision users.
- **Voice prompts**: Optional TTS for reminders and instructions.
- **Simplified UI**: “Elder mode” with fewer actions per screen.

### 4) Data Model Improvements (Medium)
- **Health profile**: Add `allergies`, `height`, `weight`, `primaryDoctorId`, `emergencyContact`.
- **Vitals metadata**: Add `sourceDevice`, `unit`, and `measurementContext`.

### 5) Caregiver & Doctor UX (Medium)
- **Care plan tasks**: Assign daily tasks (med check, vitals, hydration).
- **Shared notes**: Caregiver/doctor notes timeline.
- **Bulk monitoring**: Caregiver dashboard with risk status and missed meds.

### 6) Reliability & Data Integrity (Medium)
- **Merge updates**: Use `set(..., merge: true)` or a dedicated update method for profiles.
- **Validation**: Age, blood type, phone format constraints in UI.

## Quick Wins (Next 1–2 Sprints)
- Merge-safe profile updates.
- Emergency contact field in `ElderModel` and profile screen.
- Medication adherence logging.
- 7‑day vitals trend card in `ElderDashboard`.
- Large‑text accessibility toggle.
