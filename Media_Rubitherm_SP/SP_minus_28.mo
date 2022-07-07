within slPCMlib.Media_Rubitherm_SP;
package SP_minus_28 "Rubitherm SP-28; data taken from: data sheet; last access: 02.12.2019."
   extends  slPCMlib.Interfaces.partialPCM;
      
  // ----------------------------------
  redeclare replaceable record propData "PCM record"
      
    constant String mediumName = "SP_minus_28";
      
    // --- parameters for phase transition functions ---
    constant Boolean modelForMelting        = true;
    constant Boolean modelForSolidification = true;
    constant Modelica.Units.SI.Temperature rangeTmelting[2] =  {2.411500000000000e+02, 2.481500000000000e+02}
             "temperature range melting {startT, endT}";
    constant Modelica.Units.SI.Temperature rangeTsolidification[2] = {2.401500000000000e+02, 2.471500000000000e+02}
             "temperature range solidification {startT, endT}";
      
    // --- parameters for heat capacity and enthalpy ---
    constant Modelica.Units.SI.SpecificHeatCapacity[2] cpS_linCoef = {2.000000000000000e+03, 0.0}
             "solid specific heat capacity, linear coefficients a + b*T";
    constant Modelica.Units.SI.SpecificHeatCapacity[2] cpL_linCoef = {2.000000000000000e+03, 0.0}
             "liquid specific heat capacity, linear coefficients a + b*T";
    constant Modelica.Units.SI.SpecificEnthalpy   phTrEnth = 2.420000000000000e+05
             "scalar phase transition enthalpy";
      
    // --- reference values ---
    constant Modelica.Units.SI.Temperature            Tref = 273.15+2.500000000000000e+01
             "reference temperature";
    constant Modelica.Units.SI.SpecificEnthalpy  href = 0.0
             "reference enthalpy at Tref";
      
  end propData;
  // ----------------------------------
  redeclare function extends phaseFrac_complMelting
    "Returns liquid mass phase fraction for complete melting processes"
  protected
    constant Integer len_x    = data_H.len_x;
    constant Real data_x[:]   = data_H.data_x;
    constant Real data_y[:]   = data_H.data_y;
    constant Real m_k[:]      = data_H.m_k;
    constant Real iy_start[:] = data_H.iy_start;
    constant Real iy_scaler   = data_H.iy_scaler;
  algorithm 
    (xi, dxi) := slPCMlib.BasicUtilities.cubicHermiteSplineEval(T-273.15, 
                 len_x, data_x, data_y, m_k, iy_start, iy_scaler);
  end phaseFrac_complMelting;
  // ----------------------------------
  redeclare function extends phaseFrac_complSolidification
    "Returns liquid mass phase fraction for complete solidification processes"
  protected
    constant Integer len_x    = data_C.len_x;
    constant Real data_x[:]   = data_C.data_x;
    constant Real data_y[:]   = data_C.data_y;
    constant Real m_k[:]      = data_C.m_k;
    constant Real iy_start[:] = data_C.iy_start;
    constant Real iy_scaler   = data_C.iy_scaler;
  algorithm
    (xi, dxi) := slPCMlib.BasicUtilities.cubicHermiteSplineEval(T-273.15, 
                 len_x, data_x, data_y, m_k, iy_start, iy_scaler);
  end phaseFrac_complSolidification;
  // ----------------------------------
  package data_H "spline interpolation data for heating"
    extends Modelica.Icons.Package;    
    constant Integer  len_x    = 8; 
    constant Real[8] data_x   = {-3.200000000000000e+01, -3.100000000000000e+01, -3.000000000000000e+01, -2.900000000000000e+01, -2.800000000000000e+01, -2.700000000000000e+01, -2.600000000000000e+01, -2.500000000000000e+01}; 
    constant Real[8] data_y   = {0.000000000000000e+00, 4.132231404958678e-03, 2.066115702479339e-02, 4.752066115702480e-01, 4.380165289256198e-01, 5.785123966942149e-02, 4.132231404958678e-03, 0.000000000000000e+00}; 
    constant Real[8] m_k      = {4.132231404958678e-03, 2.172769793511867e-03, 4.953915129207057e-02, 0.000000000000000e+00, -1.115702479338844e-01, -1.597433393662097e-01, -1.216977634179403e-02, -2.361052995561789e-03}; 
    constant Real[8] iy_start = {0.000000000000000e+00, 2.228198476232658e-03, 1.067312462396059e-02, 2.625989526916971e-01, 7.282560732577079e-01, 9.800681245692020e-01, 9.987519532365885e-01, 1.000000000000000e+00}; 
    constant Real    iy_scaler = 9.994591856050963e-01; 
  end data_H;
  // ----------------------------------
  package data_C "spline interpolation data for cooling"
    extends Modelica.Icons.Package;    
    constant Integer  len_x    = 8; 
    constant Real[8] data_x   = {-3.300000000000000e+01, -3.200000000000000e+01, -3.100000000000000e+01, -3.000000000000000e+01, -2.900000000000000e+01, -2.800000000000000e+01, -2.700000000000000e+01, -2.600000000000000e+01}; 
    constant Real[8] data_y   = {0.000000000000000e+00, 7.843137254901961e-03, 5.882352941176471e-02, 4.078431372549020e-01, 5.019607843137255e-01, 1.176470588235294e-02, 1.176470588235294e-02, 0.000000000000000e+00}; 
    constant Real[8] m_k      = {6.062650601419584e-03, 1.727429174891226e-02, 1.519625029564237e-01, 2.215686274509804e-01, 0.000000000000000e+00, 0.000000000000000e+00, 0.000000000000000e+00, -1.176470588235294e-02}; 
    constant Real[8] iy_start = {0.000000000000000e+00, 2.982833861611357e-03, 2.505935243044814e-02, 2.522546510908471e-01, 7.249184686317190e-01, 9.814001811530344e-01, 9.931474351616443e-01, 1.000000000000000e+00}; 
    constant Real    iy_scaler = 9.985165907318386e-01; 
  end data_C;
  // ----------------------------------
  redeclare function extends density_solid "Returns solid density"
  algorithm 
    rho := 1.300000000000000e+03;
  end density_solid;
  // ----------------------------------
  redeclare function extends density_liquid "Returns liquid density"
  algorithm 
    rho := 1.200000000000000e+03;
  end density_liquid;
  // ----------------------------------
  redeclare function extends conductivity_solid "Returns solid thermal conductivity"
  algorithm 
    lambda := 6.000000000000000e-01;
  end conductivity_solid;
  // ----------------------------------
  redeclare function extends conductivity_liquid "Returns liquid thermal conductivity"
  algorithm 
    lambda := 6.000000000000000e-01;
  end conductivity_liquid;
  // ----------------------------------
      
annotation(Documentation(
  info="<html>
  <p>
  This package contains solid and liquid properties for the PCM:  <strong>Rubitherm SP-28</strong>.<br><br>
  Information taken from: data sheet - last access 02.12.2019.<br><br>
  It also contains the phase transition functions for
  <ul>
  <li>complete melting       :  true</li>
  <li>complete solidification:  true</li>
  </ul></p><p>
  These functions are modelled by piece-wise splines using <strong>pchip</strong> method,
  see also 
  <blockquote>
  <p>
  Barz, T., Krämer, J., & Emhofer, J. (2020). Identification of Phase
  Fraction–Temperature Curves from Heat Capacity Data for Numerical
  Modeling of Heat Transfer in Commercial Paraffin Waxes.
  Energies, 13(19), 5149.
  <a href>doi.org/10.3390/en13195149</a>.
  </p>
  </blockquote>
  </p></html>",
  revisions="<html>
  <ul>
  <li>file creation date: 07-Jul-2022  </ul>
  </html>"));
  end SP_minus_28;