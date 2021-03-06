USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACTUALIZA_TEMPARIDAD]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ACTUALIZA_TEMPARIDAD]( @codmon numeric(3)=0,
										          @opcion char(1),
												  @fecha  char(8)	
                                          ) 
as 
begin

--************************************************************************/
--procedimiento que calcula paridad de trasnferencia, formulario Empresa */
--creado:01-06-2011														 */	
--************************************************************************/

if @opcion ='C'
Begin 

	select costo_compra  
    from   costos_comex
    where  codmoneda=@codmon
    and    fecha = @fecha
end
       
if @opcion ='V'
Begin 

	select costo_venta
    from   costos_comex
    where  codmoneda=@codmon
    and    fecha = @fecha
end

END
GO
