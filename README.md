# CurrencyConverter

CurrencyConverter is a Swift-based iOS application designed to seamlessly convert amounts between different currencies. Built using UIKit and Core Data, this app fetches real-time currency rates from [Open Exchange Rates](https://openexchangerates.org/) and stores them locally for quick access and offline usage.

## Features
- **Real-Time Conversion:** Convert any amount between multiple currencies with ease.
- **Automatic Updates:** Currency rates are fetched and updated every 30 minutes to ensure accuracy.
- **Offline Mode:** Currency rates are stored locally using Core Data, allowing conversions even without an internet connection.
- **Unit Tested:** Comprehensive unit tests ensure reliability and accuracy of currency conversions.
- **MVVM Architecture:** The project follows the Model-View-ViewModel (MVVM) architecture, promoting a clean, maintainable, and scalable codebase.
- **Best Practices:** Adheres to industry best practices, with a focus on decoupled design for easier maintenance and scalability.

## API Integration
CurrencyConverter integrates with the [Open Exchange Rates API](https://openexchangerates.org/) to obtain the latest exchange rates. The API endpoint used is:

- `GET https://openexchangerates.org/api/latest.json`

To use this API, you need to create a free account on Open Exchange Rates and obtain your `appid`. Once you have the `appid`, you can add it to the `queryItems` property in the `ExchangeRateAPIRequest` enum to start fetching real-time exchange rates.

## Technology Stack
- **Swift**
- **UIKit**
- **Core Data**
