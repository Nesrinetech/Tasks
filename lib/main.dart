import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:ui' as ui;

void main() {
 runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

@override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagram Post',
      theme: ThemeData.dark(),
      home: const PostPage()
        );
      }
  }

  // home screen widget
  class PostPage extends StatefulWidget {
    const PostPage({super.key});

    @override
    State<PostPage> createState() => _PostPageState();
  }


  // state for postpage to handle UI and logic
  class _PostPageState extends State<PostPage> {
    final GlobalKey _postKey = GlobalKey();

    // function to capture the widget as image and share it
    Future<void> _sharePost() async {
      try {
        // find 
        final boundary = _postKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
        
        final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
        final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
        final Uint8List pngBytes = byteData!.buffer.asUint8List();


      }
    }


    @override
    Widget build(BuildContext context) {
      return Scaffold(
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


// 3
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






    // Data models

//   Task 4
    // Post model 

    class Post {
      final int id;
      final int userId;
      final String title;
      final String body;

      // constructor
      Post({
        required this.id,
        required this.userId,
        required this.title,
        required this.body,
      });

      // Post from JSON map
      factory Post.fromJson(Map<String, dynamic> json) {
        return Post(
          id: json['id'] as int,
          userId: json['userId'] as int,
          title: json['title'] as String,
          body: json['body'] as String,
        );
      }
    }

    // comment model (comment fetched from the API )

    class CommentModel {
      final int id;
      final int postId;
      final String name;
      final String email;
      final String body;

      // constructor
      CommentModel({
        required this.id,
        required this.postId,
        required this.name,
        required this.email,
        required this.body,
      });

      // Post from JSON map
      factory  CommentModel.fromJson(Map<String, dynamic> json) {
        return  CommentModel(
          id: json['id'] as int,
          postId: json['postId'] as int,
          name: json['name'] as String,
          email: json['email'] as String,
          body: json['body'] as String,
        );
      }
      // convert to json useful for post
      Map<String, dynamic> toJson() {
        return {
          'id': id,
          'postId': postId,
          'name': name,
          'email': email,
          'body': body,
        };
      }
    }
    
    // Task 5 API service to fetch posts and comments using 
      class ApiService {
        final String baseUrl;
        final String? apiKey;


        ApiService({required this.baseUrl, this.apiKey});
        // builds request headers
        Map<String, String> _headers() {
          final headers = <String, String>{
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          };
          if (apiKey != null && apiKey!.isNotEmpty) {
            headers['Authorization'] = 'Bearer $apiKey';
          }
          return headers;
        }
        // GET /posts
        
      Future<List<Post>> fetchPosts() async {
        final url = Uri.parse('$baseUrl/posts');
        final response = await http.get(url, headers: _headers());
        if (response.statusCode == 200) {
          final List parsed = jsonDecode(response.body) as List;
          return parsed.map((e) => Post.fromJson(e as Map<String, dynamic>)).toList();

        } else 
        {
          throw Exception('Failed to load posts: ${response.statusCode}');
        }
      }

      // GET/posts/{postId}/comments
        Future<List<CommentModel>> fetchCommentsForPost(int postId) async {
        final url = Uri.parse('$baseUrl/posts/$postId/comments');
        final response = await http.get(url, headers: _headers());
        if (response.statusCode == 200) {
          final List parsed = jsonDecode(response.body) as List;
          return parsed.map((e) => CommentModel.fromJson(e as Map<String, dynamic>)).toList();

        } else 
        {
          throw Exception('Failed to load comments: ${response.statusCode}');
        }
      }


      // POST /comments 
         Future<List<CommentModel>> postComment({
          required int postId,
          required String name,
          required String email,
          required String body,
         }) async {
        final url = Uri.parse('$baseUrl/comments');
        final payload = jsonEncode({
          'postId': postId,
          'name': name,
          'email': email,
          'body': body,
        });

        final response = await http.post(url, headers: _headers(), body: payload);

        if (response.statusCode == 201 || response.statusCode == 200) {
          final Map<String, dynamic> parsed = jsonDecode(response.body) as Map<String, dynamic>;
          return CommentModel.fromJson(parsed);

        } else 
        {
          throw Exception('Failed to load comments: ${response.statusCode}');
        }
        }
       
      }
   
  
