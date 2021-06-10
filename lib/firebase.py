# Imports
import pyrebase
import re

config = {
    "apiKey": "AIzaSyCnF8JpVbwfGyvoeT3hcIzd5Nrb59Ay09k",
    "authDomain": "finalproject-d36c2.firebaseapp.com",
    "projectId": "finalproject-d36c2",
    "databaseURL": "https://final-year-project-95782-default-rtdb.asia-southeast1.firebasedatabase.app/",
    "storageBucket": "finalproject-d36c2.appspot.com",
    "messagingSenderId": "616534496864",
    "appId": "1:616534496864:web:8dadb3cda4961f169d9505",
    "measurementId": "G-DK45MLV8H9"
        }

firebase = pyrebase.initialize_app(config)
database = firebase.database()

#CREATE_DATABASE
data1 = {"name": "dayana","email":"dayanaedwin@gmail.com"}
data2 = {"task1_status": "False","task2_status":"True"}
data3={"location" : "kitchen"}
voice_commands = {"forward": "മുന്നോട്ട്,आगे,forward" , "backward": "പിന്നോട്ട്,पीछे,backward" , "start": "തുടങ്ങുക,प्रारंभ,शुरू,start", "stop":"നിർത്തുക,रुको,रुक,stop","turn":"തിരിയുക,घुमाइए,घूमो,turn"}
database.push(voice_commands)
database.child("indoor mapping").set(data3)
database.child("username").set(data1)
database.child("voice commands ").set(voice_commands)
database.child("notification").set(data2)