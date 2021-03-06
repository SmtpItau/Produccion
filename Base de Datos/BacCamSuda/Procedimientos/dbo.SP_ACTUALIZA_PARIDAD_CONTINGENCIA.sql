USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACTUALIZA_PARIDAD_CONTINGENCIA]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ACTUALIZA_PARIDAD_CONTINGENCIA](  @fecha  char(8),
															@desde numeric(10,4),
															@hasta numeric(10,4),
															@valor numeric(10,4),
														    @valor1 numeric(10,4),
															@desde1 numeric(10,4),
															@hasta1 numeric(10,4),
															@valor2 numeric(10,4),
															@valor3 numeric(10,4)
														 ) 
as 
BEGIN

--************************************************************************/
--procedimiento que actualiza valores									 */
--creado:08-07-2011														 */	
--************************************************************************/

       Begin
		   update COSTOS_COMEX set Costo_Compra = @valor, Costo_Venta = @valor1
		   where  CodMoneda = 13
		   and	  fecha = @fecha	
		   and 	  perfil_comercial = 2
		 
		   and   entre_desde = @desde
		   and   entre_hasta = @hasta
        END 
        Begin
		   update COSTOS_COMEX set Costo_Compra = @valor2, Costo_Venta = @valor3
		   where  CodMoneda = 13
		   and	  fecha = @fecha	
		   and 	  perfil_comercial = 2
		   and   entre_desde = @desde1
		   and   entre_hasta = @hasta1
        END 
	
END
GO
