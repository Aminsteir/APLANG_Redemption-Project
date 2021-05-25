import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redemption/structs/Path.dart';
import 'package:redemption/structs/State.dart';
import 'package:redemption/widgets/Option.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int depth = 0;
  late TextState curState;
  late TextState firstState;
  late var storyPath = [];
  bool finalPage = false;

  @override
  void initState() {
    setState(() {
      this.firstState = getStory();
    });

    _reset();

    super.initState();
  }

  TextState getStory() {
    var baseStateIgnore = new TextState(
        'Consequences Of Thy Actions',
        'Your friend ends up being sent to the hospital after the bully pushed them, and hit his head on the concrete floor. Do you go to the hospital or avoid seeing him out of shame?',
        [
          new Option(
            'Go See Him',
            new TextState(
              'Recovery and Time',
              'You visit the hospital and see your friend. You explain to him your actions and why you did it. He forgives you, and eventually recovers.',
              [],
              mainImage:
                  'https://i.pinimg.com/originals/b3/70/5c/b3705cc2edf8f527789e6e2be29f6267.gif',
              isEnd: true,
            ),
          ),
          new Option(
            'Avoid Him',
            new TextState(
                'Unfortunate Occurrences',
                'You avoid visiting your friend out of shame, and by the time you got around to visit, your friend sadly passed away. It turns out that he cracked is skull and couldn\'t recover fast enough. You never got to say goodbye.',
                [],
                mainImage:
                    'https://cliply.co/wp-content/uploads/2020/10/392010140_GHOST_EMOJI_400px.gif',
                isEnd: true),
          ),
        ],
        mainImage:
            'https://cdn.britannica.com/12/130512-004-AD0A7CA4/campus-Riverside-Ottawa-The-Hospital-Ont.jpg');

    var confrontBully = new TextState(
        'The Support of Allies',
        'You gather your friends and confront the bully. The bully at first gets offensive and tries scaring you off, but realizes his efforts are futile due to the shear difference in numbers. The bully calms down and your friends start talking to him and both sides come to a consensus. The bully has now turned friend.',
        [],
        mainImage:
            'https://stanthonycommunitycenter.com/wp-content/uploads/wp-social/facebook/1423300644549424/2017/08/giphy.gif',
        isEnd: true);

    var state = new TextState(
      'The Beginning',
      'Your name is John Grey. You were homeschooled as a kid and recently transferred to a local public high school. Right now, you are 16 years old. You are witnessing one of your friends getting bullied. What do you do?',
      [
        new Option(
          'Take Action And Defend Your Friend',
          new TextState(
              'Friendship',
              'You try defending your friend, but you end up getting punched in the face and being sent to the hospital for a broken arm. As your arm is healing, you start thinking about what you are going to do the next time you see the bully. What will you do?',
              [
                new Option(
                    'Talk To Him And Try Connecting',
                    new TextState(
                        'Morality',
                        'You try talk to the bully alone, but it fails because you don\'t have any leverage to even begin with. You go home with a black eye. This time you try something different.',
                        [
                          new Option('Gather Thy Friends', confrontBully),
                        ],
                        mainImage:
                            'https://i.pinimg.com/originals/ba/1b/ba/ba1bba349c9b8772806a8fd8de2a86d6.gif')),
                new Option('Confront Him W/ Your Friends', confrontBully),
                new Option(
                  'Report Him To The Principle',
                  new TextState(
                      'People In Higher Places',
                      'You report the bully to the principle, and after a year, the bully heads to a correctional facility due to bad behavior. Not the best ending for him.',
                      [],
                      mainImage: 'https://i.gifer.com/7OYZ.gif',
                      isEnd: true),
                ),
              ],
              mainImage:
                  'https://i.pinimg.com/originals/f0/12/e3/f012e388a7a74441228bb106de1c471d.gif'),
        ),
        new Option(
          'Ignore It',
          baseStateIgnore,
        ),
        new Option(
          'Get A Teacher',
          new TextState(
              'People In High Places',
              'You run to find a teacher, and you can\'t find any near you. Instead, you find other friends that can assist you in taking down the bully. What do you do?',
              [
                new Option('Resume Trying To Find A Teacher', baseStateIgnore),
                new Option(
                  'Gather Thy Friends',
                  confrontBully,
                ),
              ],
              mainImage:
                  'https://i.pinimg.com/originals/f0/12/e3/f012e388a7a74441228bb106de1c471d.gif'),
        ),
      ],
      mainImage:
          'https://bestanimations.com/Balls&Buttons/amazing-3d-computer-ball-sphere-art-animated-gif-6.gif',
    );
    return state;
  }

  void _madeChoice(
    Option choiceMade,
  ) {
    if (this.curState.isEnd) return;

    setState(() {
      depth += 1;
      this.curState = choiceMade.next;
      var pth = new StoryPath(this.curState.mainImage, choiceMade.text);
      this.storyPath.add(pth);
    });
  }

  void _reset() {
    setState(() {
      this.depth = 0;
      this.curState = this.firstState;
      this.storyPath.clear();
      this
          .storyPath
          .add(new StoryPath(this.firstState.mainImage, 'The Beginning'));
      this.finalPage = false;
    });
  }

  Widget getScreen(BuildContext context) {
    if (finalPage) return endScreen(context);
    return storyScreen(context);
  }

  Widget endScreen(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SelectableText(
            'Your Story:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Divider(
            height: 40,
            thickness: 1,
            indent: 60,
            endIndent: 60,
          ),
          Wrap(
            alignment: WrapAlignment.center,
            direction: Axis.horizontal,
            runSpacing: 40,
            spacing: 20,
            children: this.storyPath.map((e) {
              var i = e as StoryPath;
              return Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.network(
                      '${i.image}',
                      height: 300,
                      width: 300,
                      alignment: Alignment.center,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    height: 20,
                    width: 0,
                  ),
                  SelectableText('${i.choiceChosen}'),
                ],
              );
            }).toList(),
          ),
          Divider(
            height: 40,
            thickness: 1,
            indent: 60,
            endIndent: 60,
          ),
          ElevatedButton(
            onPressed: () => {_reset()},
            child: Text('Restart'),
            style: ButtonStyle(
              padding: MaterialStateProperty.all(EdgeInsets.all(20)),
            ),
          ),
        ],
      ),
    );
  }

  Widget storyScreen(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (curState.mainImage.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(
                '${curState.mainImage}',
                height: 300,
                width: 300,
                alignment: Alignment.center,
                fit: BoxFit.cover,
              ),
            ),
          ),
        Container(height: 10),
        SelectableText(
          '${curState.title}',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Container(height: 20),
        SelectableText(
          '${curState.description}',
        ),
        Container(height: 20),
        Wrap(
          runSpacing: 5.0,
          spacing: 5.0,
          children: this.curState.options.map((var e) {
            Option option = e as Option;
            return Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: ElevatedButton(
                onPressed: () => {_madeChoice(option)},
                child: Text('${option.text}'),
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.all(20)),
                ),
              ),
            );
          }).toList(),
        ),
        if (depth != 0)
          Divider(
            height: 40,
            thickness: 1,
            indent: MediaQuery.of(context).size.width / 6,
            endIndent: MediaQuery.of(context).size.width / 6,
          ),
        if (depth != 0)
          Wrap(
            runSpacing: 5.0,
            spacing: 5.0,
            children: [
              if (!curState.isEnd && !finalPage)
                ElevatedButton(
                  onPressed: () => {_reset()},
                  child: Text('Reset To Start'),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.all(20)),
                  ),
                ),
              if (curState.isEnd)
                ElevatedButton(
                  onPressed: () => {
                    setState(() {
                      this.storyPath.add(new StoryPath(
                          'https://images.unsplash.com/photo-1524077410193-2f667f9ab09a?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8ZW1wdHklMjByb2FkfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80',
                          'The End'));
                      this.finalPage = true;
                    })
                  },
                  child: Text('Your Path'),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.all(20)),
                  ),
                ),
            ],
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Center(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(child: getScreen(context)),
              ),
            ),
          ),
          Positioned(
            right: 30,
            top: 25,
            child: Container(
              child: ElevatedButton.icon(
                onPressed: () => {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: SelectableText('Developed By Amin Armat'),
                      contentPadding: EdgeInsets.all(20),
                      content: SingleChildScrollView(
                        child: SelectableText(
                            'Name Of Piece: The Redemption Arc \nDate Created: 5/20/2021 \nTechnique: Website Developed w/ Flutter \nTheme: Redemption\n\nProject Description: I wanted to make something that includes elements of redemption, and this was one of the outcomes I thought of. You see a teen named John going throughout high school and making decisions, decisions that can have a big impact on the world. Depending on what John does, he could find redemption, redeem other individuals, or just fail altogether.\n\nThe use of all images on this website are subject to the copyright owner(s). If there is an issue, contact me at aminsteir@gmail.com.'),
                      ),
                      actions: [
                        IconButton(
                          onPressed: () => {Navigator.pop(context)},
                          icon: Icon(Icons.close),
                        ),
                      ],
                    ),
                    barrierDismissible: true,
                    barrierColor: Colors.blueAccent.withAlpha(175),
                  ),
                },
                icon: Icon(Icons.airplay_rounded),
                label: Text('Project Info'),
                autofocus: true,
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                    EdgeInsets.all(20),
                  ),
                  backgroundColor:
                      MaterialStateProperty.all(Theme.of(context).primaryColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
