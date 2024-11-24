PREDIKTA
📊 Revenue Growth Prediction App
PREDIKTA is a business prediction app that helps businesses forecast their potential annual revenue growth rate based on key financial and operational metrics. It empowers businesses with actionable insights, enabling smarter financial planning and growth strategies.

🚀 Features
Revenue Growth Prediction:
Predict annual revenue growth rates based on:
Credit Score
Loan Amount
Business Type (e.g., Agriculture, Manufacturing, Retail)
Years in Operation
Dark Mode Support:
Seamlessly switch between Light and Dark modes for a personalized experience.
Interactive Dropdowns:
Select your business type with an easy-to-use dropdown.
Error Handling:
Validates user inputs with clear error messages for invalid entries.
Responsive UI:
Designed to work across different screen sizes with smooth scrolling.
📱 Screenshots
Light Mode	Dark Mode
🛠️ Technologies Used
Frontend: Flutter
Backend: FastAPI
Machine Learning:
Linear Regression Model
Trained on key financial data
State Management: Flutter Stateful Widgets
HTTP Requests: http package for communication with the FastAPI backend.
🔧 Installation and Setup
Prerequisites:
Flutter SDK installed. Download Flutter
Backend API is configured using FastAPI and machine learning models. (Follow backend setup below).
Steps to Run the App:
Clone the repository:

git clone https://github.com/your-repo/predikta.git
cd predikta
Install dependencies:

flutter pub get

Run the app:

flutter run

Choose a device or emulator to run the app:

flutter run -d <device_id>
🔗 Backend Setup
Prerequisites:
Python 3.8 or higher
Install dependencies:

pip install fastapi uvicorn scikit-learn pandas
Steps:
Clone the backend repository (if separate):

git clone https://github.com/your-repo/predikta-backend.git
cd predikta-backend

Start the backend server:

uvicorn app:app --reload
The backend will run at:

http://127.0.0.1:8000

Test the prediction endpoint with:

curl -X POST "http://127.0.0.1:8000/predict" \
-H "Content-Type: application/json" \
-d '{"credit_score": 750, "loan_amount": 5000, "business_type": 0, "years_in_operation": 5}'
📝 App Workflow
User Input:

Enter Credit Score, Loan Amount, Years in Operation, and select a Business Type.
Prediction:

The app sends the input data to the backend API.
The Machine Learning model processes the data and returns the predicted growth rate.
Result Display:

The app shows the Predicted Annual Revenue Growth Rate.
Dark Mode Toggle:

Users can switch between Light and Dark modes at any time.
