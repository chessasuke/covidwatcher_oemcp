const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

exports.pushNotifications = functions.firestore
    .document('covid-cases-verified/{event}')
    .onCreate(async (snap, context) => {

        console.log('snap: ', snap.data());
        let name = snap.data().building;

        if (name) {
            // FCM Topics dont support spaces, (), and other characters
            // process the string
            let processedName = name.split(' ').join('_');
            processedName = processedName.split('(').join('');
            processedName = processedName.split(')').join('');
            console.log('name:', processedName);

            // create msg to send
            // use the processedName as the topic
            // but send the real name of the bulding
            const message = {
                notification: {
                    title: 'New Case in '+ name,
                },
                topic: processedName,
            };

            await admin
                .messaging()
                .send(message)
                .then((response) => {
                    console.log("Successfully sent message:", response);
                })
                .catch((error) => {
                    console.log("Error sending message:", error);
                });
        }
        else {
            console.log("Empty string");
        }

    });


// Send Push Notifications whenever a new case is added to the verified cases collection
exports.broadcastNotifications = functions.firestore
    .document('broadcast-notifications/{event}')
    .onCreate(async (snap, context) => {

        console.log('snap: ', snap.data());
        let title = snap.data().title;
        let msg = snap.data().msg;

        console.log("title:", title);

        if(title && msg){

            // create msg to send
            const message = {
                notification: {
                    title: title,
                    body: msg,
                },
                topic: 'broadcast',
            };

            await admin
                .messaging()
                .send(message)
                .then((response) => {
                    console.log("Successfully sent message:", response);
                })
                .catch((error) => {
                    console.log("Error sending message:", error);
                });
        }
        else {
            console.log("title or msg null");
        }

    });