// vim:ft=c
//the H bridge takes two outputs from the Arduino to control the motor.
byte pwm_pin = 9;
byte motor_pin0 = 2;
byte motor_pin1 = 3;

// potentiometer
byte pot_pin = 16;

// direction switch
byte switch_pin = 4;

void setup() {
    // setup the motor control pins as outputs
    pinMode(motor_pin0, OUTPUT);
    pinMode(motor_pin1, OUTPUT);
    pinMode(pwm_pin, OUTPUT);

    pinMode(switch_pin, INPUT);
    pinMode(pot_pin, INPUT);

    // start the motor on full to get it going
    analogWrite(pwm_pin, 255);
}

void loop() {
    // read the pot
    byte duty_cycle = analogRead(pot_pin) / 4;
    int direction = digitalRead(switch_pin);
    analogWrite(pwm_pin, duty_cycle);
    if (direction) {
        digitalWrite(motor_pin0, LOW);
        digitalWrite(motor_pin1, HIGH);
    }
    else {
        digitalWrite(motor_pin0, HIGH);
        digitalWrite(motor_pin1, LOW);
    }
}




