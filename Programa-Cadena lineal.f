* Cadena lineal 

      include 'subrutina_aceleracion.f'
      include 'srandom.f'
      include 'dfour1.f'
      
      program cadena
      
      implicit none 
      integer seed , n , j , k , t , b , d  , l , sgn 
      parameter (n=8, l = 2**12 ) ! n -> numero de masas  l -> numero de iteraciones que guardo, tiene que ser potencia de dos para poder utilizar el programa de fourier 
      real(kind=8) m, x, c, v, dt, a, E, Ep  
      real(kind=8) xt1 ,  dat , wr , wi  , w, pi, dw, Ek, Eo
      real(kind=8) Fw
      dimension x(0:n+1) , v(n) , m(n) , a(n) ! definimos x de 0 a n+1 para tener en cuenta las paredes 
      dimension Ek(n+1), xt1(l), dat(2*l), wr(l), wi(l)
      dimension w(l) , Ep(n+1), Fw(l)
      
* Definimos los valores iniciales, c = 1, x y v se tomarán de manera aleatoria 
* Excepto el ultimo y el primer valor de x que coincide con la pared y por tanto son 0 ( definimos como 0 la posicion de equilibrio de la masa) 

      seed = 16747645
      call srandom(seed)
      
      call random_number(x)
      call random_number(v)
      
      if(n.eq.2) then
         m = 1 
      endif 
      
      if(n.eq.8) then ! defino las masas según mi DNI
         m(1) = 5
         m(2) = 9 
         m(3) = 8
         m(4) = 5
         m(5) = 7 
         m(6) = 7 
         m(7) = 8
         m(8) = 10 
      endif 
      
      c = 1 
      x(0) = 0 
      x(n+1) = 0
      
      if(n.eq.2) then 
         t = 10000  ! para el caso de dos masas no necesitamos tantas iteraciones y, de hecho, la gráfica de la energía se comprende mejor con menos 
      end if 
      
      if(n.eq.8) then 
         t = 300000
      end if
      
      dt = 0.01 ! definimos un paso lo suficientemente pequeño como para poder encontar todas las frecuencias.
                ! Además esto nos ayudará a la conservación de la energía.
                ! Aunque cuanto menor sea el paso más interaciones habrá que realizar ya que debemos estudiar un número significativo de oscilaciones 
      
      call aceleracion(x,a,n,c,m)
      
      do k = 1 , n 
         Ep(k) = 0.5 * m(k) * v(k)**2 
      end do 
            
      do k = 1 , n+1
         Ek(k) = 0.5 * c * (x(k) - x(k-1))**2
      end do 
      
      Eo = sum(Ep) + sum(Ek) 
 
      
* Ahora empezamos la iteración 

      b = 1
      d = 0 
      
      if(n.eq.2) then 
         open(10,file='cadena_dos_masas.txt')
         write(10,*) '# t , E ' 
      endif 
      
      if(n.eq.8) then 
         open(10,file='cadena_ocho_masas.txt')
         write(10,*) '# t , E , x(1) , x(3) , x(8) ' ! guardamos varias posiciones para ver distintas oscilaciones 
      endif 
      
      do j = 1 , t 
         
         do k = 1 , n
            v(k) = v(k) + 0.5 * a(k) * dt ! calculo v en j + 1/2
            x(k) = x(k) + v(k) * dt  ! calculo x en j + 1 
            call aceleracion(x,a,n,c,m) ! calculo a en j + 1 
            v(k) = v(k)+ a(k) * dt * 0.5 ! calculo v en j + 1 
         end do
         
         if(j.eq.b) then  ! guardo los valores de x cada 10 iteraciones 
         
            b = b + 10
            d = d + 1 
            
            do k = 1 , n 
               Ek(k) = 0.5 * m(k) * v(k)**2 
            end do 
            
            do k = 1 , n+1
               Ep(k) = 0.5 * c * (x(k) - x(k-1))**2
            end do 
            
            E = sum(Ep) + sum(Ek)
            
            E = (E - Eo) / Eo
            
            if(n.eq.2) then 
               write(10,*) dt*j ,  ','  , E  ! apunto dt*j para tener los ejes en fncion del tiempo real 
            endif
            
            if(n.eq.8) then 
               write(10,*)dt*j,',' , E, ',', x(1), ',' , x(3), ',', x(8) 
            endif
    
            xt1(d) = x(1) ! guardo en un vector los valores de la posición x(1) para realizar la transformada de fourier 
           
            
            if(d.eq.l) then ! me aseguro que las variables que van a pasar por la transformada de Fourier tengan el numero de valores igual a una potencia de 2 
               exit
            endif
            
         endif 
         
      end do 
      
      close(10) 
 
      
* Buscar las frecuencias fundamentales 

* preparo los datos generados para poder suministrarselos a la subrutina four1.f

      do j=1,l
         dat(2*j-1)=xt1(j) ! parte real
         dat(2*j)=0        ! parte imaginaria
      end do
      
      sgn = 1 ! si 1 TF directa , si -1 TF invrersa
      
      call dfour1(dat,l,sgn)
      
* Esta subrutina me da los datos en frecuencias (Hz), pero me interesa representarlos en fracuencias angulares (rad) 
      
      pi = 4.d0 * datan(1.d0)

      dw = 2 * pi / (dt * 10 * dble(l)) ! esto además representa la diferencia minima entre dos frecuencias que debe haber para que sean distingibles por la TF
      

* tengo que dividir entre el numero de datos por la distancia entre los mismos. dt no es la distancia entre los datos, es la distancia entre 
* valores integrados, pero como guardo cada 10 valores integrados tengo que dividir entre dt * 10
      
      do j = 1 , l
      
         wr(j)=dat(2*j-1) !parte real
         wi(j)=dat(2*j)   !parte imaginaria
         
         if(j<=l/2) then
            w(j) = dw * dble(j-1)
         else
            w(j) = dw * dble(j-l-1)
         endif
         
      end do
      
      Fw = wr**2 + wi**2 ! queremos representar la amplitud de frecuencias 
      
      if(n.eq.8) then 
         open(10, file='TF_cadena_ocho_masas.txt')
      endif 
      
      write(10,*) '# |Fw|**2 , w' 
      
      do j = 1 , l 
         write(10,*) Fw(j) , ',' ,  w(j)
      end do 
      
      close(10)
    
      end program cadena

      
