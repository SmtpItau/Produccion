USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_TRANSFERPARIDAD]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[SP_LEER_TRANSFERPARIDAD](@fecha char(8),
                                          @perfil char(6),
										  @codmon numeric(3)=0,
										  @opcion  char(1)
                                          ) 
as 
begin
--**********************************************************************/
--procedimiento que calcula paridad de trasnferencia, arbitraje 	   */
--creado:01-06-2011													   */	
--**********************************************************************/
set nocount on 
/***Calcula paridad cuando es compra***********************************/  
if @opcion ='C'
  begin
	   select 
	   Costo_Compra - Spread_Compra - Spread_Trading_Compra as 'Paridad Transferencia',
       montomax
	   from  COSTOS_COMEX
	   where fecha = @fecha
	   and  perfil_comercial = @perfil
	   and Codmoneda = @codmon
	   --and  @codmon <> 13
  end 
/***Calcula paridad cuando es venta************************************/
if @opcion ='V'  
  begin 
      select Costo_Compra + Spread_Compra + Spread_Trading_Compra as 'Paridad Transferencia',
      montomax
       from COSTOS_COMEX
	   where fecha = @fecha
	   and  perfil_comercial = @perfil
	   and Codmoneda = @codmon
     --  and  @codmon <> 13	
  end
End

GO
