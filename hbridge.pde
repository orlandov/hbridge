/*
    Control two motors from an Arduino attached to a L293D H-Bridge IC. 
    Orlando Vazquez, 2008
    vim:ft=cpp
*/

/*
    The H bridge takes 3 outputs from the Arduino to control each motor.
    * enable (aka PWM)
    * output1
    * output2
*/

byte motor0_pwm = 9;
byte motor0_pin0 = 2;
byte motor0_pin1 = 3;

byte motor1_pwm = 6;
byte motor1_pin0 = 4;
byte motor1_pin1 = 5;

// potentiometer
byte pot_pin = 2;

// direction switch
byte switch_pin = 7;

void setup() {
    // setup the motor control pins as outputs
    pinMode(motor0_pwm, OUTPUT);
    pinMode(motor0_pin0, OUTPUT);
    pinMode(motor0_pin1, OUTPUT);
    pinMode(motor1_pwm, OUTPUT);
    pinMode(motor1_pin0, OUTPUT);
    pinMode(motor1_pin1, OUTPUT);

    pinMode(switch_pin, INPUT);

    // start the motor on full to get it going
    analogWrite(motor0_pwm, 255);
    analogWrite(motor1_pwm, 255);
}

void loop() {
    // read the pot
    byte duty_cycle = analogRead(pot_pin) / 4;
    int direction = digitalRead(switch_pin);

    analogWrite(motor0_pwm, duty_cycle);
    analogWrite(motor1_pwm, duty_cycle);
    if (direction) {
        digitalWrite(motor0_pin0, LOW);
        digitalWrite(motor0_pin1, HIGH);
        digitalWrite(motor1_pin0, LOW);
        digitalWrite(motor1_pin1, HIGH);
    }
    else {
        digitalWrite(motor0_pin1, LOW);
        digitalWrite(motor0_pin0, HIGH);
        digitalWrite(motor1_pin0, HIGH);
        digitalWrite(motor1_pin1, LOW);
    }
}




