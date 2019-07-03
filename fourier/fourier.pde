//Given a series of points, calculate the Fourier series for it, then plot that series

class Complex {
  double a,b;
  Complex(double La, double Lb) {
    a=La;
    b=Lb;
  }
  Complex add(Complex that) {
    return Complex(this.a+that.a,this.b+that.b);
  }
  Complex sub(Complex that) {
    return Complex(this.a-that.a,this.b-that.b);
  }
  Complex mul(Complex that) {
    return Complex(this.a*that.a-this.b*that.b,
                   this.a*that.b+this.b*that.a);
  }
  Complex div(Complex that) {
    double denom=that.a*that.a+that.b*that.b;
    return Complex((this.a*that.a+this.b*that.b)/denom,(this.b*that.a-this.a*that.b)/denom);
  }

abstract class Path {
  
