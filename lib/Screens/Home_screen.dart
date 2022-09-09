import 'package:event_dynamic_link/config/palette.dart';
import 'package:event_dynamic_link/services/local_notification.dart';
import 'package:event_dynamic_link/services/utils.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_share/flutter_share.dart';

import 'Navigation_screen.dart';
import 'PostScreen.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String deviceTokenToSendPushNotification = "";
  Color mainColor = Color(0xfff1517f);
  String notificationMsg = "Waiting for notifications";

  @override
  void initState() {
    initDynamicLinks(); // Retreive dynamic link firebase.
    super.initState();
    LocalNotificationService.initilize(); //push notification service
    // Terminated State
    FirebaseMessaging.instance.getInitialMessage().then((event) {
      if (event != null) {
        setState(() {
          notificationMsg =
              "${event.notification!.title} ${event.notification!.body} I am coming from terminated state";
        });
      }
    });

    // Foregrand State
    FirebaseMessaging.onMessage.listen((event) {
      LocalNotificationService.showNotificationOnForeground(event);
      setState(() {
        notificationMsg =
            "${event.notification!.title} ${event.notification!.body} I am coming from foreground";
      });
    });

    // background State
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      setState(() {
        notificationMsg =
            "${event.notification!.title} ${event.notification!.body} I am coming from background";
      });
    });
  }

  Future<void> getDeviceTokenToSendNotification() async { // Device token for push notification
    final FirebaseMessaging _fcm = FirebaseMessaging.instance;
     Palette.device_token = (await _fcm.getToken())!;
    deviceTokenToSendPushNotification = Palette.device_token.toString();
    print("Token Value $deviceTokenToSendPushNotification");
  }

  ///Retreive dynamic link firebase.
  void initDynamicLinks() async {
    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri? deepLink = data?.link;

    if (deepLink != null) {
      handleDynamicLink(deepLink);
    }
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData? dynamicLink) async {
      final Uri? deepLink = dynamicLink?.link;

      if (deepLink != null) {
        handleDynamicLink(deepLink);
      }
    }, onError: (OnLinkErrorException e) async {
      print(e.message);
    });
  }
// Dynamic link Redirection
  handleDynamicLink(Uri url) {
    List<String> separatedString = [];
    separatedString.addAll(url.path.split('/'));
    if (separatedString[1] == "post") {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PostScreen(separatedString[2])));
    }
  }

  @override
  Widget build(BuildContext context) {
    getDeviceTokenToSendNotification(); // Function to get device token
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Palette.primaryColor,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.share_outlined),
            iconSize: 23.0,
            onPressed: () async {
              try {
                Palette.url = await AppUtils.buildDynamicLink(); //Dynamic link creation
              } catch (e) {
                print(e);
              }
              share(); // Dynamic link share option
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            iconSize: 20.0,
            onPressed: () async {
              Clipboard.setData(ClipboardData(text: Palette.device_token));
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor:Colors.black,content: Text("Device token copied to clipboard",style: TextStyle(color: Colors.white),)));

              },
          ),
        ],
      ),
      drawer: MyDrawerDirectory(), // Navigation drawer
      body: Stack(
        children: <Widget>[dashBg, content],
      ),
    );
  }
}
//Dashboard creation
get dashBg => Column(
      children: <Widget>[
        Expanded(
          child: Container(color: Palette.primaryColor),
          flex: 1,
        ),
        Expanded(
          child: Container(color: Palette.secondaryColor),
          flex: 5,
        ),
      ],
    );

get content => Container(
      child: Column(
        children: <Widget>[
          //  header,
          grid,
        ],
      ),
    );

get grid => Expanded(
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white70,
              style: BorderStyle.solid,
              width: 1.0,
            ),
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0)),
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(15),
        child: Container(
          child: Column(
            children: <Widget>[
              Text(
                'Event Invitation',
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (ctx, int) {
                    return Card(
                      color: Colors.black45,
                      child: ListTile(
                          title: Text('Events $int'),
                          subtitle:
                              Text('This is a description of the events')),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );

Future<void> share() async {
  await FlutterShare.share(
      title: 'Event Invitation',
      text: 'Invitation',
      linkUrl: Palette.url.toString(),
      chooserTitle: 'Event Invitation');
}
