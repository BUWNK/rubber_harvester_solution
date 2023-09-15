import pickle
import requests
import datetime
import pandas as pd
import firebase_admin
from firebase_admin import credentials, firestore

# Initialize Firebase Admin SDK
cred = credentials.Certificate("rubberx-f3daf-firebase-adminsdk-st9cx-deec48af37.json")
firebase_admin.initialize_app(cred)

db = firestore.client()
collection_ref = db.collection('user_data')

def login_with_email_password(email, password):
    url = f"https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyC8x-VM1tR5pU2rMXp_-OE8qV1oWSUKKBU"
    data = {
        "email": email,
        "password": password,
        "returnSecureToken": True
    }
    response = requests.post(url, json=data)
    return response.json()["idToken"]

# Call the function and get the user's ID token
user_token = login_with_email_password("rubberx@abc.com", "a123456")

def push_data(amount, date, humidity, rainfall, temperature, time_tap_rubber):
    data_to_send = {
    "amount": amount,
    "date": date,
    "humidity": humidity,
    "rainfall": rainfall,
    "temperature": temperature,
    "time_tap_rubber": time_tap_rubber
    }
    collection_ref = db.collection("prediction_test")
    collection_ref.add(data_to_send)

def get_new_data():

    with open('primary_df.pickle', 'rb') as file:
        df = pickle.load(file)

    humidity=[] 
    wind=[]
    tempature=[] 
    dry_milk=[]

    # Query documents in the collection
    documents = collection_ref.stream()

    for doc in documents:
        # print(f'Document ID: {doc.id}')
        data = doc.to_dict()
        humidity.append(data['humidity'])
        wind.append(data['windSpeed'])
        tempature.append(data['tempature'])
        dry_milk.append(data['amount'])


    new_data = {'Humidity': humidity,
                'Wind': wind,
                'Tempature': tempature,
                'Total(latex)(dry Milk)':dry_milk
                }
        
    new_df = pd.DataFrame(new_data)
    df = pd.concat([df, new_df], ignore_index=True)
    return df
