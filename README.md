# flutter fampay

Flutter assignment.

## Getting Started

NOTE: APK is atttached to the repo named as "app-release.apk"

## App screenshots and Screen recording

https://drive.google.com/drive/folders/1GWU58h54k5AfJZE0zN_WPPHmHraCdogM?usp=share_link

![fam_ss](https://github.com/user-attachments/assets/016a05d5-728b-4b2f-8957-79a67b97f5db)

https://github.com/user-attachments/assets/5d1b3aef-b1be-49f3-928c-22baf616d1c2

https://github.com/user-attachments/assets/65978ae2-689d-4c98-8e34-612ce88fe1fa

![fam_app](https://github.com/user-attachments/assets/8fe73435-d98c-4af8-9788-b5578bd7df55)


## Library Used

- Flutter Bloc
- http
- dio
- Url launcher
- Shared Prefrences

## Flutter Bloc

used Cubit to manage the state of the app, ensuring that the UI reacts to changes in data and state without tightly coupling the logic with the UI

## http and dio

used dio in my project for its advanced features, including response interceptors for logging and error handling

## Url launcher

used for launching URLs

## Shared Prefrences

- Local Data Storage: used SharedPreferences to save data persistently on the user's device

- Remind Later & Dismiss Functionality: In this project, I implemented functionality for “Remind Later” and “Dismiss” using SharedPreferences. The user’s choice (whether to remind later or dismiss a reminder) is stored locally, allowing the app to act accordingly on subsequent launches.
 
- Storing Card Details: I stored card details using a card ID as the key and the associated card details as the value. The card ID is used to access a specific card's data from the stored map.

## Extra

 I used Aspect Ratio and Card ID, which were defined in the API but not initially part of the app's predefined schema

- I used Aspect Ratio value to ensure that images were displayed correctly across different screen sizes, preserving their proportions and fitting perfectly within their containers
- The Card ID, also defined in the API, allowed me to uniquely identify each card and store its specific data locally using SharedPreferences








