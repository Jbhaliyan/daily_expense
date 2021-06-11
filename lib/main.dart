import 'package:flutter/services.dart';
import 'widgets/chart.dart';
import 'package:flutter/material.dart';
import 'models/expense.dart';
import 'widgets/expense_list.dart';
import 'widgets/new_expense.dart';

void main() {
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primaryColor: Colors.purple,
        primarySwatch: Colors.purple,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Expense> _userExpense = [];
  bool _showChart = false;
  List<Expense> get _recentExpense {
    return (_userExpense.where((txt) {
      return txt.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList());
  }

  void _addNewExpense(String title, double amt, DateTime chosenDate) {
    final newEx = Expense(
        id: DateTime.now().toString(),
        title: title,
        amt: amt,
        date: chosenDate);
    // final newAmt = amt;
    setState(() {
      _userExpense.add(newEx);
    });
  }

  void _startNewExpense(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: NewExpense(_addNewExpense));
      },
    );
  }

  void _deleteExpense(String id) {
    setState(() {
      _userExpense.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery=MediaQuery.of(context);
    final isLandscape =
         mediaQuery.orientation == Orientation.landscape;

    final appBar = AppBar(
      title: Text('Daily Expense'),
      actions: [
        IconButton(
          onPressed: () => _startNewExpense(context),
          icon: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ],
    );
    final exList = Container(
        height: ( mediaQuery.size.height -
                appBar.preferredSize.height -
                 mediaQuery.padding.top) *
            0.7,
        child: ExpenseList(_userExpense, _deleteExpense));
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLandscape)
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text("Show Chart"),
                Switch(
                  value: _showChart,
                  onChanged: (val) {
                    setState(() {
                      _showChart = val;
                    });
                  },
                ),
              ]),
            if (!isLandscape)
              Container(
                  height: ( mediaQuery.size.height -
                          appBar.preferredSize.height -
                          mediaQuery.padding.top) *
                      0.3,
                  child: Chart(_recentExpense)),
            if (!isLandscape) exList,
            if (isLandscape)
              _showChart
                  ? Container(
                      height: ( mediaQuery.size.height -
                              appBar.preferredSize.height -
                               mediaQuery.padding.top) *
                          0.4,
                      child: Chart(_recentExpense))
                  : exList,
          ],
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startNewExpense(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
