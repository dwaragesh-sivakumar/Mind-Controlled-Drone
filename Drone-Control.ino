/*
 * How does the mind-controlling drone operate?
 * - This code is used for Arduino MKR 1000 through Arduino 1.8.9.
     The purpose of the code is to receive the concentration and cortisol values of a user to send it to the controller circuit
 *
 * - The drone will operate under the supervision of the user, who can see how they steer the drone via a terminal display of a live altimeter
 * - Key notes:
     A. Throtte and Yaw: Nose goes perpendicular to the y-axis, going left and right
     B. Pitch and Roll: Nose goes perpendicular to the x-axis, going up and down
 *
 */

// Set initial values for the drone to operate up, down, left, and right:
int throttle  = 0;
int yaw, pitch, roll;
yaw = pitch = roll = 127;

// Values that are used for Pulse Width Modulation to create a low pass filter for each direction of the drone:
int throttlePin   = 2;
int yawPin        = 3;
int pitchPin      = 4;
int rollPin       = 5;

// Constructing a foundation for the initialization of the drone's operation in the air:
void setup() 
{
  // Begin Serial communication at 115200 baud
  // 115200 baud = 115200 bits per second
  // Baud is the measure of the number of times a signal changes its state of movement per second
  Serial.begin( 115200 );

  // Set pinModes for each direction
  pinMode( throttlePin,  OUTPUT );
  pinMode( yawPin,       OUTPUT );
  pinMode( pitchPin,     OUTPUT );
  pinMode( rollPin,      OUTPUT );
}

// Running for a certain period of time to keep the momentum of the mind-controlling drone:
// Used to continously run the drone for the amount of baud it intakes:
void loop() 
{
  // If there is a stable serial connection with the mind-controlling drone, then obtain the values:
  if ( Serial.available() > 0 ) 
  {
    // Serial buffer = a host can send indefinite data to a contraption
    // A serial buffer led an array of generated inputs from the user to a hacked controller, resulting in a mind-controlling drone
    throttle    = Serial.parseInt();    // Store the first, 8-bit integer value from the serial buffer
    yaw         = Serial.parseInt();    // Store the second, 8-bit integer value from the serial buffer
    pitch       = Serial.parseInt();    // Store the third, 8-bit integer value from the serial buffer
    roll        = Serial.parseInt();    // Store the fourth, 8-bit integer value from the serial buffer
  }
 
  // Write values to the drone controller
  // Use a low pass filter to convert Pulse Width Modulation (PWM) to an analog voltage
  // Each value is designated for each direction:
  analogWrite( throttlePin,  throttle );
  analogWrite( yawPin,       yaw      );
  analogWrite( pitchPin,     pitch    );
  analogWrite( rollPin,      roll     );
}
