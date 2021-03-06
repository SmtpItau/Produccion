USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Corresponsales_Eliminar]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[Sp_Corresponsales_Eliminar] (@rutcliente NUMERIC(9),
					   @codigocliente NUMERIC(9))
				           
AS 
BEGIN
SET NOCOUNT ON
SET DATEFORMAT dmy

     DELETE CORRESPONSAL WHERE rut_cliente = @rutcliente AND codigo_cliente = @codigocliente  

       IF @@ERROR <> 0 
          BEGIN
          SELECT "ERROR"
       END ELSE
          BEGIN
          SELECT "OK"
       END 
 
   SET NOCOUNT Off
  
END



GO
