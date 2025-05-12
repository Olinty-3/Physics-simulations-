# Lineal chain 

We are going to study the dinamical evolution of a chain of mases join by springs. We are assuming interaction only to first neighbors. Althoug this system can be solved analiticaly it would be a great example to show Swope's algorithm and how to compute the frecuencies of vibration of a system. 

The problem reduces to solving the differential equation: 

$$ m_i \frac{d^2x_i}{dt^2} = c_{i-1} (x_{i-1} - x_i) + c_i (x_i + x_{i+1}) $$

where $x_i$ are the displacement of the i-esim mass with respect to their equilibrium position and c_i are the springs constants.  

To exemplify this we are going to use a sistem of 8 mases $m = [5 , 9 , 8 , 5 , 7 , 7 , 8 , 10]$ and $c_i = 1$ $\forall i$ 

To start Swope's algorithm we need to compute the positions in the second instant using the positions, velocities and acelerations from the first instant: 

$$ x_{1} = x_0 + v_0 \Delta t + \frac{1}{2} a_0 \Delta t^2 $$

Then we obtain the aceleration in the second instant using the differential equation above. Next we compute the velocity in a "half-interval" after using: 

$$ v_{j+1/2} = v_j + \frac{1}{2} a_j \Delta t $$ 

And with this we know the position in the next time interval 

$$ x_{j+1} = x_j + v_{j+1/2} \Delta t $$

The new velocity is computed now an interval after the one we alredy have that would be half-interval after the position and acelaration: 

$$ v_{j+1} = v_j + \frac{a_j + a_{j+1}}{2} \Delta t $$

The initial positions, velocities, and acelerations are taken randomly to ensure all vibrational modes are excited. Its important that $\Delta t$ is small enough so that we can apreciate all the oscilation subtleties and that the total time is big enough so that we can study a significant amount of oscilations. Another important aspect of the simulation is keeping a power of 2 number of data, since for the subrutine that findes the modes of oscillation to work we need this number of data. 

A key point in any algorithm is that they conserve the physical magnitudes that should be conserved, like total energy of the system:  

![alt text][logo]

[logo]:https://github.com/Olinty-3/Physics-simulations-/blob/main/2%20-%20Lineal%20chain/Figure%202.png


As we can see in the left graph the energy is not "actually" conserved during the iteration but it oscilates around zero. This is a unavoidable feature of the computational process. Moreover if we pay attention to the orders of magnitude of the oscilations $10^{-6}$ we'll see that they are not significant. What we are looking for in this graphs is that the absolute magnitude of the energy doesn't grow with time, which can be seen in the second graph.

Now that we have a hint that our algorithm works we can plot the evolution with time of some of our positions: 

![alt text][logo2]

[logo2]:https://github.com/Olinty-3/Physics-simulations-/blob/main/2%20-%20Lineal%20chain/Figure%203.png

This also works for showing that we have taken a suficiently large time. 

Now, for the second part of the exercise we want to compute the frequency modes of the system, to do so we use the numerical recepies subrutine 'dfour1.f' that has the disadvantage that you need a power of two number of data. Another inconvinient is that you have to order the data alternating real and imaginary. In our case the imaginary values would be zero. 

The subroutine gives you back the frequency, again alternating real and imaginary values, we reorder them to compute the module, which is the property we are interested in. Moreover we have to be careful and transform our interval from time to frequency. 

![alt text][logo3]

[logo3]:https://github.com/Olinty-3/Physics-simulations-/blob/main/2%20-%20Lineal%20chain/Figure%204.png

Our objective is to detect the fundamental modes of the system, 8. In the left graph we can only see 5 since the others haven been excited enough. To see them we take logarithms in the rigth graph were all the vibration modes are visible: 

![alt text][logo4]

[logo4]:https://github.com/Olinty-3/Physics-simulations-/blob/main/2%20-%20Lineal%20chain/Figure%205.png

