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

const byte motor0_pwm = 9;
const byte motor0_pin0 = 2;
const byte motor0_pin1 = 3;

const byte motor1_pwm = 6;
const byte motor1_pin0 = 5;
const byte motor1_pin1 = 4;

// potentiometer
const byte pot_pin = 2;

// direction switch
const byte switch_pin = 7;

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

// future refactor
struct motor {
    byte enabled;
    byte output0;
    byte output1;
};

void drive_forwards() {
    digitalWrite(motor0_pin0, HIGH);
    digitalWrite(motor0_pin1, LOW);
    digitalWrite(motor1_pin0, HIGH);
    digitalWrite(motor1_pin1, LOW);
}

void drive_backwards() {
    digitalWrite(motor0_pin0, LOW);
    digitalWrite(motor0_pin1, HIGH);
    digitalWrite(motor1_pin0, LOW);
    digitalWrite(motor1_pin1, HIGH);
}

int direction = 0;
bool pressed = 0;
bool prev_pressed = 0;

void loop() {
    // read the pot
    byte duty_cycle = analogRead(pot_pin) / 4;
    analogWrite(motor0_pwm, duty_cycle);
    analogWrite(motor1_pwm, duty_cycle);

    // toggle the directions
    prev_pressed = pressed;
    delay(10);
    pressed = digitalRead(switch_pin);
    if (pressed
        && (prev_pressed == 0)) {
        direction = !direction;
    }

    if (direction) {
        drive_backwards();
    }
    else {
        drive_forwards();
    }
}



