#define min_order 26
void convolution(int adc_in, double * out);

#ifdef convolution_fixed_signals
void convolve (double *p_coeffs, int p_coeffs_n,
               double *p_in, double *p_out, int n);
#endif

int analogPin = A0;
double coeffs[min_order] = {0.000221839492027431,  -0.000686712923790387, 0.00166967555226871,
-0.00346940815990099,  0.00649222071295951, -0.0112654800561180, 0.0184908428711627,
-0.0291804415375988, 0.0450185697007176,  -0.0694013246958671, 0.111041066975521,
-0.202058512471911,  0.633171821234430, 0.633171821234430, -0.202058512471911,
0.111041066975521, -0.0694013246958671, 0.0450185697007176,  -0.0291804415375988,
0.0184908428711627,  -0.0112654800561180, 0.00649222071295951, -0.00346940815990099,
0.00166967555226871, -0.000686712923790387, 0.000221839492027431};

void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200);
}

void loop() {
  // put your main code here, to run repeatedly:

  double out;

  while(1)
  {
    convolution(analogRead(analogPin), &out);
    Serial.println(out);
    out = 0;
  }

}

void convolution(int adc_in, double * out)
{
  static double x_signal[min_order] = {0};
  
  for(int i = min_order; i >= 1; i--){
    x_signal[i] = x_signal[i-1];
    *out += x_signal[i] * coeffs[i];
  }
  x_signal[0] = adc_in;
  *out += x_signal[0] * coeffs[0];
  
}

#ifdef convolution_fixed_signals
void convolve (double *p_coeffs, int p_coeffs_n,
               double *p_in, double *p_out, int n)
{
  int i, j, k;
  double tmp;

  for (k = 0; k < n; k++)  //  position in output
  {
    tmp = 0;

    for (i = 0; i < p_coeffs_n; i++)  //  position in coefficients array
    {
      j = k - i;  //  position in input

      if (j >= 0)  //  bounds check for input buffer
      {
        tmp += p_coeffs [k] * p_in [j];
      }
    }

    p_out [i] = tmp;
  }
}
#endif
