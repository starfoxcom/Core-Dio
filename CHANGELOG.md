# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.1] - 2025-07-30

### Added
- BSD 3-Clause License with proper copyright attribution to Jorge Alexandro Zamudio Arredondo
- Created CHANGELOG.md to track changes and updates

### Changed
- Enhanced README documentation with link to CoreLogger GitHub repository
- Updated package version to 1.0.1 to reflect the addition of the license, changelog, and documentation improvements

## [1.0.0] - 2025-07-30

### Added
- Comprehensive CoreDio HTTP client package implementation
- Singleton pattern for consistent HTTP client usage across application
- Support for GET, POST, PUT, and DELETE HTTP operations
- Automatic CoreLogger integration for request/response logging
- Configurable base URL, timeouts, and default headers
- Type-safe API with generic response types and optional parameters
- Initialization validation to ensure proper setup before usage
- Built-in error handling with DioException support
- Example Flutter app demonstrating all CoreDio features
- Interactive HTTP operations demo with real-time UI feedback
- Widget tests to verify the example app's functionality
- Comprehensive test suite covering all HTTP methods and error states
- Professional README documentation with installation and usage instructions
- Detailed inline code documentation using proper Dart syntax with square bracket notation
- Initial CoreDio package project structure
- Basic Flutter package boilerplate and configuration
- Dependencies setup with Dio and CoreLogger packages

### Features
- **Singleton Pattern**: Access the same HTTP client instance throughout entire application
- **Multiple HTTP Methods**: Support for GET, POST, PUT, and DELETE operations with comprehensive parameter options
- **Built on Dio Package**: Leverages the robust and popular `dio` package for HTTP functionality
- **Automatic Logging**: Integrated request/response logging through CoreLogger package
- **Easy Configuration**: Simple initialization with base URL, timeouts, and headers setup
- **Error Handling**: Built-in error handling with proper exception propagation and logging
- **Type Safety**: Full Dart type safety with generic response types and optional parameters
