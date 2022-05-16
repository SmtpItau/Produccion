USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ANULA_PAPELETAFLI]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_ANULA_PAPELETAFLI](
	 @Fecha_Operacion 	datetime
	,@Numero_Operacion 	numeric(10,0)
)

AS 
BEGIN

	delete from  papeleta_Fli 
	 where Fecha_Operacion 	= @Fecha_Operacion 	
	and Numero_Operacion 	=@Numero_Operacion 	


	delete from  Resumen_Operaciones_Fli
	 where Fecha_Operacion 	= @Fecha_Operacion 	
	and Numero_Operacion 	=@Numero_Operacion 	


END


GO
