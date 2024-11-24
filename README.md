# PREDIKTA
📊 Revenue Growth Prediction App

PREDIKTA is a business prediction app that helps businesses forecast their potential annual revenue growth rate based on key financial and operational metrics. It empowers businesses with actionable insights to make informed decisions.

## Table of Contents
- [Features](#features)
- [Screenshots](#screenshots)
- [Technologies Used](#technologies-used)
- [Installation and Setup](#installation-and-setup)
- [Backend Setup](#backend-setup)
- [App Workflow](#app-workflow)
- [Contribution Guidelines](#contribution-guidelines)
- [Troubleshooting](#troubleshooting)
- [Contact](#contact)

## Features
- **Revenue Growth Prediction:** Predict annual revenue growth rates based on:
  - Credit Score
  - Loan Amount
  - Business Type (e.g., Agriculture, Manufacturing, Retail)
  - Years in Operation
- **Dark Mode Support:** Seamlessly switch between Light and Dark modes for a personalized experience.
- **Interactive Dropdowns:** Select your business type with an easy-to-use dropdown.
- **Error Handling:** Validates user inputs with clear error messages for invalid entries.
- **Responsive UI:** Designed to work across different screen sizes with smooth scrolling.

## Screenshots
- Light Mode
  ![image](https://github.com/user-attachments/assets/4f3890ca-b4c7-41e2-9163-b94bf0cc84b2)

- Dark Mode
  ![image](https://github.com/user-attachments/assets/72162745-0bdb-45dd-a1c4-5185359e7cc3)


## Technologies Used
- **Frontend:** Flutter
- **Backend:** FastAPI
- **Machine Learning:** Linear Regression Model (Trained on key financial data)
- **State Management:** Flutter Stateful Widgets
- **HTTP Requests:** http package for communication with the FastAPI backend.

## Installation and Setup
### Prerequisites:
- Flutter SDK installed. [Download Flutter](https://flutter.dev/docs/get-started/install)
- Backend API is configured using FastAPI and machine learning models.

### Steps to Run the App:
1. Clone the repository:
    ```bash
    git clone https://github.com/your-repo/predikta.git
    cd predikta
    ```
2. Install dependencies:
    ```bash
    flutter pub get
    ```
3. Run the app:
    ```bash
    flutter run
    ```
4. Choose a device or emulator to run the app:
    ```bash
    flutter run -d <device_id>
    ```

## Backend Setup
### Prerequisites:
- Python 3.8 or higher

### Install dependencies:
```bash
pip install fastapi uvicorn scikit-learn pandas
```

### Publicly available API endpoint
https://predicka-backend.onrender.com/docs

### YOUTUBE LINK FOR PRESENTATION
https://youtu.be/d3-bpJiPCtE



### BIG NOTICE 
On the inputing datas to predict via API Endpoint we're going to use [are encoded into] these codes on bussiness_type
0 represents Agriculture
1 represents Manufacturer
2 represents Retail



