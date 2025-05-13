# Globe Exam App

## This is a simple app to show the requirements
- Reads a JSON feed from the internet
- Parses it and shows the contents in a list
- Shows a detailed view
- Persists the contents of the feed locally
- Compiles and runs from XCode

### Details
- Used the **iTunes Search API** (https://developer.apple.com/library/archive/documentation/AudioVideo/Conceptual/iTuneSearchAPI/index.html#//apple_ref/doc/uid/TP40017632-CH3-SW1) for the **"free JSON apis"** 
- Used **SPM Kingfisher** library (https://github.com/onevcat/Kingfisher) for downloading and caching images
- Created LocalStorage to save json and video instead of coredata for simplicity, performance and portability since it's just a small datasets loading and saving the entire array is fast and efficient.
- Used MVVM with SwiftUI and Swift Concurrency
- Added Test Cases

### App Preview

https://github.com/user-attachments/assets/6773252c-2705-4da5-81fa-d8ef45fcc297

