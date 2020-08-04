# Internet of Thing - Mind-controlling Drone
  -	Led a team of five to successfully engineer a mind-controlling drone to do various tasks as the user requests:
    -	The project can be divided into two components: Hardware and Software
      -	Hardware
          -	Responsible for manipulating the anatomy of the drone controller 
             -	Desoldered the potentiometers and replaced it with four 10K Ohms resistors
             -	Soldered strong core wires to the resistors to connect to a quadruple, low pass filter
             -	Defined all the wires to match each direction using the Arduino MKR 1000
          -	Responsible for connecting the manipulated, controller circuit to analyze the serial input values via a laptop
       -	Software
          - Responsible for installing two different software for two different purposes:
             -	Processing 3.3.6
                -	After connecting to the MindWave sensor via Bluetooth, this code generates an array of concentration and cortisol values from the user.
             -	Arduino 1.8.9
                -	This software receives all the input values and sends it to the controller circuit. At the same time, a terminal will display an altimeter that will show how high the drone will fly.
          -	Worked as a team to configure a Raspberry Pi Camera on the drone to cover a live footage of the audience via an app that is operated with the aid of an IP Address.


- Created by: Dwaragesh Sivakumar -- https://github.com/Dwaragesh
