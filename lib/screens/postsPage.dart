import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_app/models/model.dart';
import 'package:instagram_app/screens/storyPage.dart';
import 'package:instagram_app/utils/my_colors.dart';
import 'package:instagram_app/utils/my_images.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppbar(),
        body: SingleChildScrollView(
            physics:const BouncingScrollPhysics(),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.12,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: PostModel.posts.length,
                      physics:const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return buildHistory(PostModel.posts[index]);
                      })),
              const Divider(height: 1, color: Colors.grey),
              Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics:const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: PostModel.posts.length,
                  itemBuilder: (context, posIindex) {
                    return buildPost(PostModel.posts[posIindex]);
                  },
                ),
              )
            ])));
  }

  Widget buildPost(post) {
    return Column(children: [
      SizedBox(
          height: 50.h,
          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            SizedBox(width: 8.w),
            Container(
              height: 30.h,
              width: 30.w,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(post.userLogo), fit: BoxFit.cover)),
            ),
            SizedBox(width: 10.w),
            Text(post.userName,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12.h)),
            SizedBox(width: 250.w),
            const Expanded(
                child:
                    Icon(Icons.more_horiz_outlined, color: Color(0xFF262626))),
            SizedBox(width: 14.w)
          ])),
      pagesView(post),
      SizedBox(height: 8.h),
      actionPost(post),
    ]);
  }

  SizedBox actionPost(post) {
    return SizedBox(
        height: 163.h,
        width: 350,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(children: [
              InkWell(
                  onTap: () {
                    setState(() {
                      post.isLiked = !post.isLiked;
                    });
                  },
                  child: post.isLiked
                      ?const Icon(Icons.favorite, color: Colors.red)
                      :const Icon(Icons.favorite_border_outlined)),
              SizedBox(width: 8.w),
              const Image(
                  image: AssetImage(MyImages.commentIcon),
                  height: 24,
                  width: 24),
              SizedBox(width: 8.w),
              const Image(
                  image: AssetImage(MyImages.shareIcon), height: 24, width: 24),
            ]),
            PostIndicator(post),
            const SizedBox(width: 1),
            const Icon(Icons.bookmark_border, size: 28)
          ]),
          const SizedBox(height: 8),
          const Text("100 Likes",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Stack(alignment: AlignmentDirectional.topStart, children: [
            Text(post.userName,
                style:const TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
            Text(
                "                Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt... more ",
                style: TextStyle(fontSize: 14.h, fontWeight: FontWeight.w400))
          ]),
          const SizedBox(height: 8),
          SizedBox(
              height: 42,
              width: 350,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 24.w),
                  Text("Add comment...",
                      style: TextStyle(
                          fontSize: 12.h, color: const Color(0xFF999999))),
                  SizedBox(width: 140.w),
                  Row(
                    children: [
                      Text("😍", style: TextStyle(fontSize: 16.h)),
                      const SizedBox(width: 8),
                      Text("😭", style: TextStyle(fontSize: 16.h)),
                      const SizedBox(width: 8),
                      Image(
                        image:const AssetImage(MyImages.addIcon),
                        width: 16.w,
                        height: 16.h,
                      )
                    ],
                  )
                ],
              ))
        ]));
  }

  Widget PostIndicator(post) {
    return Container(
      height: 24,
      child: ListView.separated(
        itemCount: post.images.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics:const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
            height: 8,
            width: 8,
            decoration: BoxDecoration(
                color: post.imageIndicator == index
                    ? MyColors.color_indicator
                    : MyColors.color_indicator_unselected,
                shape: BoxShape.circle),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(width: 3);
        },
      ),
    );
  }

  ExpandablePageView pagesView(post) {
    return ExpandablePageView.builder(
      onPageChanged: (index) {
        setState(() {
          post.imageIndicator = index;
        });
      },
      scrollDirection: Axis.horizontal,
      itemCount: post.images.length,
      itemBuilder: (context, index) {
        return PostImage(post.images[index]);
      },
    );
  }

  Widget PostImage(imageUrl) {
    return CachedNetworkImage(
        fit: BoxFit.fitWidth,
        imageUrl: imageUrl,
        placeholder: (context, url) =>
            const SizedBox(
              width: double.infinity,
              height: 400,
              child: Center(child: CircularProgressIndicator())),
        errorWidget: (context, url, error) =>
            const SizedBox(
              width: double.infinity,
              height: 400,
              child: Icon(Icons.error_outline_outlined, size: 120,)));
  }

  AppBar buildAppbar() {
    return AppBar(
      elevation: 0,
      title: Image(
          image: AssetImage(MyImages.instagramText),
          height: 30.h,
          width: 104.w),
      backgroundColor: Colors.white,
      actions: [
        Row(children: [
          Image(
              image: const AssetImage(MyImages.plusIcon),
              height: 24.h,
              width: 24.h),
          SizedBox(width: 20.w),
          Image(
              image: const AssetImage(MyImages.likeIcon),
              height: 24.h,
              width: 24.h),
          SizedBox(width: 20.w),
          Image(
              image: const AssetImage(MyImages.directIcon),
              height: 24.h,
              width: 24.h),
          SizedBox(width: 14.w),
        ])
      ],
    );
  }

  Widget buildHistory(post) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder:(context) => MoreStories()));
        },
        child: Container(
            margin: const EdgeInsets.only(left: 8, right: 8),
            width: 60.w,
            height: 60.h,
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFFDE0046), Color(0xFFF7A34B)])),
            child: Container(
                margin: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    color: Colors.white,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(post.userLogo), fit: BoxFit.cover)))),
      ),
      SizedBox(height: 4.h),
      Text(post.userName,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400))
    ]);
  }
}
