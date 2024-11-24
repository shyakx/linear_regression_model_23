from fastapi import FastAPI
from pydantic import BaseModel
import joblib
import numpy as np
import pandas as pd
from fastapi.middleware.cors import CORSMiddleware

# Load the trained model and scaler
model = joblib.load("best_model.pkl")
scale = joblib.load("scale.pkl")

# Initialize FastAPI app
app = FastAPI()

# Set up CORS middleware to allow all origins
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # This allows all origins. You can restrict it to specific domains.
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Define a class to map the incoming request JSON
class InputData(BaseModel):
    credit_score: float
    loan_amount: float
    business_type: int  # Expecting 0 (Agriculture), 1 (Manufacturing), or 2 (Retail)
    years_in_operation: int

# Define a prediction endpoint
@app.post("/predict")
async def predict_growth_rate(data: InputData):
    # Create a DataFrame from the input data
    input_data = pd.DataFrame({
        'Credit_Score': [data.credit_score],
        'Loan_Amount': [data.loan_amount],
        'Business_Type': [data.business_type],
        'Years_in_Operation': [data.years_in_operation]
    })
    
    # Standardize the input data using the saved scaler
    scaled_input = scale.transform(input_data)
    
    # Predict the Annual Revenue Growth Rate
    prediction = model.predict(scaled_input)
    
    # Return the prediction result
    return {"predicted_annual_revenue_growth_rate": round(prediction[0], 2)}

# Root endpoint for testing
@app.get("/")
async def root():
    return {"message": "Welcome to the Revenue Growth Rate Prediction API!"}