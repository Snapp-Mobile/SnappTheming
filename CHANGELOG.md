# Change Log
All notable changes to this project will be documented in this file.

<!--
## [Unreleased] - yyyy-mm-dd

### Added
- [ISSUE-XXXX](http://tickets.projectname.com/browse/PROJECTNAME-XXXX)  
  Ticket title goes here.
- [ISSUE-YYYY](http://tickets.projectname.com/browse/PROJECTNAME-YYYY)  
  Ticket title goes here.

### Changed
- Describe changes here.

### Fixed
- Describe fixes here.

-->

## [0.1.3] - 2025-11-10

Swift 6 migration, improved image processing, shape support enhancements, and comprehensive test coverage.

### Added
- [#135](https://github.com/Snapp-Mobile/SnappTheming/pull/135)
  URL context support for image processors - enables proper initialization of formats like SVG that require resource context.
- [#130](https://github.com/Snapp-Mobile/SnappTheming/pull/130)
  `InsettableShape` support for `SnappThemingShapeType` - improves SwiftUI API compatibility with shape modifiers like `clipShape` and `strokeBorder`.
- [#136](https://github.com/Snapp-Mobile/SnappTheming/pull/136)
  Unregister method for `SnappThemingImageProcessorsRegistry` - enables dynamic processor lifecycle management.
- [#136](https://github.com/Snapp-Mobile/SnappTheming/pull/136)
  Comprehensive test coverage for `SnappThemingImageManager` - new unit tests ensure reliability and catch regressions.
- [#136](https://github.com/Snapp-Mobile/SnappTheming/pull/136)
  Thread-safe access to `SnappThemingImageProcessorsRegistry` - prevents race conditions in multi-threaded environments.

### Changed
- [#129](https://github.com/Snapp-Mobile/SnappTheming/pull/129)
  Migrated example apps to Swift 6 with related compatibility fixes.
- [#130](https://github.com/Snapp-Mobile/SnappTheming/pull/130)
  Removed internal `ShapeBuilder` in favor of standard `@InsettableShapeBuilder` pattern.
- [#133](https://github.com/Snapp-Mobile/SnappTheming/pull/133)
  Removed `SnappThemingSVGSupport` dependency from example apps to decouple testing.
- [#123](https://github.com/Snapp-Mobile/SnappTheming/pull/123)
  Updated CI/CD workflow with reusable workflow patterns for better maintainability.

### Fixed
- [#135](https://github.com/Snapp-Mobile/SnappTheming/pull/135)
  Image caching to prevent rendering issues when switching themes.
- [#136](https://github.com/Snapp-Mobile/SnappTheming/pull/136)
  Compiler warnings and formatting issues in test code.
- [#128](https://github.com/Snapp-Mobile/SnappTheming/pull/128)
  Formatting warnings across codebase.

## [0.1.2] - 2025-02-25

Bug fixes and improvements

### Added
- License [here](https://github.com/Snapp-Mobile/SnappTheming/blob/main/LICENSE)


## [0.1.1] - 2025-02-18

### Added
- [issue-93](https://github.com/Snapp-Mobile/SnappTheming/issues/93)
  Support for system and in-app fonts.
- [issue-91](https://github.com/Snapp-Mobile/SnappTheming/issues/91), [issue-92](https://github.com/Snapp-Mobile/SnappTheming/issues/92)
  Support for SF Symbols and in-app image assets.
- [issue-94](https://github.com/Snapp-Mobile/SnappTheming/issues/94)
  Runtime warnings for failed key resolutions.
