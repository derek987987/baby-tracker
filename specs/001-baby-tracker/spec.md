# Feature Specification: Baby Tracking App

**Feature Branch**: `001-baby-tracker`  
**Created**: 2026-04-12  
**Status**: Draft  
**Input**: User description: "Build a comprehensive baby tracking application similar to PiyoLog. The core features must include: 1. A home dashboard with a daily visual timeline of events. 2. The ability to log feeding (nursing/bottle), diaper changes (wet/dirty), and sleep durations. 3. A summary view showing daily totals (e.g., total sleep time, total milk volume). The UI should be highly accessible for tired parents holding a baby in one hand."

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Log Daily Care Events (Priority: P1)

As a busy parent, I want to quickly log feeding, diaper changes, and sleep so that I can keep track of my baby's daily routine without significant effort.

**Why this priority**: This is the core functionality required for any baby tracking application.

**Independent Test**: Can be fully tested by creating an entry for each event type (feeding, diaper, sleep) and verifying they appear in the system.

**Acceptance Scenarios**:

1. **Given** the home screen, **When** I tap to log a feeding, **Then** I am presented with options to specify nursing or bottle feeding.
2. **Given** the logging screen, **When** I log a feeding, **Then** it is saved with the current timestamp.
3. **Given** the home screen, **When** I tap to log a diaper change, **Then** I am presented with options for wet or dirty.
4. **Given** the logging screen, **When** I log a diaper change, **Then** it is saved with the current timestamp.
5. **Given** the home screen, **When** I log a sleep event, **Then** I can specify start and end times.

---

### User Story 2 - View Daily Timeline (Priority: P1)

As a parent, I want to see a visual timeline of today's activities so that I can quickly understand when the last feeding or diaper change occurred.

**Why this priority**: Provides immediate value to parents needing quick reference.

**Independent Test**: Verify that events logged in User Story 1 appear in a chronological timeline view on the dashboard.

**Acceptance Scenarios**:

1. **Given** I have logged events throughout the day, **When** I open the dashboard, **Then** I see a vertical timeline showing all events in chronological order.
2. **Given** the timeline view, **When** I view an event, **Then** I see the type, details (e.g., side for nursing, amount for bottle), and timestamp.

---

### User Story 3 - View Daily Totals (Priority: P2)

As a parent, I want to view daily summaries of total sleep time and milk volume so that I can ensure my baby is getting enough rest and nutrition.

**Why this priority**: Essential for monitoring long-term health and growth patterns.

**Independent Test**: Verify that the daily totals accurately reflect the sum of all activities logged for the day.

**Acceptance Scenarios**:

1. **Given** I have logged multiple feeding events, **When** I open the summary view, **Then** I see the total volume of milk consumed today.
2. **Given** I have logged multiple sleep events, **When** I open the summary view, **Then** I see the total hours of sleep recorded today.

---

### Edge Cases

- What happens when a user attempts to log overlapping sleep durations?
- How does the system handle log edits or deletions for events logged by mistake?
- What happens if the app is used while offline?

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: System MUST allow logging of nursing (side, duration) and bottle (volume, type) feeds.
- **FR-002**: System MUST allow logging of diaper changes (wet, dirty, mixed).
- **FR-003**: System MUST allow logging of sleep (start time, end time).
- **FR-004**: System MUST display a chronological timeline of events for the current date.
- **FR-005**: System MUST calculate and display daily totals for sleep (hours) and feeding (volume).
- **FR-006**: UI MUST be optimized for one-handed use, ensuring primary logging actions are reachable with a thumb.
- **FR-007**: System MUST be a valid Xcode project capable of being compiled and tested within the Xcode environment.

### Key Entities

- **CareEvent**: Represents a singular activity (feeding, diaper, sleep) with a timestamp, type, and associated metadata.
- **DailySummary**: Represents the calculated totals for care events over a 24-hour period.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Primary logging actions (feeding, diaper, sleep) require 3 or fewer taps to complete.
- **SC-002**: Timeline view loads and displays all events for the current day in under 1 second.
- **SC-003**: 95% of users can log a new event within 15 seconds.

## Assumptions

- One-handed accessibility is achieved through bottom-anchored action menus.
- The app handles date-based data aggregation automatically based on the user's local timezone.
- No external cloud syncing is required for MVP; local data storage suffices.
