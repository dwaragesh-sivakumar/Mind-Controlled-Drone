/*
 * How does the mind-controlling drone operate?
 * - This code is used for the controller circuit based on the input values that were passed from the mindwave controller
     The purpose of the code is to receive the concentration and cortisol values of a user to send it to the controller circuit
 *
 * - The drone will operate under the supervision of the user, who can see how they steer the drone via a terminal display of a live altimeter
 * - Key notes:
     A. Throtte and Yaw: Nose goes perpendicular to the y-axis, going left and right
     B. Pitch and Roll: Nose goes perpendicular to the x-axis, going up and down
 *
 */

// Import the default serial library from Arduino 
import processing.serial.*;

// What is the receiver? (Arduino back-end code)
Serial receiver ;

// Import Mindset library for the MindWave sensor
import pt.citar.diablu.processing.mindset.*;
MindSet mindSet;

// Set initial values for the drone to operate up, down, left, and right:
int throttle  = 0;
int yaw, pitch, roll;
yaw = pitch = roll = 127;

// Constructing a foundation for the initialization of the drone's operation in the air:
void setup() 
{
  // Capacity of how much the drone can intake input values that were passed from the user:
  size(150, 500);

  // COM3 port serial input values to display in the computer:
  receiver  = new Serial(this, "COM5", 115200);

  // Initiate the mindset communication that will be received from the user:
  mindSet = new MindSet(this, "COM4");

  // To get detailed imaging of the terminal display:
  smooth();

  // Set stroke properties of the terminal display:
  strokeWeight(5);
  stroke(255);
  strokeCap(SQUARE);

  // Set line color of the plus sign in the terminal display (the altimeter)
  fill(255);
} 

// Initialization of the formation of the altimeter:
void draw()
{
  // Start with a dark wall:
  background(0);

  // Minimum attention required (40%)
  line( 0, height*0.60, width, height*.60);

  // Line rises alogn the y-axis to measure how concentrated the user is:
  // Example: by 50% (0.5) attention the height value is (100 - 50) 50% (0.5) from top
  line( width*.5, height, width*.5, height*map( float( attentionLevel ) / 100, 0, 1, 1, 0 ) );

  // Lift the attention level to the throttle, pitch, roll, and yaw variables for the drone:
  // 40 = Minimum attention
  // 100 = Maximum attention
  // 30 = 8-bit min value for Arduino given by the user
  // 255 = 8-bit max value for Arduino given by the user
  throttle = int( map( attentionLevel, 20, 100, 30, 255 ) );
  pitch = int( map(attentionLevel, 20, 100, 30, 255) );
  roll = int( map(attentionLevel, 20, 100, 30, 255) );
  yaw = int( map(attentionLevel, 20, 100, 30, 255) );

  // Constrain values to 8 bit values to prevent errors
  throttle    = constrain( throttle, 0, 255);
  pitch       = constrain( pitch, 0, 255);
  roll        = constrain( roll, 0, 255);
  yaw         = constrain( yaw, 0, 255);

  // Stable connection --> Send values to the receiver:
  {    
    println( "attentionLevel: "+attentionLevel+" throttle: "+throttle+" yaw: "+yaw+" pitch: "+pitch+" roll: "+roll );
    receiver.write( "throttle: "+throttle+" yaw: "+yaw+" pitch: "+pitch+" roll: "+roll );
  }
  
  // Terminate the program if user pressed 'k' or ESC:
  void keyPressed() 
  {
    if (key == 'k' || key == ESC) 
    { 
        receiver .write("throttle: "+0+" yaw: "+127+" pitch: "+127+" roll: "+127);
        exit();
    }
  }

// MindSet variables and functions
int signalStrength, attentionLevel;
signalStrength = attentionLevel = 0;

// Attention level is set to the user input for further operations:
public void attentionEvent( int attentionLevel_val ) { attentionLevel = attentionLevel_val; }

// Condition that takes care of how signal noise is activated when the connection is not stable enough:
public void poorSignalEvent( int signalNoise ) 
{
  // Mindset adjusts to how much the signal gains or loses the noise:
  if ( signalNoise == 200 ) { println( "Mindset is not touching your skin!" ); }

  // Map the strength of the signal noise in the terminal display:
  signalStrength = int( map( ( 200-signalNoise ), 200, 0, 100, 0 ) );
  println( "Signal strength: " + signalStrength + "%" );
}
