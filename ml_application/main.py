import pandas as pd
import requests, pickle
from datetime import datetime
import database
import model
import schedule
import time

date_format = "%Y-%m-%d"  # Specify the format of your date string

# Define the API endpoint URL
url = 'http://api.weatherapi.com/v1/forecast.json?key=3f558929fbe94ecd9ff120502230909&q=6.5877,79.9566&days=3&aqi=no&alerts=no'


def run():
    model.train()

    #load model
    with open('latex_model.pickle', 'rb') as file:
        automl = pickle.load(file)

    # Make the API request
    response = requests.get(url)

    # Check if the request was successful (HTTP status code 200)
    if response.status_code == 200:
        

        data = response.json()
        days = data['forecast']["forecastday"]
        for day in days:
            time_lst = []
            date_time_lst = []
            wind_kph_lst = []
            temp_c_lst = []
            humidity_lst = []
            rain_lst = []
            ideal_lst = []

            for hour in day['hour']:
                date_time_lst.append(hour['time'])
                time_lst.append(int(hour['time'].split()[1].split(":")[0]))
                wind_kph_lst.append(hour['wind_kph'])
                temp_c_lst.append(hour['temp_c'])
                humidity_lst.append(hour['humidity'])
                rain_lst.append(hour["will_it_rain"])
                ideal_lst.append(False)

            for i in range(len(time_lst)):
                if time_lst[i] >= 0 and time_lst[i] <= 6 and temp_c_lst[i] >= 24 and temp_c_lst[i] <= 29 and humidity_lst[i] >= 40 and humidity_lst[i] <= 50 and wind_kph_lst[i] >= 3 and wind_kph_lst[i] <= 5 and rain_lst[i]==0:
                    ideal_lst[i] = True


            # ideal_lst[0] = True
            # ideal_lst[2] = True
            # ideal_lst[7] = True

            ideal_hours_lst = []
            dry_milk_min = 0
            dry_milk_max = 0
            dry_milk_avg = 0

            is_ideal = any(ideal_lst)
            if is_ideal:
                # Get the indexes of True values using a list comprehension
                true_indexes = [j for j, value in enumerate(ideal_lst) if value]
                dry_milk_pred = []
                for k in true_indexes:
                    ideal_hours_lst.append(date_time_lst[k].split()[1])
                    data_dict = {'Humidity': [humidity_lst[k]], 'Wind': [wind_kph_lst[k]], 'Tempature': [temp_c_lst[k]]}
                    dry_milk_pred.append(automl.predict(pd.DataFrame(data_dict))[0])
                    
                dry_milk_min = min(dry_milk_pred)
                dry_milk_max = max(dry_milk_pred)
                dry_milk_avg = sum(dry_milk_pred) / len(dry_milk_pred)

            # print(datetime.strptime(day["date"], date_format))
            # print(day["day"]["condition"]["text"])
            # print(day["day"]["avghumidity"])
            # print(day["day"]["avgtemp_c"])
            # print(is_ideal)
            # print(ideal_hours_lst)
            # print(dry_milk_min)
            # print(dry_milk_max)
            # print(dry_milk_avg)
            # print("__________________")

            date = datetime.strptime(day["date"], date_format)
            rainfall = day["day"]["condition"]["text"]
            humidity = day["day"]["avghumidity"]
            temperature = day["day"]["avgtemp_c"]
            # print(is_ideal)
            time_tap_rubber = ideal_hours_lst
            # print(dry_milk_min)
            # print(dry_milk_max)
            amount = dry_milk_avg
            
            database.push_data(amount, date, humidity, rainfall, temperature, time_tap_rubber)

            # break

        # print(f"Weather in {location}:")
        # print(f"Temperature: {data['main']['temp']}°C")
        # print(f"Description: {data['weather'][0]['description']}")
    else:
        print("Error: Unable to fetch weather data for")

# Schedule the function to run daily at a specific time (e.g., 1:00 AM)
schedule.every().day.at("01:00").do(run)

while True:
    schedule.run_pending()
    time.sleep(60)  # Sleep for 60 seconds
    