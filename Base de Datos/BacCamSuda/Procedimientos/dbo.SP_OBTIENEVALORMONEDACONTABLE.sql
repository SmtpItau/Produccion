USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_OBTIENEVALORMONEDACONTABLE]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[SP_OBTIENEVALORMONEDACONTABLE]
		  ( @codigoMoneda	int = 994
		  )
as
begin

   declare @fechaAnt	datetime
   
	select @fechaAnt = acFecAnt	
	  from bacCamSuda..meac

	select tipo_Cambio
	  from BacParamSuda..VALOR_MONEDA_CONTABLE
	 where fecha = @fechaAnt
	   and codigo_moneda = @codigoMoneda

end

GO
