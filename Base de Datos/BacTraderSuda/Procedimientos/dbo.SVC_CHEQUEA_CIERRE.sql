USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_CHEQUEA_CIERRE]    Script Date: 16-05-2022 12:48:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SVC_CHEQUEA_CIERRE]
   (   @Fecha   DATETIME   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @iCierre   INTEGER

   SELECT  @iCierre   = 1
   SELECT  @iCierre   = -1
   FROM    OP_ENVIADAS_DCV 
   WHERE   Fecha = @Fecha AND Estado = 'P' 

   SELECT @iCierre , CASE WHEN @iCierre = 1  THEN 'No Existen Operaciones Pendientes de Envío'
                          WHEN @iCierre = -1 THEN 'Existen Operaciones Pendientes de Envío'
                     END

END



GO
