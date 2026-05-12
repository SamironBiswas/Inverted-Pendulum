
const int LEDPIN = 9;
void setup() {
}
void loop() {
  for(int i=0; i<256; i++){
    float norm = i / 256.0;
    int correct = pow(norm, 2.2)*255;
    analogWrite(LEDPIN, correct);
    delay(10);
  }
  for(int i=255; i>=0; i--){
    float norm = i / 256.0;
    int correct = pow(norm, 2.2)*255;
    analogWrite(LEDPIN, correct);
    delay(10);
  }
}
