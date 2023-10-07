
# Flutter News Search App

This Flutter application allows users to search for news articles using the NewsAPI. Users can search for articles based on keywords and date range, and the app also remembers the last search result. Additionally, the app supports infinite scrolling, allowing users to load more articles as they scroll down.

![Intro](https://github.com/LiranFain22/flutter-news-app/blob/main/assets/images/app_intro.gif)

## Features
1. **Search Articles:** Users can search for news articles by entering keywords in the search bar. They can also specify a date range to narrow down the search results.

2. **Remembering Last Search:** The app remembers the last search query and displays the results when the user returns to the app.

3. **Infinite Scrolling:** As the user scrolls through the list of articles, the app automatically loads more articles from the NewsAPI.

## Technical Details
### BLoC Pattern
This app follows the BLoC (Business Logic Component) pattern to manage the state of the application. BLoC separates the UI from the business logic, making the codebase clean and maintainable.
### Dio Package
The Dio package is used in this app to handle API requests to NewsAPI. Dio is a powerful HTTP client for Dart and Flutter, providing features like request cancellation, interceptors, and more.

## Getting Started
To run this app on your local machine, follow these steps:

1. Clone the repository to your local machine:

```
   git clone https://github.com/your-username/flutter-news-app.git 
```
  
2. Change your working directory to the project folder:
```
cd flutter-news-app
```
3. Install dependencies using Flutter's package manager:
```
flutter pub get
```
4. Run the app:
```
flutter run
```

---
## Dependencies

The primary dependencies used in this project are:

- **Dio:** For handling HTTP requests to the NewsAPI.

- **Flutter BLoC:** To implement the BLoC pattern for state management.

- **Hive**: For caching the last search result.

- **intl:** For internationalization and date formatting.

---
