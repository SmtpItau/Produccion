USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RETORNATIPOORIGEN_BFW]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_RETORNATIPOORIGEN_BFW]
   (   @Modulo          CHAR(3)
   ,   @Producto        VARCHAR(5)
   ,   @Moneda          INT
   ,   @Plazo           NUMERIC(9)
   ,   @TipoOperacion   CHAR(1)
   ,   @FechaProceso    DATETIME
   ,   @OrigenCurva     CHAR(2)      OUTPUT
   )
AS
BEGIN

   SET NOCOUNT ON

   SET @OrigenCurva = 'MC'

   DECLARE @CodigoCurva     VARCHAR(20)

   SELECT  @CodigoCurva     = CodigoCurva
   FROM    BacParamSuda..CURVAS_PRODUCTO  --(INDEX = CurvaProducto_Llave)
   WHERE   Modulo           = @Modulo
   AND     Producto         = @Producto
   AND     Moneda           = @Moneda

   SELECT  @OrigenCurva      = Origen
     FROM  BacParamSuda..CURVAS
    WHERE  FechaGeneracion   = @FechaProceso
     AND   CodigoCurva       = @CodigoCurva
     AND   Dias              = @Plazo

END

GO
