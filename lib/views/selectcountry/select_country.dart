// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class SelectCountryScreen extends StatefulWidget {
  const SelectCountryScreen({super.key});

  @override
  State<SelectCountryScreen> createState() => _SelectCountryScreenState();
}

class _SelectCountryScreenState extends State<SelectCountryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Choose Server',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          SizedBox(
            height: 40,
            width: 40,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Divider(
            height: 1,
            color: const Color.fromARGB(255, 225, 225, 225),
          ),
          ListTile(
            leading: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                ),
              ),
              child: Center(
                child: Text(
                  'A',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            title: Text(
              'Fastest Server',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              'Auto Select Fast Server',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ),
          ),
          Divider(
            height: 1,
            color: const Color.fromARGB(255, 225, 225, 225),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage('assets/Germenflag.png'),
                    ),
                    title: Text(
                      'Germany',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'Stream Optimized',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: const Color.fromARGB(255, 225, 225, 225),
                  ),
                ],
              );
            },
          ),
        ]),
      ),
    );
  }
}
