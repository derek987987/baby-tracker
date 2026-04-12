# Data Model: Baby Tracking App

## Entities

### CareEvent
- **Attributes**:
  - `id`: UUID
  - `timestamp`: Date
  - `type`: Enum (Feeding, Diaper, Sleep)
  - `metadata`: Dictionary (e.g., side for nursing, amount for bottle, duration)
- **Relationships**: None

### DailySummary
- **Attributes**:
  - `date`: Date
  - `totalSleepDuration`: TimeInterval
  - `totalFeedingVolume`: Double
- **Relationships**: None (Computed periodically)

## Validation Rules
- `CareEvent`: timestamp must be non-nil. Type must be valid enum case.
- `DailySummary`: date must represent a single day (00:00:00 to 23:59:59).
