import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:tbl/base/components/screen_utils/flutter_screenutil.dart';

class FullscreenImageGallery extends StatefulWidget {
  final List<String> imageUrls;
  final int itemIndex;

  FullscreenImageGallery({required this.imageUrls, required this.itemIndex});

  @override
  _FullscreenImageGalleryState createState() => _FullscreenImageGalleryState();
}

class _FullscreenImageGalleryState extends State<FullscreenImageGallery> {
  final PageController _pageController = PageController();
  Color leftIconColor = Colors.white;
  Color rightIconColor = Colors.white;
  int currentIndex = 0;
  int initIndex = 0;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.itemIndex; // Assign widget.itemIndex to initIndex
    print(currentIndex.toString() + " from init");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PageView.builder(
            itemCount: widget.imageUrls.length,
            controller: _pageController,
            /*controller: PageController(
                initialPage: currentIndex, keepPage: true, viewportFraction: 1),*/
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return PhotoView(
                imageProvider: NetworkImage(widget.imageUrls[currentIndex]),
              );
            },
          ),

          // PageView.builder(
          //   itemCount: widget.imageUrls.length,
          //   controller: _pageController,
          //   onPageChanged: (index) {
          //     setState(() {
          //       currentIndex = index;
          //     });
          //   },
          //   itemBuilder: (context, index) {
          //     return PhotoView(
          //       imageProvider: NetworkImage(widget.imageUrls[index]),
          //     );
          //   },
          // ),
          Positioned(
            top: 40,
            right: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    if (currentIndex > 0) {
                      leftIconColor = Colors.white;
                      _pageController.animateToPage(
                        currentIndex - 1,
                        duration: Duration(milliseconds: 400),
                        curve: Curves.easeIn,
                      );
                      print(currentIndex);
                    } else {
                      print("else");
                      print(currentIndex);
                      leftIconColor = Colors.grey;
                    }
                  },
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                    ),
                    child: ClipOval(
                      child: Icon(
                        Icons.chevron_left,
                        color: leftIconColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Text(
                  "${(currentIndex + 1).toString()}",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(width: 10.w),
                GestureDetector(
                  onTap: () {
                    if (currentIndex < widget.imageUrls.length - 1) {
                      rightIconColor = Colors.white;
                      _pageController.animateToPage(
                        currentIndex + 1,
                        duration: Duration(milliseconds: 400),
                        curve: Curves.easeIn,
                      );
                    } else {
                      //Color.fromARGB(255, 192, 192, 192)
                      print("else part from next index");
                      rightIconColor = Colors.grey;
                    }
                    print("next index" + currentIndex.toString());
                    print(currentIndex);
                  },
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                    ),
                    child: ClipOval(
                      child: Icon(
                        Icons.chevron_right,
                        color: rightIconColor,
                      ),
                    ),
                  ),
                ),
                // Text(
                //   "${(currentIndex + 1).toString()} of ${widget.imageUrls.length}",
                //   style: TextStyle(color: Colors.white),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
