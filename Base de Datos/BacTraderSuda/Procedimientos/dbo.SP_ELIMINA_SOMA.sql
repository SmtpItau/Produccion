USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ELIMINA_SOMA]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_ELIMINA_SOMA](
	 @Fecha      	 	datetime
	,@Numero_Operacion 	numeric(10,0)
        )
AS 
BEGIN
	delete from  CARGASOMA 
	where Fecha_Proceso = @Fecha
	and   Numoper       = @Numero_Operacion 	


END

GO
