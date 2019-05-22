
#include <SPI.h>
#include <Pixy2.h>
//#define UI
//PARAMETERS
#define R 0.0325
#define L 0.13

#define R_PWM_PIN 6 /* pwm signal control speed of right wheel. */
#define L_PWM_PIN 5 /* pwm signal control speed of left wheel. */
#define LE_PIN1 2  //LEFT ENGINE PIN 1
#define LE_PIN2 3  //LEFT ENGINE PIN 2
#define RE_PIN1 7  //RIGHT ENGINE PIN 1
#define RE_PIN2 4  //RIGHT ENGINE PIN 2

void feedback_error();

// This is the main Pixy object 
Pixy2 pixy;
const float invCB[4] = {30.7692, 2, 30.7692, -2};
const float k1 = -4;
const float k2 = -20;
//Esta referencia tiene que ver con la distancia pero cambia 
//Su calibracion dependiendo del tamano del objeto.
float ref1 = 0.605; // LA DISTANCIA DEL OBJETO QUE HACE REFERENCIA AL TAMANO DEL OBJETO
//Es el equivalente a tener un angulo 0 respecto del objeto. 
float ref2 = 0; //ES EL CENTRO DEL OBJETO

float e1 = 0;
float e2 = 0;
float ke1 = 0;
float ke2 = 0;
float y1 = 0;
float y2 = 0;
uint8_t rm_pwm_dc = 0;
uint8_t lm_pwm_dc = 0;
float wR = 0;
float wL = 0;
uint8_t flag = 0;

void setup() 
{
  // put your setup code here, to run once:
  
  /* max pwm frequency pin 5 or 6, 62,500 Hz divided by 1. */
  //TCCR0B = TCCR0B & 0b11111000 | 0x05; //max 0x05

  /** Right Now pwm frequency is constant at 31250/1024 = 31 hz. */
  pinMode(R_PWM_PIN, OUTPUT);
  pinMode(L_PWM_PIN, OUTPUT);
  /** These are the signals that control the direction of the car. */
  /** Configured as outputs. */
  pinMode(RE_PIN1, OUTPUT);
  pinMode(RE_PIN2, OUTPUT);
  pinMode(LE_PIN1, OUTPUT);
  pinMode(LE_PIN2, OUTPUT);
  
  pixy.init();
  #ifdef UI
  Serial.begin(9600);
  #endif
}
void loop() {
  #ifdef UI
  // put your main code here, to run repeatedly:
int incomingByte = 0; // for incoming serial data
  //reply only when you receive data:
  if (Serial.available() > 0 && flag == 0) {
    // read the incoming byte:
    incomingByte = Serial.read();

    // say what you got:
    Serial.print("I received: ");
    Serial.println(incomingByte, DEC);
    ref1 = incomingByte/100;
    flag = 1;
  }
  
  if(flag)
  {
  #endif
    for(;;){
      feedback_error();
    }
  #ifdef UI
  }
  #endif
  

  
}

void feedback_error()
{
  // grab blocks!
  pixy.ccc.getBlocks();
  y1 = (-0.0094*pixy.ccc.blocks[0].m_height) + 1.3; // "DISTANCIA en metros" Aproximacion Lineal por Calibracion.
  y2 = (0.0031*pixy.ccc.blocks[0].m_x) - 0.49;  // "ANGULO en radianes" Aproximacion Lineal por Calibracion.
//  Serial.print("distancia m: ");
//  Serial.println(y1);
//  Serial.print("angulo rads: ");
//  Serial.println(y2);
  e1 = ref1 - y1;
  e2 = ref2 - y2;
  
  ke1 = -k1 * e1;
  ke2 = -k2 * e2;

//  Serial.print("error distancia m: ");
//  Serial.println(e1);
//  Serial.print("error angulo rads: ");
//  Serial.println(e2);
  
  wL = invCB[0]*ke1 + invCB[1]*ke2;
  wR = invCB[2]*ke1 + invCB[3]*ke2;

//  Serial.print("wR:");
//  Serial.println(wR);
//  Serial.print("wL:");
//  Serial.println(wL);
  // Si la senal de control es negativa tenemos 
  // que ir hacia adelante

  if(wL<0)
  {
    digitalWrite(LE_PIN1, LOW);
    digitalWrite(LE_PIN2, HIGH);
//    Serial.print("Izq. Adelante");
  }
  else
  {
    digitalWrite(LE_PIN1, HIGH);
    digitalWrite(LE_PIN2, LOW);
//    Serial.print("Izq. Atras");
  }

  if(wR<0)
  {
    digitalWrite(RE_PIN1, LOW);
    digitalWrite(RE_PIN2, HIGH);
//    Serial.print("Der. Adelante");
  }
  else
  {
    digitalWrite(RE_PIN1, HIGH);
    digitalWrite(RE_PIN2, LOW);
//    Serial.print("Der. Atras");
  }

  /************CALIBRACION**************/
  //Aprox. el 100% de duty cycle corresponde a 34.5 rad/s
  //Las entradas pueden pedirnos que vayamos a una velocidad
  //Superior a 34.5 rad/s pero lo maximo que podemos entregar es esto.
  //Por lo tanto:'
  wL = abs(wL);
  wR = abs(wR);
  if(wL>34.5)
  {
    wL = 34.5;
  }
  if(wR>34.5)
  {
    wR = 34.5;
  }
  rm_pwm_dc = (uint8_t) 7.41*wR;
  lm_pwm_dc = (uint8_t) 7.41*wL;
//  rm_pwm_dc =  ((2.7*wR)+12);
//  lm_pwm_dc =  ((2.7*wL)+12);
  
  /** val goes from 0 to 255. */
  /** where 255 means 100% duty cycle pwm signal. */
  analogWrite(R_PWM_PIN, rm_pwm_dc);
  analogWrite(L_PWM_PIN, lm_pwm_dc);

  //delay(1000);
//  Serial.print("motor derecho:");
//  Serial.println(rm_pwm_dc);
//  Serial.print("motor izquierdo:");
//  Serial.println(lm_pwm_dc);
//  Serial.print("e1:");
//  Serial.println(e1);
//  Serial.print("e2:");
//  Serial.println(e2);
}
