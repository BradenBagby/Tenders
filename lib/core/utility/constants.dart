import 'package:tenders/domain/member/member.dart';
import 'package:tenders/domain/restauraunt/photo.dart';
import 'package:tenders/domain/restauraunt/restauraunt.dart';
import 'package:tenders/domain/restauraunt/review.dart';
import 'package:tenders/widgets/common/displays/no_avatar.dart';

class Constants {
  static final fakeMembers = [
    Member(
      id: "0",
      color: NoAvatar.PossibleColors[5].value,
      name: "Joe",
    ),
    Member(
      id: "1",
      color: NoAvatar.PossibleColors[8].value,
      name: "Sarah",
    ),
    Member(
      id: "2",
      color: NoAvatar.PossibleColors[6].value,
      name: "Cameron",
    ),
    Member(
      id: "3",
      color: NoAvatar.PossibleColors[9].value,
      name: "Roy",
    ),
  ];

  /// for marketing
  static final fakeRestauraunts = [
    Restauraunt(
        name: "Chik Fil A",
        id: "1",
        address: "466 S Fifth St",
        rating: 5,
        iconUrl: "",
        latitude: 38.760,
        longitude: -90.503670,
        totalRatings: 405,
        photos: [
          FakePhoto(
              fakeUrl:
                  "https://upload.wikimedia.org/wikipedia/commons/thumb/9/9a/Chick-fil-A.jpg/900px-Chick-fil-A.jpg")
        ],
        url: "",
        formattedPhoneNumber: ""),
    Restauraunt(
      name: "Tavern on Main",
      id: "0",
      address: "428 S Fifth St",
      rating: 5,
      iconUrl: "",
      latitude: 38.762290,
      longitude: -90.503670,
      totalRatings: 334,
      url: "tenders.bradenbagby",
      formattedPhoneNumber: "(314) 567-8723",
      reviews: [
        Review(
          author_name: "Braden Bagby",
          profile_photo_url:
              "https://media-exp1.licdn.com/dms/image/C4E03AQEfVRoA91XT5g/profile-displayphoto-shrink_800_800/0/1639148517401?e=1648080000&v=beta&t=ujjDVeuCs-5_gvFGrkTmCajqNwc3Fw20_bC-9FhrKqk",
          rating: 5,
          relative_time_description: "a week ago",
          text:
              "Great food and drinks! Server time was fast. Seating is nice. I cannot reccommend this place enough ",
        ),
        Review(
          author_name: "Alex Peters",
          profile_photo_url:
              "https://media-exp1.licdn.com/dms/image/C4D03AQHqQpxl0BK81g/profile-displayphoto-shrink_800_800/0/1612635136834?e=1648080000&v=beta&t=RttmkDWx92qCQX9982qFMJiqKkbzi4oZ_ugtnUMrgBU",
          rating: 4,
          relative_time_description: "a week ago",
          text:
              "Everything was great except the parking. A little hard to find a spot, especially during dinner times.",
        ),
        Review(
          author_name: "Stacy Adams",
          profile_photo_url:
              "https://images.unsplash.com/photo-1580489944761-15a19d654956?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1361&q=80",
          rating: 3,
          relative_time_description: "a week ago",
          text:
              "I've had better. Food was cold and waitress was rude. I likely wont come back",
        ),
      ],
      photos: [
        FakePhoto(
          fakeUrl:
              "https://images.unsplash.com/photo-1514933651103-005eec06c04b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2148&q=80",
        ),
        FakePhoto(
          fakeUrl:
              "https://images.unsplash.com/photo-1554679665-f5537f187268?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80",
        ),
        FakePhoto(
          fakeUrl:
              "https://images.unsplash.com/photo-1590846406792-0adc7f938f1d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=985&q=80",
        ),
        FakePhoto(
          fakeUrl:
              "https://images.unsplash.com/photo-1502301103665-0b95cc738daf?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=3024&q=80",
        ),
        FakePhoto(
          fakeUrl:
              "https://images.unsplash.com/photo-1482049016688-2d3e1b311543?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1010&q=80",
        ),
        FakePhoto(
          fakeUrl:
              "https://images.unsplash.com/photo-1569096651661-820d0de8b4ab?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=963&q=80",
        )
      ],
    ),
    Restauraunt(
        name: "The Bath Brew House",
        id: "2",
        address: "466 S Fifth St",
        rating: 3,
        iconUrl: "",
        latitude: 38.7623,
        longitude: -90.503670,
        totalRatings: 128,
        photos: [
          FakePhoto(
              fakeUrl:
                  "https://images.unsplash.com/photo-1516556888824-7fb346bd396d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1364&q=80")
        ],
        url: "",
        formattedPhoneNumber: ""),
  ];
}
