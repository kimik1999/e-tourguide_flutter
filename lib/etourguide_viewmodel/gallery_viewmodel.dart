import 'package:flutter/material.dart';
import 'package:flutter_etourguide/etourguide_model/gallery_model.dart';

class GalleryViewModel {
  List<Gallery> listGallery;

  GalleryViewModel({this.listGallery});

  List<Gallery> get ListGallery {
    listGallery = [
      Gallery(
          name: 'Event',
          icon: Icons.event,
          imageUrl:
              'https://www.cincinnatiartmuseum.org/media/279107/cincinnati-wing-1.jpg'),
      Gallery(
          name: 'Topic',
          icon: Icons.topic_outlined,
          imageUrl:
              'https://images.unsplash.com/photo-1545293527-d41d0c75b9ee?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1yZWxhdGVkfDE0fHx8ZW58MHx8fA%3D%3D&w=1000&q=80'),
      Gallery(
          name: 'Exhibit',
          icon: Icons.emoji_objects_outlined,
          imageUrl:
              'https://www.metmuseum.org/-/media/images/exhibitions/2013/impressionismfashionmodernity/gallery-shots/gallery-1.jpg'),
      //Gallery(name: 'Room Collections', imageUrl: 'https://www.cincinnatiartmuseum.org/media/279107/cincinnati-wing-1.jpg'),
    ];
    return listGallery;
  }
}
