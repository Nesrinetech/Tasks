import 'package:flutter/material.dart';


void main() {
 runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

@override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagram Post',
      theme: ThemeData.dart(),
      home: const PostPage()
        );
      }
  }

  // home screen widget
  class PostPage extends StatefulWidget {
    const PostPage({super.key)};

    @override
    State<PostPage> createState() => _PostPageState();
  }


  // state for postpage to handle UI and logic
  class _PostPageState extends State<PostPage> {
    final GlobaleKey _postKey = GlobaleKey();

    // function to capture the widget as image and share it
    Future<void> _sharePost() async {
      try {
        // find 
        final boundary = _postKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
        
        final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
        final ByteDat? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
        final Uint8List pngBytes = byteData!.buffer.asUint8List();


      }
    }


    @override
    Widget build(BuildContext context) {
      return Scanffold(
        appBar: AppBar(
          title: const Text('Instagram Post'),
          centerTitle: true,
        ),

        // body is scrollbar
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              // wrap the post widget to capture it
              RepaintBoundary(
                key: _postKey,
                child: PostCard(
                  imagePath: '',
                  username: '',
                  caption: '',
                ),
              ),
              const SizedBox(height: 24),

              // buttonfor sharing
              ElevatedButton.icon(
                onPressed: _sharePost,
                icon: const Icon(Icons.share), 
                label: const Text('Share post'),          )
          ),
            ],
          )
        ),
      );
    }
    }

    // PostCrad widget Instagram style post UI


    class PostCard extends StatelessWidget {
      final String imagePath;
      final String username;
      final String caption;

      const PostCard({
        super.key,
        required this.imagePath,
        required this.username,
        required this.caption,
      });



      @override
      Widget build(BuildContext context) {
        // card widget
        return Card(
          color: Colors.black,
          elevation: 6,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Creating the Header ( profile picture + username + follow button)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Row(
                  children: [
                    // profile picture / avatar
                    const CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                    // space between picture and username
                    const SizedBox(width: 10), 
                    // text (username)
                    Expanded(
                      child: Text(
                        username,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    // follow button
                    TextButton(onPressed:() {}, child: const Text('Follow'))
                  ],
                ),
              ),

              // Image with overlay text
              AspectRatio(
                aspectRatio: 1.2,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(0),
                      child: Image.asset(
                        imagePath,
                        // cover entire box
                        fit: BoxFit.cover, 
                      ),
                    ),

                    // improve text readability (semi-transparent gradient overlay)
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            // dark at top
                            Colors.black.withOpacity(0.45),
                            // light at bottom
                            Colors.black.withOpacity(0.05),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),

                    // title + subtitle 
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text(
                            'Beautiful VS Code',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                Shadow(blurRadius: 4, color: Colors.black45, offset: Offset(0, 2))
                              ],
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            // subtitle
                            'Themes',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFB388FF),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
                // Action Icons row
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                  child: Row(
                    children: [
                      // Like
                      IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border)),
                      IconButton(onPressed: () {}, icon: const Icon(Icons.mode_comment_outlined)),
                      IconButton(onPressed: () {}, icon: const Icon(Icons.send_outlined)),
                      // pushing next icon to far right
                      const Spacer(),
                      IconButton(onPressed: () {}, icon: const Icon(Icons.bookmark_border)),
                    ],
                  ),
                ),

                // text caption
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style.copyWith(fontSize: 14),
                      children: [
                        TextSpan(
                          text: username + ' ',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: caption),                        )
                      ],
                    ),
                  ),
                ),
                //  bottom spacing
                const SizedBox(height: 12),
            ],
          ),
        );
      }
    }
   
   
   
   
  
