const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

const db = admin.firestore();

exports.alertAnomaly = functions.firestore
    .document('alarm/{coin}')
    .onCreate((snap, context) => {
      const time = snap.data().time;
      const date = Date(time);
      const timeS = date.toString();
      return admin.messaging().sendToTopic('alarm', {
        notification: {
          title: 'Anomaly detected on trade ' + snap.data().name,
          body: timeS,
          clickAction: 'FLUTTER_NOTIFICATION_CLICK',
        },
      });
    });
