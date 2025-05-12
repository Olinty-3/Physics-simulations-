* Ecuación logistica

      program Eclog

      implicit none ! te obliga a definir todas las variables, si no defines una variable te da error, te evita errores de misspealing
         
      real*8 x , r , rn , d1 , d2 , rm , d3 , d4 , dm  , rmp, a1 , a2  
      integer n , j , k , m , a , kn , b , o , p , q , l , lm 
      parameter(n = 1000 , m = 4 , o = 5 , p=3 , q=7 )
      dimension x(n),r(5*n),rn(m),kn(m),rm(o),dm(p),d3(p),d4(q),rmp(p),
     &lm(o)


      x = 0 
      x(1) = 0.5 ! da igual el valor inicial que tomemos, x_final tenderá siempre al mismo número 
      
      
* Ejercicio 1

      do j = 1 , 5*n
         r(j) = dble(j)/dble(5*n) ! discretizo los valores de r en el rango de 0 a 1 
      end do 
      
      open(10,file='caos-diagrama-de-Feigerbrau-iam.txt')
      write(10,*) 'r' , ',' , 'x'
      
      do k = 1 , 5*n
         do j = 1 , n-1 
           
           x(j+1) =  4 * r(k) * x(j) * ( 1 - x(j) )
           
           if(j.gt.750) then 
              write(10,*) r(k) , ',' , x(j+1) ! Escribo solo los 751 últimos valores de x, esto es lo que trato como x_final 
           endif
           
           
         end do 
         
      end do 
      
      close(10)
      
      
      
* Ejercicio 3 

      a = 1 
      b = 1 
           
      do k = 1 , 5*n
      
         do j = 1 , n-1 
           x(j+1) =  4 * r(k) * x(j) * ( 1 - x(j) )
         end do 
        
         if(a.eq.16) then 
            exit
         end if 
        
        if(((x(n)-x(n-a))**2).lt.0.000001) then 
           cycle  ! reaunuda el bucle por donde estaba 
        else 
           rn(b) = r(k) 
           kn(b) = k ! Este valor no nos sirve de nada en este ejercicio pero nos servirá en el siguiente 
           a = 2*a
           b = b + 1 
        endif
        
      end do
      
      write(*,*) '# Ejercicio 3'
      
      write(*,*) 'rn =', rn

      d1 = (rn(2)- rn(1))/(rn(3) - rn(2))
      d2 = (rn(3)- rn(2))/(rn(4) - rn(3))
         
      write(*,*) 'd=', d1 , d2 
      
      
      
* Ejercicio 4 - Segundo número de Feigenbaum


      a = 1  ! reutilizamos la variable a 
      
* Sabemos que xf choca con el eje x = 0.5 antes de dividirse en dos ramas. Ese choque no nos da ningún valor de d por lo que no nos amporta información, para 
* ahorar trabajo podemos empezar el bucle a partir de la primera bifurcación. Además este punto ya lo hemos calculado en el ejercicio 3 
      
      do k = kn(1) , 5*n
      
         do j = 1 , n-1 
            x(j+1) =  4 * r(k) * x(j) * ( 1 - x(j) )
         end do 
        
         if(a.eq.6) then  ! solo quiero encontrar 3 valores de d, pero la discretización de r deja 'demasiado' lejos del eje x = 0.5 
*                           el tercer valor de d, para encontarlo hay que aumentar el rango donde damos por bueno xf = 0.5 lo que conlleba que
*                           otros valores pertenecientes a las ramas anteriores también entren en el vector donde estamos apuntando los valores de r   
            exit ! te saca del bucle 
         endif
        
         do l = 0 , 8 ! Hay que comprobar que no choca con ninguna rama 
        
           if(((x(n-l)-0.5)**2).lt.0.0000001) then 
              rm(a) = r(k)
              lm(a) = l ! guardamos la rama en la que choca por que esta será la que utilizaremos para calcular d 
              a = a + 1 
              exit
           endif
           
         end do 
        
      end do
      
      write(*,*) ! dejamos un espcio en blanco entre ejercicios 
      write(*,*) '# Ejercicio 4'
      
      write(*,*) 'rm =' , rm 
      write(*,*) 'lm=' , lm 
      
* Selecionamos los valores de rm que realmente coresponden a una rama 
* En este caso selecionare como 'valores reales' una media de los valores que seleciona el bucle 
  
      rmp(1) = (rm(1) + rm(2) + rm(3)) / 3  
      rmp(2) = rm(4) 
      rmp(3) = rm(5) 
      
      write(*,*) 'rmp =' , rmp 

      do k = 1 , p
          
         do j = 1 , n-1 
            x(j+1) =  4 * rmp(k) * x(j) * ( 1 - x(j) )
         end do
         
         if (k.eq.1) then 
            dm(k) = abs(x(n) - x(n-1)) ! La primera vez que se cruza con una bifurcación solo hay una rama, la distancia que haya será la distancia minima 
         endif 
         
         if (k.eq.2) then ! La segunda vez hay que comprobar tres ramas. Sabemos por el vector lm que corta en la tercera rama  
            
            d3(1) = abs(x(n-3) - x(n))
            d3(2) = abs(x(n-3) - x(n-1))
            d3(3) = abs(x(n-3) - x(n-2)) 
            
            dm(k) = min(d3(1),d3(2),d3(3))
         
         endif 
         
         if (k.eq.3) then ! La tercera vez hay que comprobar 7 ramas. Sabemos por el vector lm que corta en la setima rama 
            
            do l = 1 , 7
               d4(l) = abs(x(n-7) - x(n-l+1))
            end do 
            
            dm(k) = min(d4(1),d4(2),d4(3),d4(4),d4(5),d4(6),d4(7))
     
         endif
         
      end do 
      
      write(*,*)'dm =' , dm 

* Por ultimo calculamos el segundo número de Feigenbaum

      a1 = dm(1)/dm(2)
      a2 = dm(2)/dm(3)
      
      write(*,*) 'alpha =' , a1 , a2 

      
    
    
      end program Eclog 
