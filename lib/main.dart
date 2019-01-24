import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // declaring that the widget Scaffold's deep widgets will get
    // CountModel model's state access
    return ScopedModel<CountModel>(
        model: new CountModel(),
        child: ScopedModel<DecreaseModel>(
          model: new DecreaseModel(),
          child: Scaffold(
            appBar: AppBar(
              title: Text(widget.title),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'You have pushed the button this many times:',
                  ),
                  ScopedModelDescendant<CountModel>(
                    builder: (context, child, model) {
                      return Text(
                        "${model.counter}",
                        style: Theme.of(context).textTheme.display1,
                      );
                    },
                  ),
                  Text(
                    'You have pushed the button to decrease:',
                  ),
                  ScopedModelDescendant<DecreaseModel>(
                    builder: (context, child, model) {
                      return Text(
                        "${model.value}",
                        style: Theme.of(context).textTheme.display1,
                      );
                    },
                  ),
                  ScopedModelDescendant<DecreaseModel>(
                    builder: (context, child, model) {
                      return MaterialButton(
                        onPressed: () {
                          model.decrease();
                        },
                        child: Text(
                          "Decrease",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.deepPurple,
                      );
                    },
                  ),
                  MaterialButton(
                      onPressed: (){
                        print(context.ancestorWidgetOfExactType(Scaffold));
                      },
                    color: Colors.purple,
                    child: Text("Click",style: TextStyle(color: Colors.white),),
                  )
                ],
              ),
            ),
            floatingActionButton: ScopedModelDescendant<CountModel>(
                builder: (context, child, model) {
              return FloatingActionButton(
                onPressed: () {
                  model.increase();
                },
                tooltip: 'Increment',
                child: Icon(Icons.add),
              );
            }), // This trailing comma makes auto-formatting nicer for build methods.
          ),
        ));
  }
}

class CountModel extends Model {
  int counter = 0;

  void increase() {
    counter++;
    notifyListeners();
  }
}

class DecreaseModel extends Model {
  int value = 10;

  void decrease() {
    value--;
    notifyListeners();
  }
}
