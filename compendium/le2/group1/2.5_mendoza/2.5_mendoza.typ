
#import "../../../../template.typ": project

#show: project.with(
  title: "Newton's Method: Solved Problems",
  contributor: "Janelle Mendoza",
  date: "November 9, 2026",
)

#show bibliography: set heading(numbering: none)
#let small(body) = text(size: 9.5pt, body)


#heading(numbering: none)[Problem 1: Scalar Newton's Method]

#block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, stroke: 0.5pt + luma(150))[
  *Scalar Newton's Method*
  #line(length: 100%)

  *Reference:* #cite(<burden2010numerical>) (Sec. 2.3, Exercise 1, p. 75).

  *Problem Statement:* \
  Let $f(x)=x^2-6$ and $p_0=1$. Use Newton's Method to compute $p_2$.
]

=== Solution

#pad(left: 2em)[
  #set par(spacing: 0.5em)

  *Given function and derivative*
  $ f(x)=x^2-6, quad f'(x)=2x. $

  *Newton correction and update*
  $ Delta p_k=-frac(f(p_k),f'(p_k)), quad p_(k+1)=p_k+Delta p_k. $

  *First iteration ($k=0$)*
  $ p_0=1, $
  $ f(p_0)=1^2-6=-5, quad f'(p_0)=2(1)=2. $
  $ Delta p_0=-frac(-5,2)=frac(5,2)=2.5. $
  $ p_1=p_0+Delta p_0=1+2.5=3.5. $

  *Second iteration ($k=1$)*
  $ p_1=3.5, $
  $ f(p_1)=(3.5)^2-6=6.25, quad f'(p_1)=2(3.5)=7. $
  $ Delta p_1=-frac(6.25,7) approx -0.8928571429. $
  $ p_2=p_1+Delta p_1=3.5-0.8928571429. $

  *Answer*
  $ p_2 approx 2.6071428571. $
]

#heading(numbering: none)[Problem 2: Newton's Method for a Nonlinear System]

#block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, stroke: 0.5pt + luma(150))[
  *Newton's Method for a Nonlinear System*
  #line(length: 100%)

  *Reference:* #cite(<burden2010numerical>) (Sec. 10.2, Exercise 1(c), p. 645).

  *Problem Statement:* \
  Perform two Newton iterations from $x^((0))=mat(0;0)$ for the system
  $ cases(
    x_1(1-x_1)+4x_2=12,
    (x_1-2)^2+(2x_2-3)^2=25
  ) $
]

=== Solution

#pad(left: 2em)[
  #set par(spacing: 0.5em)

  *Residual vector*
  $ F(x)=mat(
    x_1(1-x_1)+4x_2-12;
    (x_1-2)^2+(2x_2-3)^2-25
  ). $

  *Jacobian matrix*
  $ J_F(x)=mat(
    1-2x_1, 4;
    2x_1-4, 8x_2-12
  ). $

  *Newton correction and update*
  $ J_F(x^((k))) Delta x^((k))=-F(x^((k))), $
  $ x^((k+1))=x^((k))+Delta x^((k)). $

  *First iteration ($k=0$)*
  $ x^((0))=mat(0;0). $

  $ f_1(0,0)
    &=0(1-0)+4(0)-12=-12, \
    f_2(0,0)
    &=(0-2)^2+(2(0)-3)^2-25 \
    &=4+9-25=-12. $

  $ F(x^((0)))=mat(-12;-12), quad
    J_F(x^((0)))=mat(1,4;-4,-12). $

  Solve for the correction:
  $ mat(1,4;-4,-12)
    mat(Delta x_1^((0));Delta x_2^((0)))
    =mat(12;12). $

  $ Delta x_1^((0))+4 Delta x_2^((0))=12, $
  $ -4 Delta x_1^((0))-12 Delta x_2^((0))=12. $

  From the first equation:
  $ Delta x_1^((0))=12-4 Delta x_2^((0)). $

  Substituting into the second equation:
  $ -4(12-4 Delta x_2^((0)))
    -12 Delta x_2^((0))=12, $
  $ -48+4 Delta x_2^((0))=12, $
  $ Delta x_2^((0))=15. $

  $ Delta x_1^((0))=12-4(15)=-48. $

  Apply the update:
  $ x^((1))=mat(0;0)+mat(-48;15)
    =mat(-48;15). $

  *Second iteration ($k=1$)*

  $ f_1(-48,15)
    &=(-48)(1+48)+4(15)-12 \
    &=-2352+60-12=-2304, \
    f_2(-48,15)
    &=(-48-2)^2+(2(15)-3)^2-25 \
    &=2500+729-25=3204. $

  $ F(x^((1)))=mat(-2304;3204). $

  $ J_F(x^((1)))
    &=mat(
      1-2(-48), 4;
      2(-48)-4, 8(15)-12
    ) \
    &=mat(97,4;-100,108). $

  Solve for the correction:
  $ mat(97,4;-100,108)
    mat(Delta x_1^((1));Delta x_2^((1)))
    =mat(2304;-3204). $

  $ 97 Delta x_1^((1))+4 Delta x_2^((1))=2304, $
  $ -100 Delta x_1^((1))+108 Delta x_2^((1))=-3204. $

  Solving for the correction:
  $ D&=(97)(108)-(4)(-100) \
    &=10876, \

    Delta x_1^((1))
    &=frac((2304)(108)-(4)(-3204),D) \
    &=frac(261648,10876)
    approx 24.05737403, \

    Delta x_2^((1))
    &=frac((97)(-3204)-(2304)(-100),D) \
    &=frac(-80388,10876)
    approx -7.39132034. $

  *Answer*
  $ x^((2))=mat(-48;15)+mat(24.05737403;-7.39132034). $

  $ x^((2)) approx mat(-23.94262597;7.60867966). $
]


#heading(numbering: none)[Problem 3: Role of the Jacobian in Newton's Method]

#block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, stroke: 0.5pt + luma(150))[
  *Role of the Jacobian in Newton's Method*
  #line(length: 100%)

  *Problem Statement:* \
  Why is the Jacobian matrix necessary when extending Newton's Method from a single nonlinear equation to a system of nonlinear equations? Explain its role in multivariable linearization.
]

=== Solution

#pad(left: 2em)[
  #set par(spacing: 0.5em)

  The Jacobian matrix is necessary because a nonlinear system involves multiple functions and variables, which cannot be described by a single derivative. It contains the first-order partial derivatives used to approximate the nonlinear system as a linear system.

  In Newton's Method, the Jacobian is used to calculate the correction:

  $ J_F(x^((k))) Delta x^((k))=-F(x^((k))). $

  The correction is then added to the current estimate:

  $ x^((k+1))=x^((k))+Delta x^((k)). $

  Thus, the Jacobian allows Newton's Method to obtain an improved approximation by solving a linear system at each iteration. #cite(<driscoll_braun_newton>)
]


#heading(numbering: none)[Problem 4: Scalar Newton's Method for a Cubic Equation]

#block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, stroke: 0.5pt + luma(150))[
  *Scalar Newton's Method for a Cubic Equation*
  #line(length: 100%)

  *Problem Statement:* \
  Let $f(x)=x^3-2x-5$ and $p_0=2$. Use Newton's Method to compute $p_3$.
]

=== Solution

#pad(left: 2em)[
  #set par(spacing: 0.5em)

  *Given function and derivative*
  $ f(x)=x^3-2x-5, quad f'(x)=3x^2-2. $

  *Newton correction and update*
  $ Delta p_k=-frac(f(p_k),f'(p_k)), quad
    p_(k+1)=p_k+Delta p_k. $

  *First iteration ($k=0$)*
  $ p_0=2, $
  $ f(p_0)=2^3-2(2)-5=-1, $
  $ f'(p_0)=3(2)^2-2=10. $
  $ Delta p_0=-frac(-1,10)=0.1. $
  $ p_1=p_0+Delta p_0=2+0.1=2.1. $

  *Second iteration ($k=1$)*
  $ p_1=2.1, $
  $ f(p_1)=(2.1)^3-2(2.1)-5=0.061, $
  $ f'(p_1)=3(2.1)^2-2=11.23. $
  $ Delta p_1=-frac(0.061,11.23)
    approx -0.005431879. $
  $ p_2=p_1+Delta p_1
    =2.1-0.005431879
    approx 2.094568121. $

  *Third iteration ($k=2$)*
  $ p_2 approx 2.094568121, $
  $ f(p_2)=(2.094568121)^3-2(2.094568121)-5
    approx 0.0001857232, $
  $ f'(p_2)=3(2.094568121)^2-2
    approx 11.16164684. $
  $ Delta p_2=-frac(0.0001857232,11.16164684)
    approx -0.0000166394. $
  $ p_3=p_2+Delta p_2
    approx 2.094568121-0.0000166394. $

  *Answer*
  $ p_3 approx 2.094551482. $
]

#bibliography(
  "../../../../resources/bibs/compendium/le2/2.5_mendoza.bib",
  style: "apa",
)
