# Bitcoin Price Tracker 📈

A Flutter application that tracks real-time cryptocurrency prices across multiple fiat currencies. Built with Flutter and powered by the CoinAPI.io service.

## Features

- Real-time cryptocurrency price tracking
- Support for multiple cryptocurrencies including Bitcoin (BTC), Ethereum (ETH), and Litecoin (LTC)
- Currency conversion across 21 different fiat currencies
- Beautiful Material Design UI with animated loading states
- Responsive layout that works across mobile and web platforms
- Platform-specific UI controls (Cupertino for iOS, Material for Android)

## Getting Started

### Prerequisites

- Flutter SDK (latest version)
- Dart SDK (latest version)
- A CoinAPI.io API key
- An IDE (VS Code, Android Studio, or IntelliJ)

### Installation

1. Clone the repository
```bash
git clone https://github.com/yourusername/bitcoin-price-tracker.git
```

2. Navigate to the project directory
```bash
cd bitcoin-price-tracker
```

3. Install dependencies
```bash
flutter pub get
```

4. Update the API key in `constants.dart`
```dart
const apiKey = 'YOUR_API_KEY_HERE';
```

5. Run the application
```bash
flutter run
```

## Project Structure

```
lib/
├── coin_data.dart      # Currency and crypto data models
├── constants.dart      # API configuration and constants
├── main.dart          # Application entry point
├── network.dart       # API communication logic
├── price_screen.dart  # Main price tracking screen
```

## Dependencies

- `http`: For making API requests
- `flutter/material.dart`: Material Design widgets
- `flutter/cupertino.dart`: iOS-style widgets

## API Integration

This application uses the CoinAPI.io REST API to fetch real-time cryptocurrency exchange rates. The base URL for the API is:

```
https://rest.coinapi.io/v1/exchangerate
```

## Features to Add

- [ ] Add more cryptocurrencies
- [ ] Implement price alerts
- [ ] Add historical price charts
- [ ] Add cryptocurrency news feed
- [ ] Implement user authentication
- [ ] Add portfolio tracking

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- CoinAPI.io for providing the cryptocurrency data API
- Flutter team for the amazing framework
- All contributors who help to improve this project
