import 'package:election_ethereum/candidate_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context)=> CandidateState(),),
    ],
    child: MyApp(),
    )
    );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
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
  void initState() {
    //context.read()<CandidateState>().fetchCandidate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SafeArea(
            child: FutureBuilder(
              future: Provider.of<CandidateState>(context, listen: false).fetchCandidate(),
              builder: (context, snapshot){
                if(snapshot.hasData){
                  return Container();
                }
                return ListView.builder(                
                  itemCount: context.watch<CandidateState>().candidates.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: Icon(Icons.person),
                      title: Text(context.watch<CandidateState>().candidates[index].name),
                      trailing: Text(context.watch<CandidateState>().candidates[index].votes.toString()),
                    );
                  });
              },
                    
            )));
  }
}
