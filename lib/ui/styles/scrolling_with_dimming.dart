import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

typedef ScrollingExtendedIndexedWidgetBuilder = Widget Function(
    BuildContext context, int index);

class ScrollingWithDimming extends StatefulWidget {
  final Options options;
  final int itemCount;
  final ScrollingExtendedIndexedWidgetBuilder itemBuilder;

  const ScrollingWithDimming(
      {required this.options,
        Key? key,
        required this.itemCount,
        required this.itemBuilder})
      : super(key: key);

  const ScrollingWithDimming.builder(
      {required this.options,
        required this.itemCount,
        required this.itemBuilder,
        Key? key})
      : super(key: key);

  @override
  State<ScrollingWithDimming> createState() => _ScrollingWithDimmingState();
}

class _ScrollingWithDimmingState extends State<ScrollingWithDimming> {
  Options get options => widget.options;

  int get itemCount => widget.itemCount;

  ScrollingExtendedIndexedWidgetBuilder get itemBuilder => widget.itemBuilder;
  final scrollController = ScrollController();
  Size myChildSize = Size.zero;
  late double sizeContainer;
  double itemSize = 0.1;
  late int lastVisibleIndex;
  int penultimateIndex = 0;
  late int variableIndex;
  double firstHalf = 0;
  late double secondHalf;
  List<PointCoordinates> pointCoordinates = [];
  bool active = false;
  bool init = false;

  void scrollingWithDimmingStateInit() {
    if (options.scrollDirection == Axis.vertical) {
      sizeContainer = myChildSize.height;
    } else if (options.scrollDirection == Axis.horizontal) {
      sizeContainer = myChildSize.width;
    }
    // print('1 widthContainer $sizeContainer');
    itemSize = options.sizeItem;
    // print('2 itemSize $itemSize');
    lastVisibleIndex = (sizeContainer / itemSize).ceil();
    // print('3 lastVisibleIndex $lastVisibleIndex');
    penultimateIndex = sizeContainer ~/ itemSize;
    // print('4 penultimateIndex $penultimateIndex');
    variableIndex = penultimateIndex;
    // print('5 variableIndex $variableIndex');
    firstHalf = sizeContainer - (itemSize * (penultimateIndex));
    // print('6 firstHalf $firstHalf');
    secondHalf = (itemSize * lastVisibleIndex) - sizeContainer;
    // print('7 secondHalf $secondHalf');
    active = penultimateIndex < itemCount;
    if (active) {
      calculateCoordinates();
    }
  }

  void calculateCoordinates() {
    double start = 0;
    double end = itemSize;
    if (secondHalf != 0) {
      end = secondHalf;
    }
    for (int i = 0; i < 15; i++) {
      pointCoordinates.add(PointCoordinates(
          variableIndex: variableIndex, start: start, end: end));
      variableIndex++;
      start = end;
      end = end + itemSize;
    }
  }

  int getTheLastVisibleIndex() {
    int index = penultimateIndex;
    for (var element in pointCoordinates) {
      if (scrollController.offset > element.start &&
          scrollController.offset < element.end) {
        return index = element.variableIndex;
      }
    }
    return index;
  }

  double opacityFunction(int index) {
    double percent;
    double difference;
    double itemPositionOffset = index * itemSize;
    if (index == getTheLastVisibleIndex()) {
      difference = firstHalf + (scrollController.offset - itemPositionOffset);
    } else {
      difference = scrollController.offset - itemPositionOffset;
    }
    if (index == getTheLastVisibleIndex()) {
      percent = penultimateIndex + (difference / itemSize);
    } else {
      percent = 1 - (difference / itemSize);
    }
    double opacity = percent;
    if (opacity > 1.0) opacity = 1.0;
    if (opacity < 0.0) opacity = 0.0;
    return opacity;
  }

  void onListen() {
    setState(() {});
  }

  @override
  void initState() {
    // scrollingWithDimmingStateInit();
    scrollController.addListener(onListen);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.removeListener(onListen);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (myChildSize.width != 0 && !init) {
      init = true;
      scrollingWithDimmingStateInit();
    }

    return Center(
      child: MeasureSize(
        onChange: (size) {
          setState(() {
            myChildSize = size;
            // print('width ${size.width}');
            // print('height ${size.height}');
          });
        },
        child: SizedBox(
          width: options.width,
          height: options.height,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            physics: options.physics,
            controller: scrollController,
            scrollDirection: options.scrollDirection,
            itemCount: itemCount,
            itemBuilder: (context, index) => Opacity(
              opacity: active ? opacityFunction(index) : 1,
              child: SizedBox(
                width: options.sizeItem,
                height: options.sizeItem,
                child: itemBuilder(context, index),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Options {
  final double width;
  final double height;
  final double sizeItem;
  final ScrollPhysics physics;
  final Axis scrollDirection;

  Options({
    this.width = double.maxFinite,
    this.height = double.maxFinite,
    this.sizeItem = 40,
    this.physics = const ScrollPhysics(),
    this.scrollDirection = Axis.horizontal,
  });

// Options copyWith({
//   double? width,
//   double? height,
//   double? widthItem,
// }) =>
//     Options(
//       width: width ?? this.width,
//       height: height ?? this.height,
//       sizeItem: widthItem ?? this.sizeItem,
//     );
}

class PointCoordinates {
  int variableIndex = 0;
  double start = 0.0;
  double end = 0.0;

  PointCoordinates({
    required this.variableIndex,
    required this.start,
    required this.end,
  });
}

typedef OnWidgetSizeChange = void Function(Size size);

class MeasureSizeRenderObject extends RenderProxyBox {
  Size oldSize = Size.zero;
  final OnWidgetSizeChange onChange;

  MeasureSizeRenderObject(this.onChange);

  @override
  void performLayout() {
    super.performLayout();

    Size newSize = child!.size;
    if (oldSize == newSize) return;

    oldSize = newSize;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onChange(newSize);
    });
  }
}

class MeasureSize extends SingleChildRenderObjectWidget {
  final OnWidgetSizeChange onChange;

  const MeasureSize({
    super.key,
    // required Key key,
    required this.onChange,
    required Widget child,
  }) : super(
    // key: key,
      child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return MeasureSizeRenderObject(onChange);
  }
}
