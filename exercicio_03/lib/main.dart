import 'package:flutter/material.dart';

void main() => runApp(const HomePage());

const red = Colors.red;
const green = Colors.green;
const blue = Colors.lightBlue;
const big = TextStyle(fontSize: 30);

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const FlutterLayoutArticle([
      Example1(),
      Example2(),
      Example3(),
      Example4(),
      Example5(),
      Example6(),
      Example7(),
      Example8(),
      Example9(),
      Example10(),
      Example11(),
      Example12(),
      Example13(),
      Example14(),
      Example15(),
      Example16(),
      Example17(),
      Example18(),
      Example19(),
      Example20(),
      Example21(),
      Example22(),
      Example23(),
      Example24(),
      Example25(),
      Example26(),
      Example27(),
      Example28(),
      Example29(),
    ]);
  }
}

abstract class Example extends StatelessWidget {
  const Example({super.key});

  String get code;

  String get explanation;
}

class FlutterLayoutArticle extends StatefulWidget {
  const FlutterLayoutArticle(this.examples, {super.key});

  final List<Example> examples;

  @override
  State<FlutterLayoutArticle> createState() => _FlutterLayoutArticleState();
}

class _FlutterLayoutArticleState extends State<FlutterLayoutArticle> {
  late int count;
  late String code;
  late String explanation;

  @override
  void initState() {
    count = 1;
    code = const Example1().code;
    explanation = const Example1().explanation;
    super.initState();
  }

  @override
  void didUpdateWidget(FlutterLayoutArticle oldWidget) {
    super.didUpdateWidget(oldWidget);
    var example = widget.examples[count - 1];
    code = example.code;
    explanation = example.explanation;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Layout Article',
      home: SafeArea(
        child: Material(
          color: Colors.black,
          child: FittedBox(
            child: Container(
              width: 400,
              height: 670,
              color: const Color(0xFFCCCCCC),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints.tightFor(
                        width: double.infinity,
                        height: double.infinity,
                      ),
                      child: widget.examples[count - 1],
                    ),
                  ),
                  Container(
                    height: 50,
                    width: double.infinity,
                    color: Colors.black,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          for (int i = 0; i < widget.examples.length; i++)
                            Container(
                              width: 58,
                              padding: const EdgeInsets.only(left: 4, right: 4),
                              child: button(i + 1),
                            ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 273,
                    color: Colors.grey[50],
                    child: Scrollbar(
                      child: SingleChildScrollView(
                        key: ValueKey(count),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Center(child: Text(code)),
                              const SizedBox(height: 15),
                              Text(
                                explanation,
                                style: TextStyle(
                                  color: Colors.blue[900],
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget button(int exampleNumber) {
    return Button(
      key: ValueKey('button$exampleNumber'),
      isSelected: count == exampleNumber,
      exampleNumber: exampleNumber,
      onPressed: () {
        showExample(
          exampleNumber,
          widget.examples[exampleNumber - 1].code,
          widget.examples[exampleNumber - 1].explanation,
        );
      },
    );
  }

  void showExample(int exampleNumber, String code, String explanation) {
    setState(() {
      count = exampleNumber;
      this.code = code;
      this.explanation = explanation;
    });
  }
}

class Button extends StatelessWidget {
  final bool isSelected;
  final int exampleNumber;
  final VoidCallback onPressed;

  const Button({
    super.key,
    required this.isSelected,
    required this.exampleNumber,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: isSelected ? Colors.grey : Colors.grey[800],
      ),
      child: Text(exampleNumber.toString()),
      onPressed: () {
        Scrollable.ensureVisible(
          context,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeOut,
          alignment: 0.5,
        );
        onPressed();
      },
    );
  }
}

class Example1 extends Example {
  const Example1({super.key});

  @override
  final code = 'Container(color: red)';

  @override
  final explanation =
      'A tela é o pai do Container, e força o Container a ter exatamente '
      'o mesmo tamanho da tela.'
      '\n\n'
      'Por isso o Container preenche a tela e a pinta de vermelho.';

  @override
  Widget build(BuildContext context) {
    return Container(color: red);
  }
}

class Example2 extends Example {
  const Example2({super.key});

  @override
  final code = 'Container(width: 100, height: 100, color: red)';

  @override
  final String explanation =
      'O Container vermelho quer ter 100x100, mas não pode, porque a tela '
      'o força a ter exatamente o mesmo tamanho da tela.'
      '\n\n'
      'Então o Container preenche a tela.';

  @override
  Widget build(BuildContext context) {
    return Container(width: 100, height: 100, color: red);
  }
}

class Example3 extends Example {
  const Example3({super.key});

  @override
  final code =
      'Center(\n'
      '   child: Container(width: 100, height: 100, color: red))';

  @override
  final String explanation =
      'A tela força o Center a ter exatamente o tamanho da tela. '
      'Então o Center preenche a tela.'
      '\n\n'
      'O Center diz ao Container que ele pode ter qualquer tamanho que quiser, '
      'mas não maior que a tela. Agora o Container pode de fato ter 100x100.';

  @override
  Widget build(BuildContext context) {
    return Center(child: Container(width: 100, height: 100, color: red));
  }
}

class Example4 extends Example {
  const Example4({super.key});

  @override
  final code =
      'Align(\n'
      '   alignment: Alignment.bottomRight,\n'
      '   child: Container(width: 100, height: 100, color: red))';

  @override
  final String explanation =
      'Isso é diferente do exemplo anterior porque usa Align em vez de Center.'
      '\n\n'
      'O Align também diz ao Container que ele pode ter qualquer tamanho, '
      'mas se houver espaço vazio ele não centraliza o Container, '
      'e sim o alinha ao canto inferior direito do espaço disponível.';

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(width: 100, height: 100, color: red),
    );
  }
}

class Example5 extends Example {
  const Example5({super.key});

  @override
  final code =
      'Center(\n'
      '   child: Container(\n'
      '              color: red,\n'
      '              width: double.infinity,\n'
      '              height: double.infinity))';

  @override
  final String explanation =
      'A tela força o Center a ter exatamente o tamanho da tela. '
      'Então o Center preenche a tela.'
      '\n\n'
      'O Center diz ao Container que ele pode ter qualquer tamanho, mas não '
      'maior que a tela. O Container quer ter tamanho infinito, mas como não '
      'pode ser maior que a tela, ele apenas preenche a tela.';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: red,
      ),
    );
  }
}

class Example6 extends Example {
  const Example6({super.key});

  @override
  final code = 'Center(child: Container(color: red))';

  @override
  final String explanation =
      'A tela força o Center a ter exatamente o tamanho da tela. '
      'Então o Center preenche a tela.'
      '\n\n'
      'O Center diz ao Container que ele pode ter qualquer tamanho, mas não '
      'maior que a tela. Como o Container não tem filho nem tamanho fixo, '
      'ele decide que quer ser o maior possível, então preenche a tela inteira.'
      '\n\n'
      'Por que o Container decide isso? Porque essa é uma decisão de design '
      'de quem criou o widget Container.';

  @override
  Widget build(BuildContext context) {
    return Center(child: Container(color: red));
  }
}

class Example7 extends Example {
  const Example7({super.key});

  @override
  final code =
      'Center(\n'
      '   child: Container(color: red\n'
      '      child: Container(color: green, width: 30, height: 30)))';

  @override
  final String explanation =
      'A tela força o Center a ter exatamente o tamanho da tela. '
      'Então o Center preenche a tela.'
      '\n\n'
      'O Center diz ao Container vermelho que ele pode ter qualquer tamanho, '
      'mas não maior que a tela. Como o Container vermelho não tem tamanho, '
      'mas tem um filho, ele decide ter o mesmo tamanho do filho.'
      '\n\n'
      'O Container vermelho diz ao filho que ele pode ter qualquer tamanho, '
      'mas não maior que a tela.'
      '\n\n'
      'O filho é um Container verde que quer ter 30x30. '
      'Como o vermelho se ajusta ao tamanho do filho, ele também tem 30x30. '
      'A cor vermelha não aparece porque o verde a cobre totalmente.';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: red,
        child: Container(color: green, width: 30, height: 30),
      ),
    );
  }
}

class Example8 extends Example {
  const Example8({super.key});

  @override
  final code =
      'Center(\n'
      '   child: Container(color: red\n'
      '      padding: const EdgeInsets.all(20),\n'
      '      child: Container(color: green, width: 30, height: 30)))';

  @override
  final String explanation =
      'O Container vermelho se ajusta ao tamanho do filho, mas leva em conta '
      'o próprio padding. Então ele também tem 30x30 mais 20 de padding '
      'em cada lado. A cor vermelha fica visível por causa do padding, '
      'e o Container verde tem o mesmo tamanho do exemplo anterior.';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        color: red,
        child: Container(color: green, width: 30, height: 30),
      ),
    );
  }
}

class Example9 extends Example {
  const Example9({super.key});

  @override
  final code =
      'ConstrainedBox(\n'
      '   constraints: BoxConstraints(\n'
      '              minWidth: 70, minHeight: 70,\n'
      '              maxWidth: 150, maxHeight: 150),\n'
      '      child: Container(color: red, width: 10, height: 10)))';

  @override
  final String explanation =
      'Você poderia imaginar que o Container teria entre 70 e 150 pixels, '
      'mas não é isso que acontece. O ConstrainedBox só impõe restrições '
      'ADICIONAIS àquelas que recebe do pai.'
      '\n\n'
      'Aqui, a tela força o ConstrainedBox a ter exatamente o tamanho da tela, '
      'então ele diz ao Container filho para também assumir o tamanho da tela, '
      'ignorando o parâmetro "constraints".';

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: 70,
        minHeight: 70,
        maxWidth: 150,
        maxHeight: 150,
      ),
      child: Container(color: red, width: 10, height: 10),
    );
  }
}

class Example10 extends Example {
  const Example10({super.key});

  @override
  final code =
      'Center(\n'
      '   child: ConstrainedBox(\n'
      '      constraints: BoxConstraints(\n'
      '                 minWidth: 70, minHeight: 70,\n'
      '                 maxWidth: 150, maxHeight: 150),\n'
      '        child: Container(color: red, width: 10, height: 10))))';

  @override
  final String explanation =
      'Agora o Center permite que o ConstrainedBox tenha qualquer tamanho '
      'até o tamanho da tela.'
      '\n\n'
      'O ConstrainedBox impõe as restrições ADICIONAIS do seu parâmetro '
      '"constraints" ao filho.'
      '\n\n'
      'O Container precisa ficar entre 70 e 150 pixels. Ele queria ter '
      '10 pixels, então acaba tendo 70 (o MÍNIMO).';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 70,
          minHeight: 70,
          maxWidth: 150,
          maxHeight: 150,
        ),
        child: Container(color: red, width: 10, height: 10),
      ),
    );
  }
}

class Example11 extends Example {
  const Example11({super.key});

  @override
  final code =
      'Center(\n'
      '   child: ConstrainedBox(\n'
      '      constraints: BoxConstraints(\n'
      '                 minWidth: 70, minHeight: 70,\n'
      '                 maxWidth: 150, maxHeight: 150),\n'
      '        child: Container(color: red, width: 1000, height: 1000))))';

  @override
  final String explanation =
      'O Center permite que o ConstrainedBox tenha qualquer tamanho até o '
      'tamanho da tela. O ConstrainedBox impõe as restrições ADICIONAIS do '
      'seu parâmetro "constraints" ao filho.'
      '\n\n'
      'O Container precisa ficar entre 70 e 150 pixels. Ele queria ter '
      '1000 pixels, então acaba tendo 150 (o MÁXIMO).';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 70,
          minHeight: 70,
          maxWidth: 150,
          maxHeight: 150,
        ),
        child: Container(color: red, width: 1000, height: 1000),
      ),
    );
  }
}

class Example12 extends Example {
  const Example12({super.key});

  @override
  final code =
      'Center(\n'
      '   child: ConstrainedBox(\n'
      '      constraints: BoxConstraints(\n'
      '                 minWidth: 70, minHeight: 70,\n'
      '                 maxWidth: 150, maxHeight: 150),\n'
      '        child: Container(color: red, width: 100, height: 100))))';

  @override
  final String explanation =
      'O Center permite que o ConstrainedBox tenha qualquer tamanho até o '
      'tamanho da tela. O ConstrainedBox impõe as restrições ADICIONAIS do '
      'seu parâmetro "constraints" ao filho.'
      '\n\n'
      'O Container precisa ficar entre 70 e 150 pixels. Ele queria ter '
      '100 pixels, e esse é o tamanho que ele tem, pois está entre 70 e 150.';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 70,
          minHeight: 70,
          maxWidth: 150,
          maxHeight: 150,
        ),
        child: Container(color: red, width: 100, height: 100),
      ),
    );
  }
}

class Example13 extends Example {
  const Example13({super.key});

  @override
  final code =
      'UnconstrainedBox(\n'
      '   child: Container(color: red, width: 20, height: 50));';

  @override
  final String explanation =
      'A tela força o UnconstrainedBox a ter exatamente o tamanho da tela. '
      'Porém, o UnconstrainedBox deixa o Container filho ter qualquer tamanho '
      'que quiser.';

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Container(color: red, width: 20, height: 50),
    );
  }
}

class Example14 extends Example {
  const Example14({super.key});

  @override
  final code =
      'UnconstrainedBox(\n'
      '   child: Container(color: red, width: 4000, height: 50));';

  @override
  final String explanation =
      'A tela força o UnconstrainedBox a ter exatamente o tamanho da tela, '
      'e o UnconstrainedBox deixa o Container filho ter qualquer tamanho.'
      '\n\n'
      'Infelizmente, neste caso o Container tem 4000 pixels de largura e é '
      'grande demais para caber no UnconstrainedBox, então o UnconstrainedBox '
      'exibe o temido "aviso de overflow".';

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Container(color: red, width: 4000, height: 50),
    );
  }
}

class Example15 extends Example {
  const Example15({super.key});

  @override
  final code =
      'OverflowBox(\n'
      '   minWidth: 0,\n'
      '   minHeight: 0,\n'
      '   maxWidth: double.infinity,\n'
      '   maxHeight: double.infinity,\n'
      '   child: Container(color: red, width: 4000, height: 50));';

  @override
  final String explanation =
      'A tela força o OverflowBox a ter exatamente o tamanho da tela, '
      'e o OverflowBox deixa o Container filho ter qualquer tamanho.'
      '\n\n'
      'O OverflowBox é parecido com o UnconstrainedBox, a diferença é que ele '
      'não exibe nenhum aviso se o filho não couber no espaço.'
      '\n\n'
      'Neste caso o Container tem 4000 pixels de largura e é grande demais '
      'para caber no OverflowBox, mas o OverflowBox simplesmente mostra o que '
      'consegue, sem nenhum aviso.';

  @override
  Widget build(BuildContext context) {
    return OverflowBox(
      minWidth: 0,
      minHeight: 0,
      maxWidth: double.infinity,
      maxHeight: double.infinity,
      child: Container(color: red, width: 4000, height: 50),
    );
  }
}

class Example16 extends Example {
  const Example16({super.key});

  @override
  final code =
      'UnconstrainedBox(\n'
      '   child: Container(color: Colors.red, width: double.infinity, height: 100));';

  @override
  final String explanation =
      'Isso não renderiza nada, e você verá um erro no console.'
      '\n\n'
      'O UnconstrainedBox deixa o filho ter qualquer tamanho, mas o filho é um '
      'Container com tamanho infinito.'
      '\n\n'
      'O Flutter não consegue renderizar tamanhos infinitos, então lança um '
      'erro com a mensagem: "BoxConstraints forces an infinite width."';

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Container(color: Colors.red, width: double.infinity, height: 100),
    );
  }
}

class Example17 extends Example {
  const Example17({super.key});

  @override
  final code =
      'UnconstrainedBox(\n'
      '   child: LimitedBox(maxWidth: 100,\n'
      '      child: Container(color: Colors.red,\n'
      '                       width: double.infinity, height: 100));';

  @override
  final String explanation =
      'Aqui você não terá mais erro, porque quando o LimitedBox recebe um '
      'tamanho infinito do UnconstrainedBox, ele repassa ao filho uma largura '
      'máxima de 100.'
      '\n\n'
      'Se você trocar o UnconstrainedBox por um Center, o LimitedBox não '
      'aplicaria mais o limite (já que só aplica quando recebe restrições '
      'infinitas), e o Container poderia crescer além de 100.'
      '\n\n'
      'Isso explica a diferença entre um LimitedBox e um ConstrainedBox.';

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: LimitedBox(
        maxWidth: 100,
        child: Container(
          color: Colors.red,
          width: double.infinity,
          height: 100,
        ),
      ),
    );
  }
}

class Example18 extends Example {
  const Example18({super.key});

  @override
  final code =
      'FittedBox(\n'
      '   child: Text(\'Some Example Text.\'));';

  @override
  final String explanation =
      'A tela força o FittedBox a ter exatamente o tamanho da tela. '
      'O Text tem uma largura natural (também chamada de largura intrínseca) '
      'que depende da quantidade de texto, do tamanho da fonte e assim por diante.'
      '\n\n'
      'O FittedBox deixa o Text ter qualquer tamanho que quiser, mas depois '
      'que o Text informa seu tamanho ao FittedBox, o FittedBox escala o Text '
      'até que ele preencha toda a largura disponível.';

  @override
  Widget build(BuildContext context) {
    return const FittedBox(child: Text('Some Example Text.'));
  }
}

class Example19 extends Example {
  const Example19({super.key});

  @override
  final code =
      'Center(\n'
      '   child: FittedBox(\n'
      '      child: Text(\'Some Example Text.\')));';

  @override
  final String explanation =
      'Mas o que acontece se você colocar o FittedBox dentro de um Center? '
      'O Center deixa o FittedBox ter qualquer tamanho até o tamanho da tela.'
      '\n\n'
      'O FittedBox então se ajusta ao tamanho do Text, e deixa o Text ter '
      'qualquer tamanho. Como o FittedBox e o Text têm o mesmo tamanho, '
      'nenhuma escala acontece.';

  @override
  Widget build(BuildContext context) {
    return const Center(child: FittedBox(child: Text('Some Example Text.')));
  }
}

class Example20 extends Example {
  const Example20({super.key});

  @override
  final code =
      'Center(\n'
      '   child: FittedBox(\n'
      '      child: Text(\'…\')));';

  @override
  final String explanation =
      'Porém, o que acontece se o FittedBox estiver dentro de um Center, '
      'mas o Text for grande demais para caber na tela?'
      '\n\n'
      'O FittedBox tenta se ajustar ao tamanho do Text, mas não pode ser maior '
      'que a tela. Então ele assume o tamanho da tela e redimensiona o Text '
      'para que ele caiba na tela também.';

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: FittedBox(
        child: Text(
          'This is some very very very large text that is too big to fit a regular screen in a single line.',
        ),
      ),
    );
  }
}

class Example21 extends Example {
  const Example21({super.key});

  @override
  final code =
      'Center(\n'
      '   child: Text(\'…\'));';

  @override
  final String explanation =
      'Se, porém, você remover o FittedBox, o Text recebe sua largura máxima '
      'da tela e quebra a linha para caber na tela.';

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'This is some very very very large text that is too big to fit a regular screen in a single line.',
      ),
    );
  }
}

class Example22 extends Example {
  const Example22({super.key});

  @override
  final code =
      'FittedBox(\n'
      '   child: Container(\n'
      '      height: 20, width: double.infinity));';

  @override
  final String explanation =
      'O FittedBox só consegue escalar um widget que seja limitado '
      '(ou seja, que tenha largura e altura não infinitas). Caso contrário, '
      'ele não renderiza nada, e você verá um erro no console.';

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(height: 20, width: double.infinity, color: Colors.red),
    );
  }
}

class Example23 extends Example {
  const Example23({super.key});

  @override
  final code =
      'Row(children:[\n'
      '   Container(color: red, child: Text(\'Hello!\'))\n'
      '   Container(color: green, child: Text(\'Goodbye!\'))]';

  @override
  final String explanation =
      'A tela força a Row a ter exatamente o tamanho da tela.'
      '\n\n'
      'Assim como um UnconstrainedBox, a Row não impõe nenhuma restrição aos '
      'filhos, e deixa que eles tenham o tamanho que quiserem.'
      '\n\n'
      'A Row então os coloca lado a lado, e qualquer espaço extra fica vazio.';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          color: red,
          child: const Text('Hello!', style: big),
        ),
        Container(
          color: green,
          child: const Text('Goodbye!', style: big),
        ),
      ],
    );
  }
}

class Example24 extends Example {
  const Example24({super.key});

  @override
  final code =
      'Row(children:[\n'
      '   Container(color: red, child: Text(\'…\'))\n'
      '   Container(color: green, child: Text(\'Goodbye!\'))]';

  @override
  final String explanation =
      'Como a Row não impõe nenhuma restrição aos filhos, é bem possível que '
      'os filhos sejam grandes demais para caber na largura disponível da Row. '
      'Nesse caso, assim como um UnconstrainedBox, a Row exibe o '
      '"aviso de overflow".';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          color: red,
          child: const Text(
            'This is a very long text that '
            'won\'t fit the line.',
            style: big,
          ),
        ),
        Container(
          color: green,
          child: const Text('Goodbye!', style: big),
        ),
      ],
    );
  }
}

class Example25 extends Example {
  const Example25({super.key});

  @override
  final code =
      'Row(children:[\n'
      '   Expanded(\n'
      '       child: Container(color: red, child: Text(\'…\')))\n'
      '   Container(color: green, child: Text(\'Goodbye!\'))]';

  @override
  final String explanation =
      'Quando um filho da Row é envolvido por um Expanded, a Row não deixa mais '
      'esse filho definir a própria largura.'
      '\n\n'
      'Em vez disso, ela define a largura do Expanded de acordo com os outros '
      'filhos, e só então o Expanded força o filho original a ter a largura '
      'do Expanded.'
      '\n\n'
      'Em outras palavras, ao usar Expanded, a largura original do filho '
      'passa a ser irrelevante e é ignorada.';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Center(
            child: Container(
              color: red,
              child: const Text(
                'This is a very long text that won\'t fit the line.',
                style: big,
              ),
            ),
          ),
        ),
        Container(
          color: green,
          child: const Text('Goodbye!', style: big),
        ),
      ],
    );
  }
}

class Example26 extends Example {
  const Example26({super.key});

  @override
  final code =
      'Row(children:[\n'
      '   Expanded(\n'
      '       child: Container(color: red, child: Text(\'…\')))\n'
      '   Expanded(\n'
      '       child: Container(color: green, child: Text(\'Goodbye!\'))]';

  @override
  final String explanation =
      'Se todos os filhos da Row forem envolvidos por widgets Expanded, '
      'cada Expanded terá um tamanho proporcional ao seu parâmetro flex, '
      'e só então cada Expanded força seu filho a ter a largura do Expanded.'
      '\n\n'
      'Em outras palavras, o Expanded ignora a largura preferida dos filhos.';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            color: red,
            child: const Text(
              'This is a very long text that won\'t fit the line.',
              style: big,
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: green,
            child: const Text('Goodbye!', style: big),
          ),
        ),
      ],
    );
  }
}

class Example27 extends Example {
  const Example27({super.key});

  @override
  final code =
      'Row(children:[\n'
      '   Flexible(\n'
      '       child: Container(color: red, child: Text(\'…\')))\n'
      '   Flexible(\n'
      '       child: Container(color: green, child: Text(\'Goodbye!\'))]';

  @override
  final String explanation =
      'A única diferença ao usar Flexible em vez de Expanded é que o Flexible '
      'deixa o filho ter a mesma largura ou uma largura MENOR que o próprio '
      'Flexible, enquanto o Expanded força o filho a ter exatamente a mesma '
      'largura do Expanded.'
      '\n\n'
      'Mas tanto o Expanded quanto o Flexible ignoram a largura do filho '
      'ao definirem o próprio tamanho.'
      '\n\n'
      'Isso significa que é IMPOSSÍVEL expandir os filhos da Row '
      'proporcionalmente aos seus tamanhos. A Row usa a largura exata do filho '
      'ou a ignora completamente ao usar Expanded ou Flexible.';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Container(
            color: red,
            child: const Text(
              'This is a very long text that won\'t fit the line.',
              style: big,
            ),
          ),
        ),
        Flexible(
          child: Container(
            color: green,
            child: const Text('Goodbye!', style: big),
          ),
        ),
      ],
    );
  }
}

class Example28 extends Example {
  const Example28({super.key});

  @override
  final code =
      'Scaffold(\n'
      '   body: Container(color: blue,\n'
      '   child: Column(\n'
      '      children: [\n'
      '         Text(\'Hello!\'),\n'
      '         Text(\'Goodbye!\')])))';

  @override
  final String explanation =
      'A tela força o Scaffold a ter exatamente o tamanho da tela, '
      'então o Scaffold preenche a tela.'
      '\n\n'
      'O Scaffold diz ao Container que ele pode ter qualquer tamanho, '
      'mas não maior que a tela.'
      '\n\n'
      'Quando um widget diz ao filho que ele pode ser menor que um certo '
      'tamanho, dizemos que o widget fornece restrições "frouxas" (loose) '
      'ao filho.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: blue,
        child: const Column(children: [Text('Hello!'), Text('Goodbye!')]),
      ),
    );
  }
}

class Example29 extends Example {
  const Example29({super.key});

  @override
  final code =
      'Scaffold(\n'
      '   body: SizedBox.expand(\n'
      '      child: Container(\n'
      '         color: blue,\n'
      '         child: Column(\n'
      '            children: [\n'
      '               Text(\'Hello!\'),\n'
      '               Text(\'Goodbye!\')]))))';

  @override
  final String explanation =
      'Se você quiser que o filho do Scaffold tenha exatamente o mesmo tamanho '
      'do próprio Scaffold, pode envolver o filho com um SizedBox.expand.'
      '\n\n'
      'Quando um widget diz ao filho que ele precisa ter um tamanho exato, '
      'dizemos que o widget fornece restrições "rígidas" (tight) ao filho.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          color: blue,
          child: const Column(children: [Text('Hello!'), Text('Goodbye!')]),
        ),
      ),
    );
  }
}
