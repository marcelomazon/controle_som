import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  AudioPlayer audioPlayer = AudioPlayer();
  // pluguin já pega na pasta assests por padrão
  AudioCache audioCache = AudioCache(prefix: "audios/");
  bool primeiraExecucao = true;
  double _volume = 0.5;

  _executarSom() async {
    audioPlayer.setVolume(_volume);
    if (primeiraExecucao) {
      audioPlayer = await audioCache.play("musica.mp3");
      primeiraExecucao = false;
    } else {
      audioPlayer.resume();
    }
  }

  _pausarSom() async {
    await audioPlayer.pause();
  }

  _pararSom() async {
    await audioPlayer.stop();
    primeiraExecucao = true;
  }

  @override
  Widget build(BuildContext context) {

    //_executarSom();

    return Scaffold(
      appBar: AppBar(
        title: Text("Executando som"),
      ),
      body: Column(
        children: [
          Slider(
            value: _volume,
            min: 0,
            max: 1,
            onChanged: (valor) {
              setState(() {
                _volume = valor;
              });
              audioPlayer.setVolume(_volume);
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //1
              Padding(
                padding: EdgeInsets.all(8),
                child: GestureDetector(
                  child: Image.asset("assets/images/executar.png"),
                  onTap: () {
                    _executarSom();
                  },
                ),
              ),
              //2
              Padding(
                padding: EdgeInsets.all(8),
                child: GestureDetector(
                  child: Image.asset("assets/images/pausar.png"),
                  onTap: () {
                    _pausarSom();
                  },
                ),
              ),
              //3
              Padding(
                padding: EdgeInsets.all(8),
                child: GestureDetector(
                  child: Image.asset("assets/images/parar.png"),
                  onTap: () {
                    _pararSom();
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
