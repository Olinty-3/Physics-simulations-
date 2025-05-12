# Logistic Function 

The logistic funtion is a simple aproach to describe the evolution of a population: 

$$ x_{j+1} = 4r x_j (1 - x_j) $$

However we are not interested in the evolution of a population, but in the behavior of the solutions when the value of $r$ varies. For small values of $r$ $x_j$ would tend to the same solution for large values of $j$ independenly of the initial value, $x_0$. There is an $r$ from which you'll get two different solutions depending on $x_0$. As $r$ grows so does the number of solutions until you get a chaotic sistem. 

![alt text][logo]

[logo]:https://github.com/Olinty-3/Physics-simulations-/blob/main/1%20-%20Logistic%20function/Figure_1.png

This is a self-similar object, whcih means the hole object is exact or approximately similar to a part of itself, like fractals, though not all self-similar objects are. 

![alt text][logo2]

[logo2]:https://github.com/Olinty-3/Physics-simulations-/blob/main/1%20-%20Logistic%20function/Figure_2.png

The values of $r$ where the solution splits define a series ${r_n}$ and since the closeness to caos has universal properties we are able to compute universal values of caos theory from this simple graph. 

For $n \rightarrow \infty$ $r_n = r_\infty - c \delta^{-n}$ where $r_\infty$, $c$ and $\delta$ are constants and $\delta$ is universal.

$$ \delta = \lim_{n \rightarrow \infty} \frac{r_{n+1} - r_n}{r_{n+2} - r_{n+1}} $$ 

To compute the $r_n$ of the secuence we have to compare the last $2^n - 1$ values of $x$ and see that they are different. If I call $\delta_n$ to $delta$ without taking the limit I get: $\delta_1 = 4.7479$ and $\delta_2 = 4.5769$. Obviously the greater the $n$ the more similiar $\delta_n$ would be to $\delta$. However, the greater the $n$ the colser the values of $r_n$ are and so the greater must be the iteration for the computer to distinguish between them. 

There is another universal variable that can be computed from this diagram. First we have to find the maximum of our dinamical aplication, $x = 1/2$. Then $x_f$ will cut this value in multiple ocasions. Each time they concide it would be posible to trace a straight line to the closest branch. We call the distance between this two branches, the length of the line, $d_n$, which folloes $d_n = c_1 \alpha^{-n}$ for $n \rightarrow \infty$. $c_1$ and $\alpha$ are constant and $\alpha$ is universal: 

$$ \alpha = \lim_{n \rightarrow \infty} \frac{d_n}{d_{n+1}} $$

![alt text][logo3]

[logo3]:https://github.com/Olinty-3/Physics-simulations-/blob/main/1%20-%20Logistic%20function/Figure_3.png

$\alpha_1 = 2.6587$ and $\alpha_2 = 2.5570$

This are called Feigenbaum numbers. 
