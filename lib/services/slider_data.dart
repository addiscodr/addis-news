import 'package:addis_news/models/slider_model.dart';

List<SliderModel> getSliders() {
  List<SliderModel> slider = [];
  SliderModel sliderModel = SliderModel();

  sliderModel.sliderName = "Business";
  sliderModel.image = "assets/images/business.jpg";
  slider.add(sliderModel);
  sliderModel = SliderModel();

  sliderModel.sliderName = "Entertainment";
  sliderModel.image = "assets/images/entertainment.jpg";
  slider.add(sliderModel);
  sliderModel = SliderModel();

  sliderModel.sliderName = "General";
  sliderModel.image = "assets/images/general.jpg";
  slider.add(sliderModel);
  sliderModel = SliderModel();

  sliderModel.sliderName = "Health";
  sliderModel.image = "assets/images/health.jpg";
  slider.add(sliderModel);
  sliderModel = SliderModel();

  sliderModel.sliderName = "Sports";
  sliderModel.image = "assets/images/sport.jpg";
  slider.add(sliderModel);
  sliderModel = SliderModel();

  return slider;
}
