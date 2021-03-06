USE [BacBonosExtSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[Fx_PVP_COLTES]    Script Date: 11-05-2022 16:40:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Fx_PVP_COLTES] (   -- para asociar a la variable @MT
    @tipo_cal    	numeric(1) , -- 1: Precio 2: Pago 3: Mto a Pagar
	@Cod_Familia	numeric(10),
	@cod_nemo	    CHAR(20),
    @TR				numeric(20,8),    -- TIR
	@FP				datetime,         -- Fecha valorizacion
	@NOM			numeric(20,2),    -- Nominal
	@PVP			numeric(20,6),    -- PVP
	@MT				numeric(20,2),    -- Valor Presente
	@FV				datetime,		  -- Fecha Vencimiento   
	@FE             datetime,         -- Fecha Emision 
	@UsaCurva       char(1) = 'N'     -- 'S' => Usa curva en vez de tasa
)
RETURNS numeric(20,10)                --- Seis decimales para el precio.
                                      --- Ver cómo parametrizamos esto.
-- WITH SCHEMABINDING
AS
	
BEGIN
        DECLARE @Retorno			NUMERIC(20,10) 
		DECLARE @flujo				NUMERIC(20,6)
		DECLARE @MtoDevengado		NUMERIC(20,6)
		DECLARE @fechaUltimoPago	DATETIME = @FE
		DECLARE @CodigoCurva		VARCHAR(20) = 'CURVA_COLTES'
		DECLARE @MonedaEmi			NUMERIC(5)

		SELECT @MonedaEmi =  isnull( ( select max(monemi) from TEXT_SER where cod_familia = @cod_familia AND cod_nemo    = @cod_nemo ), 13 )
		SELECT  @CodigoCurva = codigoCurva from bacparamsuda.dbo.CURVAS_PRODUCTO CP
		WHERE  moneda = @MonedaEmi
			and   CurAlter = codigoCurva
			and   Modulo = 'BEX'

		SELECT  @fechaUltimoPago =  max( fecha_vcto_cupon ) from BacBonosExtSuda.dbo.TEXT_dsa
		                          WHERE cod_familia = @cod_familia  
								 AND cod_nemo    = @cod_nemo 
			                     and fecha_vcto_Cupon < @FP  
		SELECT @fechaUltimoPago = isnull( @fechaUltimoPago, @FE ) 

		SELECT @flujo = interes from BacBonosExtSuda.dbo.TEXT_dsa
		                          WHERE cod_familia = @cod_familia  
								 AND cod_nemo    = @cod_nemo 
								 AND fecha_vcto_cupon = @fechaUltimoPago

		SELECT @flujo = isnull( @flujo, ( select top 1 interes from BacBonosExtSuda.dbo.TEXT_dsa
		                                    WHERE cod_familia = @cod_familia  
								            AND cod_nemo    = @cod_nemo
											and num_cupon = 1 ) ) 

		SELECT @MtoDevengado = @flujo * ( datediff( dd, @fechaUltimoPago,  @FP ) - dbo.Fx_BisiestosAcumulados(@fechaUltimoPago, @FP) )
		                              / 365

		SELECT @Retorno = (SELECT sum( F.flujo / round( power( 1.0 + CV.ValorAsk/100.0 , ( datediff( dd, @FP, fecha_vcto_cupon ) - dbo.Fx_BisiestosAcumulados(@FP, fecha_vcto_cupon) )
		                                                                  / dbo.Fx_BaseActualModAnual( @fechaUltimoPago, @FP ) ), 4) )  
																		  
							FROM BacBonosExtSuda.dbo.TEXT_dsa  F
		                                      left join BacParamSuda.dbo.Curvas CV 
			                         	   On CV.CodigoCurva = @CodigoCurva and CV.FechaGeneracion = @FP
				                             and CV.Dias = ( datediff( dd, @FP, fecha_vcto_cupon ) - dbo.Fx_BisiestosAcumulados(@FP, fecha_vcto_cupon) ) 
							WHERE cod_familia = @cod_familia  
								AND cod_nemo    = @cod_nemo  
								AND f.fecha_vcto_cupon > @FP 
		                     ) 
       declare @Retornar float
	   if @UsaCurva = 'S'
	   BEGIN
	   
				----+++jcamposd COLTES debe dejar fuera el vencimiento de cupon
				DECLARE @fechaProxProceso DATETIME
				
				SELECT @fechaProxProceso = acfecprox FROM bactradersuda.dbo.mdac
				
				IF  EXISTS (SELECT 1 FROM BacBonosExtSuda.dbo.TEXT_dsa  
										WHERE cod_familia = @cod_familia    
												AND cod_nemo    = @cod_nemo   
												AND fecha_vcto_Cupon >= @FP and fecha_vcto_Cupon < @fechaProxProceso) 
				BEGIN 
					SELECT @MtoDevengado = 0
				END 
				-------jcamposd COLTES debe dejar fuera el vencimiento de cupon                    	   
	      
	      select @Retornar = round(@Retorno +  - @MtoDevengado  , 6)
	   END
	   else
	   Begin
	      -- Activar el cálculo usando
		  -- fórmula corta
		  -- que ha cuadrado la mayoria de las veces.
		  declare @C  float = ( select top 1 interes from BacBonosExtSuda.dbo.TEXT_dsa
		                                    WHERE cod_familia = @cod_familia  
								            AND cod_nemo    = @cod_nemo
											and num_cupon = 1 ) 
          declare @F float = 100.0
		  declare @y Float = @TR
		  declare @n numeric(5) =   (select max(num_cupon)  from BacBonosExtSuda.dbo.TEXT_dsa WHERE cod_familia = @cod_familia  
								            AND cod_nemo    = @cod_nemo
								     )
		                          - (select min(num_cupon)  from BacBonosExtSuda.dbo.TEXT_dsa WHERE cod_familia = @cod_familia  
								            AND cod_nemo    = @cod_nemo
											and fecha_vcto_cupon > @FP ) + 1
		  declare @proximoPago datetime = (select min(fecha_vcto_cupon)  from BacBonosExtSuda.dbo.TEXT_dsa WHERE cod_familia = @cod_familia  
								            AND cod_nemo    = @cod_nemo
											and fecha_vcto_cupon > @FP )
		  declare @PagoAnterior datetime  = isnull( (select max(fecha_vcto_cupon)  from BacBonosExtSuda.dbo.TEXT_dsa WHERE cod_familia = @cod_familia  
								            AND cod_nemo    = @cod_nemo
											and fecha_vcto_cupon <= @FP ), @FE )

		  declare @v float  = dbo.fx_Trunc( ( datediff( dd, @FP, @proximoPago ) - dbo.Fx_BisiestosAcumulados( @PagoAnterior, @proximoPago ) ) / 365.0 , 5 )
		  declare @CalculoA float = @C / ( @y / 100.0 )
		  declare @CalculoB float = ( @F - @C / ( @y / 100.0 ) ) / power( 1.0 + @y / 100.0, @n - 1 ) -- (F-C/Yp)/(1+Yp)^(n-1)
		  declare @CalculoC float = round(  dbo.fx_trunc( @C +  @CalculoA + @CalculoB , 3 ) / power( 1.0 + @y/100.0 , @v ) , 3)
		  select  @MtoDevengado = round( @C * ( 1 - @v) , 3 ) 
		  select  @Retornar =  @CalculoC - @MtoDevengado
	   End 
	   return( @Retornar )	 --retorna precio limpio			 
END
GO
