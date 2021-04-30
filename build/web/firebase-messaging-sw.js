importScripts("https://www.gstatic.com/firebasejs/8.4.2/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.4.2/firebase-messaging.js");

firebase.initializeApp({
    apiKey: "AIzaSyCzUYLIL8cjN9yA6xjm89bIYeW9tj4L-aA",
    authDomain: "covidwatcher-11d14.firebaseapp.com",
    projectId: "covidwatcher-11d14",
    storageBucket: "covidwatcher-11d14.appspot.com",
    messagingSenderId: "339029405949",
    appId: "1:339029405949:web:79cb6cfe27745d2da78e94",
    measurementId: "G-S56YQSLD1B"
});

const messaging = firebase.messaging();

// // Optional:
// messaging.onBackgroundMessage((message) => {
//     console.log("onBackgroundMessage", message);
// });