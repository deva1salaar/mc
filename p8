#include <LPC214x.H>
void delay(unsigned int count) {
unsigned int i;
for(i=0; i<count; i++);
}
void stepper_rotate(int direction) {
const unsigned char step_sequence[] = {0x09, 0x08, 0x0C, 0x04, 0x06, 0x02, 0x03, 0x01};
static int step = 0;
int i;
if(direction == 1) { // Clockwise
for(i=0; i<50; i++) {
IOPIN0 = (IOPIN0 & 0xFFFFFF00) | step_sequence[step];
step = (step + 1) % 8;
delay(10000);
}
}
else { // Anti-clockwise
for(i=0; i<50; i++) {
IOPIN0 = (IOPIN0 & 0xFFFFFF00) | step_sequence[step];
step = (step - 1 + 8) % 8;
delay(10000);
}
}
}
int main() {
PINSEL0 = 0x00000000; // Configure P0.0 to P0.7 as GPIO
IODIR0 = 0x000000FF; // P0.0 to P0.7 as output
while(1) {
stepper_rotate(1); // Clockwise
delay(500000);
stepper_rotate(0); // Anti-clockwise
delay(500000);
}
}

Pro 2
