USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACTUALIZA_TEMPPARIDAD]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ACTUALIZA_TEMPPARIDAD]( @codmon numeric(3)=0,
										          @opcion char(1),
												  @fecha  char(8)	
                                          ) 
as 
begin

--************************************************************************/
--procedimiento que calcula paridad de trasnferencia, formulario Empresa */
--creado:01-06-2011														 */	
--************************************************************************/
declare @calc numeric (6,4)
declare @sw int  
set nocount on 
/***Calcula paridad cuando es compra***********************************/  
	set @opcion ='C'
 if @codmon <> 13
  begin  
	if @opcion ='C'
    begin

		select @calc=Costo_Compra from Costos_Comex where CodMoneda = @codmon	and fecha = @fecha	

		if  @calc < 1.50000
	    begin	
			set @calc = @calc + 0.0001

			update  COSTOS_COMEX set Costo_Compra = @calc where CodMoneda = @codmon	and fecha = @fecha	
			
			select	Costo_Compra
			from	Costos_comex 
			where	CodMoneda = @codmon
			and fecha = @fecha

			if @calc > 1.5000
				update  costos_comex
					set Costo_compra = case when @codmon = 142 then 1.4000 
										 when @codmon = 72  then 81.0000 
									end
				  where CodMoneda = @codmon
                  and fecha = @fecha 
           	end
	end 
/**************************************************************************************/
          if  @calc < 82.0000
	    begin	
			set @calc = @calc + 0.0001

			update  COSTOS_COMEX set Costo_Compra = @calc where CodMoneda = @codmon	and fecha = @fecha	
			
			select	Costo_Compra
			from	Costos_comex 
			where	CodMoneda = @codmon
			and fecha = @fecha

			if @calc > 82.0000
				update  costos_comex
					set Costo_compra = case when @codmon = 142 then 1.4000 
										 when @codmon = 72  then 81.0000 
									end
				  where CodMoneda = @codmon
                  and fecha = @fecha 
			end
 end
END

GO
