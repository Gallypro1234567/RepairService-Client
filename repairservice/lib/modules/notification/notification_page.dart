import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:signalr_client/signalr_client.dart';
import '../../../utils/service/server_hosting.dart' as Host;

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final serverUrl =
      Uri.http(Host.Server_hosting, "/notificationhub").toString();
  final serverUrls = "http://repairservice.somee.com/notificationhub";
  HubConnection hubConnection;
  double width = 100, height = 100;
  Offset positon;

  @override
  void initState() {
    super.initState();
    initialSignalR();
    positon = Offset(0.0, -20.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: AppTheme.fullHeight(context) * .06,
        title: Text("Thông báo"),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          Positioned(
              left: positon.dx,
              top: positon.dy,
              child: Draggable(
                child: Container(
                    width: width,
                    height: height,
                    color: Colors.blue,
                    child: Center(
                        child: Text(
                      "Move me",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ))),
                feedback: Container(
                    width: width,
                    height: height,
                    color: Colors.red[900],
                    child: Center(
                        child: Text(
                      "Move me",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ))),
                onDraggableCanceled: (velocity, offset) async {
                  if (hubConnection.state == HubConnectionState.Connected) {
                    await hubConnection.invoke("MoveViewFromServer",
                        args: <Object>[offset.dx, offset.dy]);
                  }
                  setState(() {
                    positon = offset;
                  });
                },
              )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            hubConnection.state == HubConnectionState.Disconnected
                ? await hubConnection.start()
                : await hubConnection.stop();
          } on Exception catch (Ex) {
            print(Ex);
          }
        },
        tooltip: "Start/Stop",
        child: hubConnection.state == HubConnectionState.Disconnected
            ? Icon(Icons.play_arrow)
            : Icon(Icons.stop),
      ),
    );
  }

  void initialSignalR() {
    hubConnection = HubConnectionBuilder().withUrl(serverUrls).build();
    hubConnection.onclose((error) => print("Connection Error"));
    hubConnection.on("ReceiveNewPosition", _handNewPosition);
    hubConnection.start();
    print(hubConnection.state);
  }

  _handNewPosition(List<Object> args) {
    setState(() {
      positon = Offset(args[0], args[1]);
    });
  }
}
