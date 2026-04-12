# Task List: Baby Tracker App

## Phase 1: Setup
- [X] T001 Initialize Xcode project and directory structure in baby-tracker/
- [X] T002 Configure SwiftData container for persistent storage in baby-tracker/Services/StorageService.swift

## Phase 2: Foundational
- [X] T003 [P] Define CareEvent entity in baby-tracker/Models/CareEvent.swift
- [X] T004 [P] Implement SwiftDataService for event operations in baby-tracker/Services/SwiftDataService.swift

## Phase 3: User Story 1 - Log Daily Care Events [US1]
- [X] T005 [P] [US1] Create DashboardViewModel for logging state in baby-tracker/ViewModels/DashboardViewModel.swift
- [X] T006 [US1] Build one-handed LogCareView in baby-tracker/Views/LogCareView.swift

## Phase 4: User Story 2 - View Daily Timeline [US2]
- [X] T007 [P] [US2] Build TimelineRow component in baby-tracker/Views/TimelineRow.swift
- [X] T008 [US2] Implement DashboardView with vertical timeline in baby-tracker/Views/DashboardView.swift

## Phase 5: User Story 3 - View Daily Totals [US3]
- [X] T009 [US3] Create DailySummary calculation logic in baby-tracker/ViewModels/SummaryViewModel.swift
- [X] T010 [US3] Build SummaryView for daily totals in baby-tracker/Views/SummaryView.swift

## Phase 6: Polish
- [X] T011 Ensure project compiles and runs in Xcode
- [X] T012 Verify one-handed accessibility and thumb reachability

## Implementation Strategy
- Focus on MVP functionality: Event logging (US1) followed by Timeline (US2) and Summary (US3).
- Implement sequentially to ensure data flow between Models and Views is verified.
- Cross-cutting concerns like accessibility and Xcode project configuration verified in Phase 6.

## Dependencies
- US1 (Log Events) is blocking for US2 (Timeline) and US3 (Summary).
- Foundational Models (T003) must complete before any Story tasks.
