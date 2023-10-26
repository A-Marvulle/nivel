import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ProgressBarDemo(),
    );
  }
}

getShadowColor(int cardIndex) {
  switch (cardIndex) {
    case 1:
      return Colors.red;
    case 2:
      return Colors.yellow[800];
    case 3:
      return Colors.blue[900];
    default:
      return Colors.black;
  }
}

class ProgressBarDemo extends StatefulWidget {
  const ProgressBarDemo({Key? key}) : super(key: key);

  @override
  _ProgressBarDemoState createState() => _ProgressBarDemoState();
}

class _ProgressBarDemoState extends State<ProgressBarDemo>
    with TickerProviderStateMixin {
  double _progressValue1 = 0.0;
  int _completionCount1 = 0;
  double _progressLimit1 = 1.0;

  double _progressValue2 = 0.0;
  int _completionCount2 = 0;
  double _progressLimit2 = 1.0;

  double _progressValue3 = 0.0;
  int _completionCount3 = 0;
  double _progressLimit3 = 1.0;

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  void _increaseProgress(int cardIndex) {
    setState(() {
      switch (cardIndex) {
        case 1:
          _progressValue1 += 0.1;
          if (_progressValue1 >= _progressLimit1) {
            _completionCount1++;
            _progressValue1 = _progressValue1 - _progressLimit1;
            _progressLimit1 += 0.1 * _completionCount1;
            _controller.reset();
            _controller.forward();
          }
          break;
        case 2:
          _progressValue2 += 0.1;
          if (_progressValue2 >= _progressLimit2) {
            _completionCount2++;
            _progressValue2 = _progressValue2 - _progressLimit2;
            _progressLimit2 += 0.1 * _completionCount2;
            _controller.reset();
            _controller.forward();
          }
          break;
        case 3:
          _progressValue3 += 0.1;
          if (_progressValue3 >= _progressLimit3) {
            _completionCount3++;
            _progressValue3 = _progressValue3 - _progressLimit3;
            _progressLimit3 += 0.1 * _completionCount3;
            _controller.reset();
            _controller.forward();
          }
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return SecondScreen(
                          Icons.favorite,
                          _progressLimit1,
                          _completionCount1,
                          'Vida',
                          _progressValue1,
                          1,
                          'vida');
                    },
                  ),
                );
              },
              highlightColor: Colors.red[50],
              hoverColor: Colors.transparent,
              child: CardWithCircularProgressBar(_progressValue1,
                  _progressLimit1, 'Vida', Icons.favorite, 1, 'vida'),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return SecondScreen(
                          Icons.flash_on,
                          _progressLimit2,
                          _completionCount2,
                          'Energia',
                          _progressValue2,
                          2,
                          'energia');
                    },
                  ),
                );
              },
              highlightColor: Colors.yellow[50],
              hoverColor: Colors.transparent,
              child: CardWithCircularProgressBar(_progressValue2,
                  _progressLimit2, 'Energia', Icons.flash_on, 2, 'energia'),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return SecondScreen(
                          Icons.security,
                          _progressLimit3,
                          _completionCount3,
                          'Defesa',
                          _progressValue3,
                          3,
                          'defesa');
                    },
                  ),
                );
              },
              highlightColor: Colors.blue[50],
              hoverColor: Colors.transparent,
              child: CardWithCircularProgressBar(_progressValue3,
                  _progressLimit3, 'Defesa', Icons.security, 3, 'defesa'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => _increaseProgress(1),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Icon(Icons.favorite, color: Colors.white),
                ),
                const SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: () => _increaseProgress(2),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow[800]),
                  child: const Icon(Icons.flash_on, color: Colors.white),
                ),
                const SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: () => _increaseProgress(3),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[900]),
                  child: const Icon(Icons.security, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CardWithCircularProgressBar extends StatelessWidget {
  final double progressValue;
  final double limite;
  final String cornerText;
  final IconData iconData;
  final int cardIndex;
  final String tag;

  const CardWithCircularProgressBar(this.progressValue, this.limite,
      this.cornerText, this.iconData, this.cardIndex, this.tag,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 300,
        child: Hero(
          tag: tag,
          child: Card(
            elevation: 10,
            shadowColor: getShadowColor(cardIndex),
            margin: const EdgeInsets.all(16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TweenAnimationBuilder(
                        tween: Tween<double>(begin: 0, end: progressValue),
                        duration: const Duration(milliseconds: 500),
                        builder: (context, value, child) {
                          return Stack(
                            children: [
                              SizedBox(
                                width: 80,
                                height: 80,
                                child: CircularProgressIndicator(
                                  value: value as double,
                                  color: getShadowColor(cardIndex),
                                  strokeWidth: 10,
                                  backgroundColor: Colors.grey,
                                ),
                              ),
                              Positioned(
                                top: 25,
                                left: 25,
                                child: Icon(
                                  iconData,
                                  color: getShadowColor(cardIndex),
                                  size: 30,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      SizedBox(
                        child: Column(
                          children: [
                            Text(
                              '${(progressValue * 100).toStringAsFixed(0)}/${(limite * 100).toStringAsFixed(0)}',
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.black),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: 65,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: getShadowColor(cardIndex),
                              ),
                              child: Text(
                                cornerText,
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                            ),
                            const SizedBox(height: 10.0),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class SecondScreen extends StatelessWidget {
  final IconData icon;
  final int volta;
  final String texto;
  final double limite;
  final double progresso;
  final int cardIndex;
  final String tag;

  const SecondScreen(this.icon, this.limite, this.volta, this.texto,
      this.progresso, this.cardIndex, this.tag,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(texto), backgroundColor: getShadowColor(cardIndex)),
      body: Center(
        child: Hero(
          tag: tag,
          child: Container(
            margin: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: getShadowColor(cardIndex),
                  blurRadius: 5.0,
                ),
              ],
              color: Colors.white,
            ),
            width: 300,
            height: 125,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0), // Margem interna
                  child: Center(
                    child: Column(
                      children: [
                        Icon(
                          icon,
                          color: getShadowColor(cardIndex),
                          size: 50,
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 80,
                          height: 40,
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: getShadowColor(cardIndex),
                          ),
                          child: Text(
                            texto,
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Atual: ${(progresso * 100).toStringAsFixed(0)}',
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black)),
                      Text('Total: ${(limite * 100).toStringAsFixed(0)}',
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black)),
                      Text('Voltas: $volta',
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
