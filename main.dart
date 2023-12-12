import 'package:flutter/material.dart';
import 'package:simple_3d/simple_3d.dart';
import 'package:util_simple_3d/util_simple_3d.dart';
import 'package:simple_3d_renderer/simple_3d_renderer.dart';

void main() async {
  runApp(const MyApp());
}

String shape = "cube";

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Index(),
    );
  }
}

class Index extends StatelessWidget {
  const Index({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("3D -VR")),
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Sp3dRenderer(
              const Size(400, 400),
              const Sp3dV2D(200, 300),
              shapebuilder(shape),
              Sp3dCamera(Sp3dV3D(0, 0, 3000), 6000),
              Sp3dLight(Sp3dV3D(0, 0, -1), syncCam: true),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return const Settings();
          }));
        }, child: const Icon(Icons.settings),),
      ),
    );
  }
}

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              IconButton(onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return const Index();
                }));
              }, icon: const Icon(Icons.arrow_back)),
              const Text("Settings")
            ],
          ),
        ),
        body: Column(
          children: [
            const SizedBox(height: 20,),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                Text("Select shape ", style: TextStyle(fontSize: 23),),
                DropDownWidget(),
              ],),
            ),
            ElevatedButton(onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return const Index();
              }));
            }, child: const Text("Apply")),
            const Text("Made by Abhineet Raj")
          ],
        ),
      ),
    );
  }
}

class DropDownWidget extends StatefulWidget {
  const DropDownWidget({super.key});

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        value: shape,
        items: const [
          DropdownMenuItem(value: "cube", child: Text("cube")),
          DropdownMenuItem(value: "capsule", child: Text("capsule")),
          DropdownMenuItem(value: "cone", child: Text("cone")),
          DropdownMenuItem(value: "circle", child: Text("circle")),
          DropdownMenuItem(value: "sphere", child: Text("sphere")),
          DropdownMenuItem(value: "pillar", child: Text("pillar")),
          DropdownMenuItem(value: "tile", child: Text("tile")),
        ], onChanged: (value) {
      setState(() {
        shape = value!;
      });
    }
    );
  }
}

Sp3dWorld shapebuilder(String shape) {
  if (shape == "capsule") {
    return Sp3dWorld([UtilSp3dGeometry.capsule(50, 160)]);
  } else if (shape == "circle") {
    return Sp3dWorld([UtilSp3dGeometry.circle(100)]);
  } else if (shape == "cone") {
    return Sp3dWorld([UtilSp3dGeometry.cone(50, 100)]);
  } else if (shape == "cube") {
    return Sp3dWorld([UtilSp3dGeometry.cube(100, 100, 100, 1, 1, 1)]);
  } else if (shape == "pillar") {
    return Sp3dWorld([UtilSp3dGeometry.pillar(50, 50, 150)]);
  } else if (shape == "sphere") {
    return Sp3dWorld([UtilSp3dGeometry.sphere(100)]);
  } else {
    return Sp3dWorld([UtilSp3dGeometry.tile(100, 50, 40, 20)]);
  }
}