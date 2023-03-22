importScripts('https://www.gstatic.com/firebasejs/8.4.1/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/8.4.1/firebase-messaging.js');

   /*Update with yours config*/
  // For Firebase JS SDK v7.20.0 and later, measurementId is optional
  const firebaseConfig = {
    apiKey: "AIzaSyAfpKcy8-Q0njQtWCoEB3aOxSx_sZ0xato",
    authDomain: "redwood-666f7.firebaseapp.com",
    projectId: "redwood-666f7",
    storageBucket: "redwood-666f7.appspot.com",
    messagingSenderId: "205919215363",
    appId: "1:205919215363:web:006646b9ac2db18db8d336",
    measurementId: "G-JCRWJ657NY"
  };
  firebase.initializeApp(firebaseConfig);
  const messaging = firebase.messaging();

  /*messaging.onMessage((payload) => {
  console.log('Message received. ', payload);*/
  messaging.onBackgroundMessage(function(payload) {
    console.log('Received background message ', payload);

    const notificationTitle = payload.notification.title;
    const notificationOptions = {
      body: payload.notification.body,
    };

    self.registration.showNotification(notificationTitle,
      notificationOptions);
  });
