USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABAHISTORICORIESGO]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_GRABAHISTORICORIESGO]
   (   @RutCliente	NUMERIC(9)
   ,   @Codigo	        INTEGER
   ,   @Fecha	        DATETIME
   ,   @Valor		CHAR(6)
   )
AS
BEGIN

   SET NOCOUNT ON

   DELETE FROM dbo.TBLCLASIFICARIESGO
         WHERE RutCliente = @RutCliente
           AND CodCliente = @Codigo
           AND Valor      = @Valor

   INSERT INTO dbo.TBLCLASIFICARIESGO
   (   RutCliente
   ,   CodCliente
   ,   Fecha
   ,   Valor
   ) 
   VALUES
   (   @RutCliente
   ,   @Codigo
   ,   @Fecha
   ,   @Valor
   )

   RETURN 0
END
GO
