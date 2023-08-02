import 'dart:async';

import 'package:advanced_flutter/domain/model/model.dart';
import 'package:advanced_flutter/presentation/base/baseviewmodel.dart';
import 'package:advanced_flutter/presentation/resources/assets_manager.dart';
import 'package:advanced_flutter/presentation/resources/strings_manager.dart';

class OnboardingViewModel extends BaseViewModel implements OnboardingViewModelInputs, OnboardingViewModelOutputs{

  //stream controller?
  final StreamController _streamController = StreamController<SlideViewObject>();
  late final List<SliderObject> _list;
  int _currentIndex = 0;

  List<SliderObject> _getSliderData() => [
        SliderObject(AppStrings.onBoardingTitle1,
            AppStrings.onBoardingSubTitle1, ImageAssets.onboardingLogo1),
        SliderObject(AppStrings.onBoardingTitle2,
            AppStrings.onBoardingSubTitle2, ImageAssets.onboardingLogo2),
        SliderObject(AppStrings.onBoardingTitle3,
            AppStrings.onBoardingSubTitle3, ImageAssets.onboardingLogo3),
        SliderObject(AppStrings.onBoardingTitle4,
            AppStrings.onBoardingSubTitle4, ImageAssets.onboardingLogo4),
      ];

  // inputs
  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    // TODO: implement start
    _list = _getSliderData();
    _postDataToView();
  }
  
  @override
  int goNext() {
    int nextIndex = _currentIndex++;
    if (nextIndex >= _list.length - 1) {
      _currentIndex = 0;
    }
    _postDataToView();

    return _currentIndex;
  }
  
  @override
  int goPrevious() {
    int previousIndex = _currentIndex--;
    if (previousIndex == -1) {
      _currentIndex = _list.length - 1;
    } else {
      _currentIndex = previousIndex;
    }

    _postDataToView();

    return _currentIndex;
  }
  
  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    _postDataToView();
  }
  
  @override
  // TODO: implement inputSliderViewObject
  Sink get inputSliderViewObject => _streamController.sink;
  
  @override
  // TODO: implement outputSliderViewObject
  Stream<SlideViewObject> get outputSliderViewObject => _streamController.stream.map((slideViewObject) => slideViewObject);

  _postDataToView(){
    inputSliderViewObject.add(SlideViewObject(_list[_currentIndex], _list.length, _currentIndex));
  }
}


// inpputs mean the orders that our view model will receive from our view
abstract class OnboardingViewModelInputs {
  void goNext();
  void goPrevious();
  void onPageChanged(int index);

  Sink get inputSliderViewObject; // this is way to add to data to the stream .. stream input
}

// outputs mean data or results that will be sent from our view model to view

abstract class OnboardingViewModelOutputs { 
  Stream<SlideViewObject> get outputSliderViewObject;
}

class SlideViewObject {
  SliderObject sliderObject;
  int numOfSlides;
  int currentIndex;

  SlideViewObject(this.sliderObject, this.numOfSlides, this.currentIndex);
}