# Find Me Words 📖

**Find Me Words** is a modern, high-performance Flutter dictionary application designed for seamless online and offline exploration of the English language. It leverages a hybrid data strategy, combining a massive local SQLite database with real-time API integration for comprehensive word insights.

<table>
  <tr>
    <td>
      <img src="https://github.com/user-attachments/assets/98eac6b7-ef88-422c-b921-85417bc91100" width="250"/>
    </td>
    <td>
      <img src="https://github.com/user-attachments/assets/d4ca9424-521e-4e0b-84a7-8cf1647b3e53" width="250"/>
    </td>
    <td>
       <img src="https://github.com/user-attachments/assets/c573bef6-6a19-4e4d-a6ed-369ef604084e" width="250"/>
    </td>
     <td>
      <img src="https://github.com/user-attachments/assets/d937c7e1-6469-4b29-9938-a2065992ca2a" width="250"/>
    </td>
  </tr>
</table>

## ✨ Key Features

*   **Lightning-Fast Search:** Real-time search suggestions as you type, powered by local indexing.
*   **Deep Word Insights:** Detailed meanings, phonetics, synonyms, antonyms, and audio pronunciations.
*   **Offline First:** Access thousands of basic word meanings without an internet connection.
*   **Hybrid Caching:** Automatically caches full API responses for previously searched words to save data and improve performance.
*   **Smart Bookmarking:** Save your favorite words for quick reference later, managed locally in the database.
*   **Dynamic Theming:** Seamlessly switch between Light and Dark modes, with full support for System-wide theme synchronization.
*   **Network Awareness:** Integrated connectivity monitoring with a visual indicator (Green/Red) to show your current connection status.
*   **Modern Navigation:** Robust and deep-link-ready routing using the `go_router` package.

## 🛠 Tech Stack

*   **Framework:** Flutter (Material 3)
*   **State Management:** Riverpod (with `riverpod_annotation` and code generation)
*   **Database:** SQLite (`sqflite`)
*   **Navigation:** `go_router`
*   **Networking:** `dio`
*   **Connectivity:** `connectivity_plus`
*   **Serialization:** `json_serializable`

## 🗄 Architecture & Database Connection

### How is the local database connected?

The application uses a **SQLite** backend to ensure offline capability and persistent storage. The database architecture is structured into three layers:

1.  **Initialization (`AppDatabase`):** A singleton class that manages the SQLite connection using `sqflite`. It handles table creation (`words` table) and performance-critical indexes (`idx_word`). It also manages schema migrations, such as adding the bookmarking functionality in version 2.
2.  **Preloading (`DictionaryPreloadService`):** Upon the very first launch, the app performs a one-time "Warm-up" during the Splash Screen. it reads a massive `dictionary.json` from the assets and performs a high-performance **Batch Insert** into the SQLite `words` table. This ensures users have access to basic meanings immediately, even without internet.
3.  **Data Access (`DictionaryQueryService`):** A dedicated service layer that abstracts all SQL operations. It handles:
    *   Fuzzy search for suggestions.
    *   Retrieving basic meanings (offline fallback).
    *   Storing and retrieving full JSON payloads (caching layer).
    *   Toggling and listing bookmarks.

### Hybrid Data Flow
When a user searches for a word:
1.  **Local Check:** The app first checks if a "Full Explanation" is already cached in the local DB.
2.  **API Fetch:** If not cached and online, it fetches the latest data from the Dictionary API.
3.  **Automatic Cache:** The full API response is saved back to the SQLite `json` column, converting the word into a "Full Data" entry for future offline use.
4.  **Offline Fallback:** If offline, the app gracefully falls back to the basic `meaning` stored during the preload phase.

## 🚀 Getting Started

### Prerequisites
*   Flutter SDK (^3.11.0)
*   Dart SDK

### Installation
1.  Clone the repository.
2.  Run `flutter pub get` to fetch dependencies.
3.  Run `dart run build_runner build` to generate the necessary state management and serialization code.
4.  Launch the app using `flutter run`.

---
*Developed with a focus on speed, reliability, and clean engineering.*
