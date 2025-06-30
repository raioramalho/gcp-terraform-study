from fastapi import FastAPI
from pydantic import BaseModel
from sklearn.linear_model import LinearRegression
from sklearn.model_selection import train_test_split
from sklearn.metrics import mean_squared_error
import joblib
import pandas as pd
import os
from fastapi.responses import JSONResponse
from fastapi import Request

DATA_PATH = "data.csv"
PROCESSED_PATH = "processed.csv"
MODEL_PATH = "modelo.joblib"

# Data preprocessing
def preprocess_data():
    df = pd.read_csv(DATA_PATH)
    df["preco"] = df["preco"].fillna(0).astype(float)
    df.to_csv(PROCESSED_PATH, index=False)
    return df

# Model training
def train_and_save_model(df):
    X = df[["idade", "preco"]]
    y = df["comprou"]
    X_train, X_test, y_train, y_test = train_test_split(X, y)
    model = LinearRegression()
    model.fit(X_train, y_train)
    preds = model.predict(X_test)
    print("Erro médio:", mean_squared_error(y_test, preds))
    joblib.dump(model, MODEL_PATH)

# Load or train model
if not os.path.exists(MODEL_PATH):
    df = preprocess_data()
    train_and_save_model(df)

model = joblib.load(MODEL_PATH)

# FastAPI app
app = FastAPI()

class PredictRequest(BaseModel):
    idade: float
    preco: float

@app.get("/", response_class=JSONResponse)
async def predict(request: PredictRequest):
    df = pd.DataFrame([request.dict()])
    pred = model.predict(df[["idade", "preco"]])
    return JSONResponse(content={"prediction": float(pred[0])}, media_type="application/json")
