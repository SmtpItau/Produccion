USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Actualiza_MDPV]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROC [dbo].[Sp_Actualiza_MDPV]   
				(
					@codigo NUMERIC(03,00) ,
      					@porcentaje NUMERIC(19,04) 
				)


 AS

 BEGIN

 SET NOCOUNT ON
 SET DATEFORMAT dmy

 	BEGIN TRANSACTION

        	UPDATE  PORCENTAJE_VARIACION
		SET  	pvporcentaje = @porcentaje
		FROM  	PORCENTAJE_VARIACION
		WHERE  	pvcodigo = @codigo

 	IF @@ERROR <> 0 

	BEGIN

     		 ROLLBACK TRANSACTION 

	END 

		 COMMIT TRANSACTION

 SET NOCOUNT OFF

END






GO
