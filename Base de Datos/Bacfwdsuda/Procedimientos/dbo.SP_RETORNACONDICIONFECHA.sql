USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RETORNACONDICIONFECHA]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



--     SP_RetornaCondicionFecha '1' , 'c'
CREATE PROCEDURE [dbo].[SP_RETORNACONDICIONFECHA]
   (   @iProducto   VARCHAR(5)
   ,   @iTipoPago   CHAR(1)
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @Signo   CHAR(1)
   ,       @Dias    NUMERIC(9)

   SELECT  @Signo   = ''
   ,       @Dias    = 0

   SELECT  @Signo   = isnull(Signo,'+')
   ,       @Dias    = isnull(DiasValor,0)
   FROM    FECHA_EFECTIVA
   WHERE   Producto  = @iProducto
   AND     Modalidad = @iTipoPago

   SELECT  @Signo
   ,       @Dias

END
GO
