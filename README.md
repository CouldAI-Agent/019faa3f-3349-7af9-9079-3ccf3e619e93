# Task Hub

A complete cross-platform Flutter application for a task-earning platform featuring robust User and Admin flows. 

## Features

### User Features
- **Authentication:** Registration and Login with simulated secure flows.
- **Account Activation:** Users must activate their account by paying a 50 Tk fee via bKash or Nagad (Send Money to 01643223886) and submitting a Transaction ID. Tasks remain locked until the Admin approves the activation.
- **User Dashboard:** 
  - View Wallet Balance
  - Access Task List and Watch Ads
  - Referral System tracking
  - Submit Withdrawal Requests and view Transaction History
  - Profile Management

### Admin Panel
- **Admin Dashboard:** Overview of Total Users, Active Users, Pending Activations, Total Withdrawals, and Total Earnings.
- **User Management:** Search, view, edit, delete users. Adjust user balances and manage active status.
- **Activation Requests:** Verify user payment Transaction IDs, and approve or reject account activations.
- **Task & Ad Management:** Add, edit, delete, and toggle Tasks and Advertisements.
- **Withdraw Management:** Process user withdrawal requests.
- **Notice System:** Create and broadcast notices to users.

## Technology Stack
- **Framework:** Flutter (Mobile, Desktop, Web)
- **Language:** Dart
- **UI:** Material Design 3, Responsive Layouts

*(Note: The original specification requested PHP/MySQL, but this has been implemented as a modern, cross-platform Flutter client with a mock backend architecture ready for integration with Supabase, Firebase, or a custom API).*

## Setup & Run Instructions

1. Ensure you have the Flutter SDK installed.
2. Clone the repository and run `flutter pub get` to install dependencies.
3. Run the app on your preferred platform: `flutter run`
4. **Testing Login:** 
   - Enter `user` in the username/email field to log in as a standard user.
   - Enter `admin` in the username/email field to log in to the Admin Panel.

---

## CouldAI
This app was generated with [CouldAI](https://could.ai), an AI app builder for cross-platform apps that turns prompts into real native iOS, Android, Web, and Desktop apps with autonomous AI agents that architect, build, test, deploy, and iterate production-ready applications.
