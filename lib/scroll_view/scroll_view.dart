import 'package:flutter/material.dart';
import 'package:playground/scroll_view/widget/scroll_appbar.dart';

class NScrollView extends StatefulWidget {
  const NScrollView({super.key});

  @override
  State<NScrollView> createState() => _NScrollViewState();
}

class _NScrollViewState extends State<NScrollView> {
  final List<List<int>> numbers =
      List.generate(5, (index) => List.generate(20, (i) => i + index * 20));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          // SliverAppBar(
          //   title: Text(innerBoxIsScrolled ? 'scrolling' : 'title'),
          //   floating: true,
          // ),
          SliverPersistentHeader(
            pinned: true,
            // floating: true,

            delegate: ScrollAppBarDelegate(),
          ),
        ],
        body: PageView(
          children: [
            CustomScrollView(
              slivers: [
                for (int i = 0; i <= numbers[0].length - 1; i++)
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 60.0,
                      child: Text(
                        'Number ${numbers[0][i]}',
                      ),
                    ),
                  )
              ],
            ),
            CustomScrollView(
              slivers: [
                for (int i = 0; i <= numbers[1].length - 1; i++)
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 60.0,
                      child: Text(
                        'Number ${numbers[1][i]}',
                      ),
                    ),
                  )
              ],
            ),
            CustomScrollView(
              slivers: [
                for (int i = 0; i <= numbers[2].length - 1; i++)
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 60.0,
                      child: Text(
                        'Number ${numbers[2][i]}',
                      ),
                    ),
                  )
              ],
            ),
            CustomScrollView(
              slivers: [
                for (int i = 0; i <= numbers[3].length - 1; i++)
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 60.0,
                      child: Text(
                        'Number ${numbers[3][i]}',
                      ),
                    ),
                  )
              ],
            ),
            CustomScrollView(
              slivers: [
                for (int i = 0; i <= numbers[4].length - 1; i++)
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 60.0,
                      child: Text(
                        'Number ${numbers[4][i]}',
                      ),
                    ),
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
