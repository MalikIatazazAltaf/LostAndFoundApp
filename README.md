<<<<<<< HEAD
# final_year_project

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
=======
A Community-Driven Solution for Lost & Found Items

CrowdSolve is a mobile application designed to help people quickly report lost or found items and intelligently match them using text and image similarity. This app was developed as my Final Year Project (FYP) for the BS Computer Science program.

 Features
🔐 User Authentication

Email/Password signup & login

Forgot password functionality

Firebase Authentication

📝 Report Lost Items

Upload image

Add item name, description, category

Select location

Submit instantly

🧳 Report Found Items

Same interface as lost items

Helps recover items faster

🤖 Smart Matching System

Text Matching: HuggingFace embeddings

Image Matching: Supabase vector DB + AI models

Automatically shows similar found items when a user reports lost (and vice versa)

☁️ Cloud Storage

Images stored in Cloudinary

Firestore stores image URLs + metadata

Better performance and zero storage cost on Firebase

🗄️ Database (Firebase Firestore)

Collections:

lost_items

found_items
Each contains item details, Cloudinary URL, timestamps, user info, and embeddings reference.

🎨 Modern UI (Flutter)

Clean, simple, and responsive

Optimized for all mobile screens
| Component       | Technology                       |
| --------------- | -------------------------------- |
| Frontend        | Flutter (Dart)                   |
| Authentication  | Firebase Auth                    |
| Database        | Firebase Firestore               |
| Image Storage   | Cloudinary                       |
| Matching Engine | FuzzySearch |
>>>>>>> b987ba73c7cfdcc50bb1ab8635d33eefcfc60761
