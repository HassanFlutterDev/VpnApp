// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print

import 'dart:convert';
import 'dart:developer';
import 'package:flutter_vpn/flutter_vpn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_vpn/state.dart';
import 'package:freevpn/controllers/home_controller.dart';
import 'package:freevpn/main.dart';
import 'package:freevpn/views/location_screen.dart';
import 'package:freevpn/views/selectcountry/select_country.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:openvpn_flutter/openvpn_flutter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  OpenVPN? engine;
  VpnStatus? status;
  VPNStage? stage;
  bool _granted = false;
  final _controller = Get.put(HomeController());
  var state = FlutterVpnState.disconnected;
  @override
  void initState() {
    engine = OpenVPN(
      onVpnStatusChanged: (data) {
        setState(() {
          status = data;
        });
      },
      onVpnStageChanged: (data, raw) {
        setState(() {
          stage = data;
        });
      },
    );
    engine!.initialize(
      groupIdentifier: "group.com.beatircealbero.vpnapp",
      providerBundleIdentifier: "com.beatircealbero.vpnapp.VPNExtension",
      localizedDescription: "VPN Hassan",
      lastStage: (stage) {
        setState(() {
          this.stage = stage;
        });
      },
      lastStatus: (status) {
        setState(() {
          this.status = status;
        });
      },
    );
    FlutterVpn.prepare();
    FlutterVpn.onStateChanged.listen((s) {
      if (s == FlutterVpnState.connected) {
        // Device Connected
      }
      if (s == FlutterVpnState.disconnected) {
        // Device Disconnected
      }
      setState(() {
        state = s;
      });
    });
    super.initState();
  }

  Future<void> initPlatformState(
      String config, username, password, country) async {
    try {
      print(config);
      if (state == FlutterVpnState.connected) {
        FlutterVpn.disconnect();
      } else {
        FlutterVpn.connectIkev2EAP(
            server: "35.229.109.225.sslip.io",
            username: "tensai",
            password: "tensai321@");
      }
      // engine!.connect(
      //   config,
      //   country,
      //   username: username,
      //   password: password,
      //   certIsRequired: true,
      // );
      print("connect");
      if (!mounted) return;
    } catch (e) {
      log(e.toString());
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Container(
                        width: 30,
                        height: 30,
                        child: Icon(
                          Icons.shield_outlined,
                          size: 28,
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'FREE VPN',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w900),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          'will always remain free',
                          style: TextStyle(
                              fontSize: 12, height: -0.1, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color.fromARGB(255, 216, 216, 216),
                          )),
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/crown.png',
                              height: 25,
                              width: 30,
                              color: Color.fromARGB(178, 231, 180, 12),
                            ),
                            Text(
                              'AD FREE',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: const Color.fromARGB(255, 216, 216, 216),
                            )),
                        child: Icon(
                          Icons.share_outlined,
                          size: 25,
                        )),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 60,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/worldmap.png'),
          ),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              Get.to(LocationScreen(), transition: Transition.rightToLeft);
            },
            child: Container(
              width: 252,
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color:
                            Color.fromARGB(255, 238, 238, 238), // shadow color
                        spreadRadius: 0.5, // spread radius
                        blurRadius: 4,
                        offset: Offset(1, 4) // blur radius
                        ),
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage('assets/Germenflag.png'),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Germany',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.w600),
                        ),
                        // SizedBox(
                        //   height: 8,
                        // ),
                        Text(
                          'Stream Optimized',
                          style: TextStyle(
                              fontSize: 13, height: 0, color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 25,
                      color: Color.fromARGB(255, 206, 204, 204),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Text(
            state == FlutterVpnState.connecting
                ? 'Connecting..'
                : state == FlutterVpnState.connected
                    ? 'Connected'
                    : 'You are not connected',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: 270,
            height: 40,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 248, 246, 246),
                borderRadius: BorderRadius.circular(20)),
            child: Center(
              child: Text(
                'Tap to connect for secure connection',
                style: TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              final controller = Get.find<HomeController>();
              final data = Base64Decoder()
                  .convert(controller.vpn.value.openVPNConfigDataBase64);
              final config = Utf8Decoder().convert(data);
              initPlatformState(
                config,
                'vpn',
                'vpn',
                controller.vpn.value.countryShort,
              );
            },
            child: Container(
              width: 200,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.black,
              ),
              child: Center(
                child: Text('Connect',
                    style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
              ),
            ),
          ),
          Text(stage?.toString() ?? VPNStage.disconnected.toString()),
          Text(status?.toJson().toString() ?? ""),
          TextButton(
            child: const Text("STOP"),
            onPressed: () {
              engine!.disconnect();
            },
          ),
          SizedBox(
            height: 0,
          ),
          Text('REMAINING REWARDED TIME',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey)),
          Text('00:00:00',
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.w600,
              )),
        ],
      ),
    );
  }
}
