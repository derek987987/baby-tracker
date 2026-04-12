# Research: Baby Tracking App

## Summary
The plan is to leverage modern Swift/SwiftUI/SwiftData stacks for a native iOS MVP focusing on accessibility, one-handed UI, and full Xcode project compatibility.

## Research Tasks

| Task | Findings |
|------|----------|
| **SwiftUI one-handed accessibility** | Bottom-anchored button rows (`HStack` inside `VStack` with `Spacer`) are recommended for one-handed thumb interaction in HIG. Use `ViewThatFits` to ensure responsiveness across different iPhone sizes. |
| **SwiftData event filtering** | Use `Predicate` macro in `@Query` to fetch `CareEvent` entities by date. SwiftData handles background context operations automatically, ensuring UI stays responsive. |
| **Xcode Project Configuration** | Ensure all source files and assets are properly linked in `project.pbxproj`. Use XCTest targets correctly to enable testing from within Xcode. |
| **Timeline performance** | Use `LazyVStack` to render long lists of timeline events efficiently. Pre-calculate daily summaries asynchronously to prevent dashboard lag. |

## Decisions

- **Decision**: Use `SwiftData` predicate filtering for daily data fetch.
- **Rationale**: Built-in SwiftData integration with SwiftUI `@Query` allows real-time UI updates without manual data controller code.
- **Alternatives considered**: CoreData (rejected for higher boilerplate), Realm (rejected to avoid third-party dependency).
