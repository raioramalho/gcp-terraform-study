from fastapi import FastAPI
from sklearn.linear_model import LinearRegression
from sklearn.model_selection import train_test_split
from sklearn.metrics import mean_squared_error
import joblib
import pandas as pd

df = pd.read_csv("raw.csv")
df["preco"] = df["preco"].fillna(0).astype(float)
df.to_csv("processed.csv", index=False)



X = df[["idade", "salario"]]
y = df["comprou"]

X_train, X_test, y_train, y_test = train_test_split(X, y)

model = LinearRegression()
model.fit(X_train, y_train)

preds = model.predict(X_test)
print("Erro médio:", mean_squared_error(y_test, preds))

joblib.dump(model, "modelo.joblib")

model = joblib.load("modelo.joblib")
app = FastAPI()

@app.post("/predict")
def predict(data: dict):
    df = pd.DataFrame([data])
    pred = model.predict(df)
    return {"prediction": pred[0]}
