
<p align="center">
  <img src="https://github.com/user-attachments/assets/feaf793a-96b5-4aae-b4fd-4aee66c38642" width="200" height="470"/>
  <img src="https://github.com/user-attachments/assets/c20669fc-f934-4a24-95a7-96de4d5a22cc" width="200" height="470"/>
  <img src="https://github.com/user-attachments/assets/91562acc-7767-4dd3-b767-24307396c5c5" width="200" height="470"/>
  <img src="https://github.com/user-attachments/assets/077356a7-4fab-4a99-a0c3-b591c3437288" width="200" height="470"/>
  <img src="https://github.com/user-attachments/assets/d453df0c-5e27-4279-9044-f66efce5a13d" width="200" height="470"/>
</p>







UltraFlix

UltraFlix is a Flutter-based movie discovery application that allows users to browse trending movies, search for titles, view detailed information, and manage their account through Firebase Authentication. The app is built using a clean, scalable architecture with Riverpod for state management and integrates with The Movie Database (TMDB) API for real-time movie data.
## Overview

UltraFlix was built as a learning and portfolio project to demonstrate practical implementation of state management, API integration, and authentication in a production-style Flutter application. It follows a modular architecture that separates concerns across models, services, providers, and UI layers, making the codebase easy to extend and maintain.

## Features

- Trending movies displayed in a responsive grid layout
- Real-time search with live filtering as the user types
- Detailed movie view including overview, rating, release date, and popularity
- Featured movie banner highlighting top content on the home screen
- Firebase Authentication supporting both Email/Password and Phone (OTP) sign-in
- Dedicated Signup, Login, and OTP verification screens
- Animated splash screen with branded UI
- Consistent dark theme across the entire application
- Proper loading, empty, and error states for all data-driven screens

## Tech Stack

| Category | Technology |
|---|---|
| Framework | Flutter |
| State Management | Riverpod |
| Networking | Dio / http |
| Authentication | Firebase Authentication |
| Backend Services | Firebase Core |
| Data Source | TMDB API |
| Language | Dart |

## Architecture

The application follows a layered architecture:
UI Layer (Screens/Widgets)
↓
Providers (Riverpod - State Management)
↓
Services (API calls, Firebase logic)
↓
Models (Data structures)


This separation ensures that UI components remain independent of business logic, and API or authentication logic can be modified without affecting the presentation layer.



### Installation

1. Clone the repository:
git clone https://github.com/hanzla-farooq77/movie_app.git
cd movie_app

2. Install project dependencies:
flutter pub get

3. Configure your TMDB API key in the constants file:
lib/constants/api_constants.dart

4. Run the application:
flutter run
