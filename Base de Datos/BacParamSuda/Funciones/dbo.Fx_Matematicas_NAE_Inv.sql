USE [BacParamSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[Fx_Matematicas_NAE_Inv]    Script Date: 13-05-2022 10:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Function [dbo].[Fx_Matematicas_NAE_Inv]
 ( 
     @p  float			 
 ) 
 Returns float
 As 
 Begin
    -- Funcion que calcula la distribución normal estándar acumulada inversa
	/*
	'  Adapted for Microsoft Visual Basic from Peter Acklam's
    '  "An algorithm for computing the inverse normal cumulative distribution function"
    '  (http://home.online.no/~pjacklam/notes/invnorm/)
    '  by John Herrero (3-Jan-03)
	 */
    declare @NAE_Inv float

    -- Define coefficients in rational approximations
    declare @a1 float = -39.6968302866538
    declare @a2 float = 220.946098424521
    declare @a3 float = -275.928510446969
    declare @a4 float = 138.357751867269
    declare @a5 float = -30.6647980661472
    declare @a6 float = 2.50662827745924

    declare @b1 float = -54.4760987982241
    declare @b2 float = 161.585836858041
    declare @b3 float = -155.698979859887
    declare @b4 float = 66.8013118877197
    declare @b5 float = -13.2806815528857

    declare @c1 float = -7.78489400243029E-03
    declare @c2 float = -0.322396458041136
    declare @c3 float = -2.40075827716184
    declare @c4 float = -2.54973253934373
    declare @c5 float = 4.37466414146497
    declare @c6 float = 2.93816398269878

    declare @d1 float = 7.78469570904146E-03
    declare @d2 float = 0.32246712907004
    declare @d3 float = 2.445134137143
    declare @d4 float = 3.75440866190742

    -- Define break-points
    declare  @p_low float = 0.02425
    declare  @p_high float = 1.0 - @p_low

	declare  @q float
	declare  @r float
   
    select @NAE_Inv = 0

    if @p < @p_low
	begin
	   -- Rational approximation for lower region
	   select @q = power( -2 * log( @p) , 0.5 )
	   select @NAE_Inv = (((((@c1 * @q + @c2) * @q + @c3) * @q + @c4) * @q + @c5) * @q + @c6) / 
        ((((@d1 * @q + @d2) * @q + @d3) * @q + @d4) * @q + 1)
	end
	else
	begin
	   -- Rational approximation for lower region
	   if @p <= @p_high
	   begin
	      select @q = @p - 0.5
          select @r = @q * @q
          select @NAE_Inv = (((((@a1 * @r + @a2) * @r + @a3) * @r + @a4) * @r + @a5) * @r + @a6) * @q / 
                  (((((@b1 * @r + @b2) * @r + @b3) * @r + @b4) * @r + @b5) * @r + 1)
	   end 
	   else
	   begin
	       -- Rational approximation for upper region 
	       if @p < 1.0 
		   begin
              select @q = power(-2 * Log(1 - @p), 0.5)
              select @NAE_Inv = -(((((@c1 * @q + @c2) * @q + @c3) * @q + @c4) * @q + @c5) * @q + @c6) / 
                               ((((@d1 * @q + @d2) * @q + @d3) * @q + @d4) * @q + 1)		   
		   end 
	   end	       
    end
	return( @NAE_Inv )
End 
-- select dbo.Fx_Matematicas_NAE_Inv( 0.9679 )
GO
