USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACTUALIZA_MDPV]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SP_ACTUALIZA_MDPV]   
    (
     @codigo NUMERIC(03,00) ,
           @porcentaje NUMERIC(19,04) 
    )
 AS
 BEGIN
 SET NOCOUNT ON
  BEGIN TRANSACTION
         UPDATE  PORCENTAJE_VARIACION
  SET   pvporcentaje = @porcentaje
  FROM   PORCENTAJE_VARIACION
  WHERE   pvcodigo = @codigo
  IF @@ERROR <> 0 
 BEGIN
        ROLLBACK TRANSACTION 
 END 
   COMMIT TRANSACTION
 SET NOCOUNT OFF
END
GO
