# Pushup Tracker

This project uses updates from CoreMotion, a little data analysis, and SwiftUI to track a user’s pushup count using a set of AirPods.

## Installation

1. Clone the repository:
    ```sh
    git clone https://github.com/your-username/pushup-tracker.git
    ```
2. Open the project in Xcode:
    ```sh
    cd pushup-tracker
    open PushupTracker.xcodeproj
    ```
3. Build and run the project on your preferred device.

## Usage

1. Make sure your AirPods are connected to your device.
2. Launch the app on your device.
3. Tap "Start Counting" when you are ready to begin. 
4. Perform pushups while wearing your AirPods. The app will track and update the count automatically.
5. When you are finished, press "Stop". 
6. Switch to the chart view to see the average pitch and acceleration data.

## Features

- **Pushup Tracking**: Counts pushups in real-time using CoreMotion updates from AirPods.
- **Data Visualization**: Displays average pitch and acceleration across pushup sessions. Helps calibrate pushup detection based on user's movement pattern.

### Possible Future Expansions
- Tracking reps across sessions. This may require a reset button or weekly/monthly reset intervals.
- Displaying cumulative reps across all sessions as well as the current session.
- Viewing rep count per month or week over time for comparison.
- Generalizing the calibration process to tune the rep thresholds based on user's initial pushups and subsequent movement over time. (As opposed to basing the threshold of off only *my* pushups.)

I am currently working on expanding the concept to detect and track other exercises as well, such as:
- Squats
- Jumping jacks
- Sit-ups

## Screenshots

*Include screenshots of the main view and chart view here.*

## Acknowledgements

- [Richard Das](https://richarddas.com) for the idea and initial implementation concept in the article [Turning AirPods into Fitness Trackers to Fight Cancer](https://richarddas.com/blog/turning-airpods-into-fitness-trackers-to-fight-cancer/).

---

Feel free to suggest any additional features or improvements!
