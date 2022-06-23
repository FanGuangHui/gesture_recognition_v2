# gesture_recognition_v2

[![Pub](https://img.shields.io/pub/v/gesture_recognition_v2.svg?style=flat-square)](https://pub.dartlang.org/packages/gesture_recognition_v2)
[![support](https://img.shields.io/badge/platform-flutter%7Cdart%20vm-ff69b4.svg?style=flat-square)](https://pub.dartlang.org/packages/gesture_recognition_v2)


> a gesture recognition verification lock
> form [gesture_recognition](https://pub.dev/packages/gesture_recognition)


### [中文](https://github.com/yiersanto/gesture_recognition_v2/blob/master/README_ZH.md) [English](https://github.com/yiersanto/gesture_recognition_v2/blob/master/README.md)

![](https://github.com/yiersanto/gesture_recognition_v2/blob/master/img/icon.jpeg?raw=true)

### Dependencies
```
dependencies:
  gesture_recognition_v2: ^version  
```

### Demonstration
![](https://github.com/yiersanto/gesture_recognition_v2/blob/master/img/setting.gif?raw=true)
![](https://github.com/yiersanto/gesture_recognition_v2/blob/master/img/verify.gif?raw=true)

### Example

##### Settings PassWord
```
GestureView(
	immediatelyClear: true,
	size: MediaQuery.of(context).size.width,
	onPanUp: (List<int> items) {
	  setState(() {
	    result = items;
	  });
	},
)
```

##### Verify PassWord
```
GlobalKey<GestureState> gestureStateKey = GlobalKey();

GestureView(
    key: this.gestureStateKey,
    size: MediaQuery.of(context).size.width*0.8,
    selectColor: Colors.blue,
    onPanUp: (List<int> items) {
      analysisGesture(items);
    },
    onPanDown: () {
      gestureStateKey.currentState.selectColor = Colors.blue;
      setState(() {
        status = 0;
      });
    },
)
```

### Parameter

| Props | Type | Description | DefaultValue| isRequired |
| ------ | ----------- | ----------- | ----------- | ---- |
| size| double | The size of the component, the width is equal to the height | | true |
| selectColor | Color | The color when selected | Colors.blue | false |
| unSelectColor | Color| Color when not selected |Colors.grey| false  |
| ringWidth | double | Outer ring width of the point| 4 | false |,
| ringRadius | double | Inner ring radius of the point | 30 | false |,
| showUnSelectRing | bool | Whether the outer ring is displayed when the point is not selected | true | false |,
| circleRadius | double | Inner radius of the point |20| false |,
| lineWidth | double | Connection line width | 6 | false |
| onPanUp | Function(List<int>) | After the finger is raised |  | false |
| onPanDown | Function() | After pressing your finger | | false |
| immediatelyClear | bool | Clear the trace after lifting the hand | false| false|