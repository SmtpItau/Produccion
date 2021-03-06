USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_CAMBIOFLAGACTIVOTRASP]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CAMBIOFLAGACTIVOTRASP]
                 (
                   @numerooperacion NUMERIC(10)
                 )
AS
BEGIN
 SET NOCOUNT ON

 SELECT numerooperacion
   FROM LINEA_TRASPASO
  WHERE numerooperacion = @numerooperacion 

   BEGIN
       UPDATE LINEA_TRASPASO
          SET activo ='N'
        WHERE numerooperacion = @numerooperacion 
 
 IF @@ERROR<>0
   BEGIN
     SELECT 'ERROR'
 END ELSE
   BEGIN
     SELECT 'MODIFICA'
 END
   SET NOCOUNT OFF 
END

END
GO
