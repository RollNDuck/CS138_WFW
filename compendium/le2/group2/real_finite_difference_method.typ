#import "../../../template.typ": project
#show: project.with(
  title: "Finite Difference Method: Solved Problems",
  contributor: "Real, Karl Benedict C.",
  date: "November 9 2026",
)

#show bibliography: set heading(numbering: none)

#import "@preview/zebraw:0.6.3": *
#show: zebraw

#set heading(numbering: none)
#set math.mat(delim: "[")

= Problem 1
Solve the BVP
$
  y'' + x y' - x y = 2x, quad
  y(0) = 1, y(2) = 8
$
using central FDA with $h = 0.5$. @niemeyerFiniteDifference

_Solution._
Since $h = 0.5$, we have $x_i = x_0 + 0.5i$ and so:
  $
    x_0 = 0, quad
    x_1 = 0.5, quad 
    x_2 = 1, quad 
    x_3 = 1.5, quad 
    x_4 = 2. 
  $
The goal is to find approximate values of $y(x)$ given the points $y_0$ to $y_4$. This can be done by replacing the derivatives with finite differences. Specifically, using central difference approximation,
$
  y(x_i) approx y_i, quad
  y'(x_i) approx frac(y_(i+1) - y_(i-1), 2h), quad
  y''(x_i) approx frac(y_(i+1) - 2y_i + y_(i-1), h^2).
$
Substituting these to the ODE:
$
  frac(y_(i+1) - 2y_i + y_(i-1), h^2) + x_i (frac(y_(i+1) - y_(i-1), 2h)) - x_i y_i = 2x_i
$
Rearranging,
$
  y_(i-1)(1/h^2 - x_i/(2h)) + y_i (-2/h^2 - x_i) + y_(i+1) (1/h^2 + x_i/(2h)) = 2x_i \
  y_(i-1)(1 - x_i h/2) + y_i (-2 - x_i h^2) + y_(i+1) (1 + x_i h/2) = 2x_i h^2
$
Substituting $h=0.5$,
$
  y_(i-1)(1 - 0.25x_i) + y_i (-2 - 0.25x_i) + y_(i+1) (1 + 0.25x_i) = 0.5x_i \ 
$
Since we already know the boundary points $y_0 = y(0) = 1$ and $y_4 = y(2) = 8$, we only have to solve for the interior points $y_1, y_2, y_3$. Applying the equation above for $i = 1, 2, 3$:
- $i=1$:
  $
    y_0 (1 - 0.25x_1) + y_1 (-2 - 0.25x_1) + y_2 (1 + 0.25x_1) = 0.5x_1 \ 
    1 (1 - 0.25 dot 0.5) + y_1 (-2 - 0.25 dot 0.5) + y_2 (1 + 0.25 dot 0.5) = 0.5 dot 0.5 \ 
    -2.125 y_1 + 1.125 y_2 = -0.625
  $
- $i=2$:
  $
    y_1 (1 - 0.25x_2) + y_2 (-2 - 0.25x_2) + y_3 (1 + 0.25x_2) = 0.5x_2 \ 
    y_1 (1 - 0.25 dot 1) + y_2 (-2 - 0.25 dot 1) + y_3 (1 + 0.25 dot 1) = 0.5 dot 1 \ 
    0.75 y_1 - 2.25 y_2 + 1.25 y_3 = 0.5 \ 
  $
- $i=3$:
  $
    y_2 (1 - 0.25 x_3) + y_3 (-2 - 0.25 x_3) + y_4 (1 + 0.25 x_3) = 0.5 x_3 \ 
    y_2 (1 - 0.25 dot 1.5) + y_3 (-2 - 0.25 dot 1.5) + 8(1 + 0.25 dot 1.5) = 0.5 dot 1.5 \ 
    0.625 y_2 - 2.375 y_3 = -10.25
  $
Therefore, we get the following matrix SLE:
$
  mat(
    -2.125, 1.125, 0;
    0.75, -2.25, 1.25;
    0, 0.625, -2.375
  ) mat(
    y_1; y_2; y_3
  ) = mat(
    -0.625; 0.5; -10.25
  )
$
Using `numpy` to solve the SLE:
```py
import numpy as np

A = np.array([
        [-2.125, 1.125, 0],
        [0.75, -2.25, 1.25],
        [0, 0.625, -2.375]
    ])

b = np.array([-0.625, 0.5, -10.25])

x = np.linspace(0, 2, 5)
y = np.linalg.solve(A, b)
print(y)
```
We get 
$
  Y = mat(y_1, y_2, y_3)^top = mat(2.07110208, 3.35652616, 5.19908583)^top.
$


= Problem 2
Consider the BVP
$
  ln(2 + x) y'' + x y' + 2y = cos(x), quad 0 < x < 1.2, \
  y'(0) = -1, y(1.2) = 2
$
Using $h = 0.4$, obtain a central difference approximation to the differential equation and form an SLE satisfied by $y_i approx y(i h)$, $j = 0, 1, 2$. @helmWorkbook33

_Solution._
In general, the central difference approximation to $p y'' + q y' + r y = s$ is
$
  y_(i-1) (p_i - h/2 q_i) + y_i (h^2 r_i - 2p_i) + y_(i+1) (p_i + h/2 q_i) = h^2 s_i.
$
In this case, $p(x) = ln(2+x)$, $q(x) = x$, $r(x) = 2$, and $s(x) = cos(x)$.

Since $h = 0.4$, the solution will consist of the points
$
  y_0 approx y(0), quad
  y_1 approx y(0.4), quad
  y_2 approx y(0.8), quad
  y_3 approx y(1.2) = 2.
$
The goal is to solve for the unknowns $y_0, y_1, y_2$. Note that at $i=0$, a ghost point $y_(-1)$ is introduced:
$
  y_(-1) (p_0 - h/2 q_0) + y_0 (h^2 r_0 - 2p_0) + y_1 (p_0 + h/2 q_0) = h^2 s_0.
$
We can express $y_(-1)$ in terms of points inside the domain by approximating the derivative in the boundary condition using central difference:
$
  y'(0) approx frac(y_1 - y_(-1), 2h) = -1 => y_(-1) = y_1 + 2h.
$
Substituting this to the other equation,
$
  (y_1 + 2h) (p_0 - h/2 q_0) + y_0 (h^2 r_0 - 2p_0) + y_1 (p_0 + h/2 q_0) = h^2 s_0 \
  y_0 (h^2 r_0 - 2p_0) + y_1 [(p_0 - h/2 q_0) + (p_0 + h/2 q_0)] = h^2 s_0 - 2h (p_0 - h/2 q_0) \
  y_0 (h^2 r_0 - 2p_0) + y_1 2p_0 = h^2 (s_0 + q_0) - 2h p_0 \
$

For $i=1$,
$
  y_0 (p_1 - h/2 q_1) + y_1 (h^2 r_1 - 2p_1) + y_2 (p_1 + h/2 q_1) = h^2 s_1
$

For $i=2$,
$
  y_1 (p_2 - h/2 q_2) + y_2 (h^2 r_2 - 2p_2) + y_3 (p_2 + h/2 q_2) = h^2 s_2 \
  y_1 (p_2 - h/2 q_2) + y_2 (h^2 r_2 - 2p_2) = h^2 s_2 - 2 (p_2 + h/2 q_2) \
$

So, we have the following matrix SLE:
$
  mat(
    h^2r_0 - 2p_0, 2p_0, 0;
    p_1 - h/2 q_1, h^2 r_1 - 2p_1, p_1 + h/2 q_1;
    0, p_2 - h/2 q_2, h^2 r_2 - 2p_2
  ) mat(
    y_0; y_1; y_2
  ) = mat(
    h^2 (s_0 + q_0) - 2h p_0; 
    h^2 s_1; 
    h^2 s_2 - 2 (p_2 + h/2 q_2)
  ) \
  mat(
    -1.066294, 1.386294, 0;
    0.795469, -1.430937, 0.955469;
    0, 0.869619, -1.739239
  ) mat(
    y_0; y_1; y_2
  ) = mat(
    -0.394518; 
    0.147369; 
    -2.267766
  )
$

= Problem 3 (Remix)
Consider the BVP
$
  9/2 y'' + 14y' + 48 y = x^2, quad
  y(0) = 0, y'(2) = 2.
$
Let $Y = mat(y_0, y_1, y_2, y_3, y_4)^top$ be an $O(h^2)$ solution of the BVP using finite difference method with $3$ interior points. What is $floor((y_1 - y_3) - (y_0 - y_2 + y_4))$?

_Solution._ Note that we will be using a total of $n = 2 + 3 = 5$ points. So, $h=(b-a)/(n-1) = (2-0)/(5-1) = 0.5$ and the nodes are:
$
  x_0 = 0, quad
  x_1 = 0.5, quad
  x_2 = 1, quad
  x_3 = 1.5, quad
  x_4 = 2.
$

Getting an $O(h^2)$ solution means using central difference approximation for all points. From Problem 2, the general formula for central FDA is
$
  y_(i-1) (p_i - h/2 q_i) + y_i (h^2 r_i - 2p_i) + y_(i+1) (p_i + h/2 q_i) = h^2 s_i
$
where $p(x) = 9/2$, $q(x) = 14$, $r(x) = 48$, and $s(x) = x^2$.

So, the stencil simplifies to:
$
  y_(i-1) (9/2 - 1/4 dot 14) + y_i (1/4 dot 48 - 2 dot 9/2) + y_(i+1) (9/2 + 1/4 dot 14) = 1/4 x_i^2 \
  y_(i-1) + 3 y_i + 8 y_(i+1) = 1/4 x_i^2 \
$

Since we already know $y_0 = y(0) = 0$, we have to solve for $y_i$ where $i = 1, 2, 3, 4$.

Note that at $i = 4$, a ghost point $y_5$ is introdruced:
$
  y_3 + 3 y_4 + 8 y_5 = 1/4 x_4^2
$

Using the other boundary point $y'(x_4 = 2) = 2$, 
$
  y'(x_4 = 2) approx frac(y_5 - y_3, 2h) = 2 => y_5 = y_3 + 2
$
Substituting this equation for $y_5$ and $x_4 = 2$,
$
  y_3 + 3 y_4 + 8 (y_3 + 2) = 1/4 (2)^2 \
  9y_3 + 3y_4 = -15 => 3y_3 + y_4 = -5
$
At $i=1$,
$
  y_0 + 3 y_1 + 8 y_2 = 1/4 x_1^2 \
  3 y_1 + 8 y_2 = 1/16 \
$
At $i=2$,
$
  y_1 + 3 y_2 + 8 y_3 = 1/4 x_2^2 \
  y_1 + 3 y_2 + 8 y_3 = 1/4 \
$
At $i=3$,
$
  y_2 + 3 y_3 + 8 y_4 = 1/4 x_3^2 \
  y_2 + 3 y_3 + 8 y_4 = 9/16 \
$

Thus, the SLE is
$
  mat(
    3, 8, 0, 0;
    1, 3, 8, 0;
    0, 1, 3, 8;
    0, 0, 3, 1
  ) mat(
    y_1; y_2; y_3; y_4
  ) = mat(
    1"/"16; 1"/"4; 9"/"16; -5
  )
$

Using `numpy` to solve for $mat(y_1, y_2, y_3, y_4)^top$,
```py
A = np.array([
    [3, 8, 0, 0],
    [1, 3, 8, 0],
    [0, 1, 3, 8],
    [0, 0, 9, 3]
])

b = np.array([0, 1/16, 9/16, -15])

x = np.linspace(0, 2, 5)
y = np.linalg.solve(A, b)
```
we get
$
  mat(y_1, y_2, y_3, y_4)^top = mat(-57.92222222, 21.72083333, -0.89722222, -2.30833333)^top.
$

Therefore #super(footnote([I originally just planned to make the stencil's coefficients be 1, 3, 8, but noticed that some combination of the solution is close to $3"x"$, so I added it in haha.])),
$
  floor((y_1 - y_3) - (y_0 - y_2 + y_4))
  &= floor((-57.9222 + -0.8972) - (0 - 21.7208 - 2.3083)) \
  &= floor(-32.9958) \
  &= -33
$

= AI Usage
I used ChatGPT to check my solution on the remix problem, as well as in making the bibliography for the solved problems. Here is the #link("https://chatgpt.com/share/6af19d73-1bcc-83ec-83ca-1ff6fbc1ec2f")[link] to the conversation.


#bibliography("../../../resources/bibs/compendium/le2/finite_difference.bib", style: "apa")