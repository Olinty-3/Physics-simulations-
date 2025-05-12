* Subrutina para calcular la acelaeración 


      subroutine aceleracion(x,a,n,c,m) 
      
      implicit none
      integer n , j 
      real(kind=8), intent(in):: x(0:n+1) , m(n) ! in -> variable de entrada 
*                                                  out -> variable de salida 
*                                                  inout -> ambas
      real(kind=8) , intent(out):: a(n) 
      real*8   c  
      

      do j = 1 , n 
         a(j)=(c * (x(j-1) - x(j)) + c * (x(j+1) - x(j)))/m(j)
      end do 
      
      end subroutine aceleracion 
      
      
