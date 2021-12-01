import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late PaletteGenerator paletteGenerator;

  Future<PaletteGenerator>_updatePaletteGenerator ()async
  {
    paletteGenerator = await PaletteGenerator.fromImageProvider(
      Image.asset("assets/pokeball.png").image,
    );
    return paletteGenerator;
  }

  List<PaletteColor> getColors(List colors) {
    List<PaletteColor> colorList = [];

    for(PaletteColor c in colors) colorList.add(c);

    return colorList;
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: FutureBuilder(
        future: _updatePaletteGenerator(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {

            List<PaletteColor> colors = getColors(paletteGenerator.paletteColors.toList());

            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: ListView.builder(
                  itemCount: colors.length,
                  itemBuilder: (context,index) {
                    return Container(
                      height: 40,
                      width: 20,
                      decoration: BoxDecoration(
                        color: colors[index].color,
                      ),
                      child: Center(
                        child: Text(
                          colors[index].color.toString(),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
