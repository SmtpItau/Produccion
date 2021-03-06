USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MNT_CURVAS_PRODUCTO]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_MNT_CURVAS_PRODUCTO]
   (   @iAccion        INTEGER
   ,   @CodigoCurva    VARCHAR(20)   = ''
   ,   @Modulo         CHAR(3)       = ''
   ,   @Producto       VARCHAR(5)    = ''
   ,   @Moneda         INTEGER       = 0
   ,   @Instrumento    VARCHAR(20)   = ''
   ,   @Emisor         VARCHAR(10)   = ''
   ,   @CurAlter       VARCHAR(20)   = ''
   ,   @Spread         CHAR(1)       = ''
   ,   @CurSpread      VARCHAR(20)   = ''
   ,   @TasaDesde      FLOAT         = 0.0
   ,   @TasaHasta      FLOAT         = 0.0
   ,   @TipoTasa       CHAR(1)       = 'N'
   ,   @TipoBase       INTEGER       = 0
   ,   @iIndicador     INTEGER       = -1
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @iFound     INTEGER

   IF @iAccion = 1   --> Consulta
   BEGIN
      SELECT /*01*/ CodigoCurva  = CodigoCurva
      ,      /*02*/ Modulo       = LTRIM(RTRIM(s.nombre_sistema)) + REPLICATE(' ' , 100 - LEN(LTRIM(RTRIM(s.nombre_sistema)))) + Modulo
      ,      /*03*/ Producto     = LTRIM(RTRIM(p.descripcion))    + REPLICATE(' ' , 100 - LEN(LTRIM(RTRIM(p.descripcion))))    + Producto
      ,      /*04*/ Moneda       = LTRIM(RTRIM(m.mnnemo))         + REPLICATE(' ' , 100 - LEN(LTRIM(RTRIM(m.mnnemo))))         + LTRIM(Moneda)
      ,      /*05*/ Instrumento  = CASE WHEN Modulo = 'BEX'  AND CodigoCurva = 'CURVA_COLTES' THEN
									'BONOEX'
									ELSE
										CASE WHEN Instrumento = '*' THEN '*' 										
											ELSE                        LTRIM(RTRIM(Instrumento)) + REPLICATE(' ' , 100 - LEN(LTRIM(RTRIM(Instrumento)))) + LTRIM(incodigo)
										END
									END
      ,      /*06*/ Emisor       = CASE WHEN Emisor      = '*' THEN '*'
                                        ELSE                        LTRIM(RTRIM(emnombre))    + REPLICATE(' ' , 100 - LEN(LTRIM(RTRIM(emnombre))))    + Emisor
                                   END
      ,      /*07*/ CurAlter     = CurAlter
      ,      /*08*/ Spread       = Spread
      ,      /*09*/ CurSpread    = CurSpread
      ,      /*10*/ RutEmisor    = ISNULL(i.inrutemi,0)
      ,      /*11*/ TasaDesde    = ISNULL(TasaDesde,0.0)
      ,      /*12*/ TasaHasta    = ISNULL(TasaHasta,0.0)
      ,      /*13*/ TipoTasa     = CASE WHEN TipoTasa = 'F' THEN 'FIJA'
                                        WHEN TipoTasa = 'V' THEN 'VARIABLE'
                                        ELSE                     ''
                                   END
      ,      /*14*/ TipoBase     = CASE WHEN TipoBase = 0 THEN ' '
                                        ELSE LTRIM(RTRIM(Glosa)) + REPLICATE(' ', 100 - LEN(LTRIM(RTRIM(Glosa)))) + LTRIM(Codigo)
                                   END
      ,      /*15*/ Indicador    = CASE WHEN Indicador = -1 THEN 'NO DEFINIDA' + SPACE(100) + '-1'
                                        ELSE                     (SELECT DISTINCT RTRIM(tbglosa) + SPACE(100) + RTRIM(tbcodigo1) FROM TABLA_GENERAL_DETALLE WHERE tbcateg = 1042 and Indicador = tbcodigo1)
                                   END
      FROM   CURVAS_PRODUCTO
             LEFT JOIN BacParamSuda..SISTEMA_CNT s ON s.id_sistema = Modulo
             LEFT JOIN BacParamSuda..PRODUCTO    p ON p.id_sistema = Modulo AND p.codigo_producto = Producto
             LEFT JOIN BacParamSuda..MONEDA      m ON m.mncodmon   = Moneda
             LEFT JOIN BacParamSuda..INSTRUMENTO i ON i.inserie    = Instrumento
             LEFT JOIN BacParamSuda..EMISOR      e ON e.emgeneric  = Emisor
             LEFT JOIN BacSwapSuda..BASE         b ON TipoBase     = b.Codigo
      WHERE  CodigoCurva = @CodigoCurva
   END

   IF @iAccion = 2   --> Eliminar
   BEGIN
      DELETE FROM CURVAS_PRODUCTO 
            WHERE CodigoCurva = @CodigoCurva
   END

   IF @iAccion = 3   --> Grabar
   BEGIN

      SET     @iFound     = 0
      SELECT  @iFound     = 1 
      FROM    CURVAS_PRODUCTO 
      WHERE   CodigoCurva = @CodigoCurva
      AND     Modulo      = @Modulo 
      AND     Producto    = @Producto 
      AND     Moneda      = @Moneda 
      AND     Instrumento = @Instrumento 
      AND     Emisor      = @Emisor
      AND     TasaDesde   = @TasaDesde
      AND     TasaHasta   = @TasaHasta
      AND     TipoTasa    = @TipoTasa
      AND     TipoBase    = @TipoBase
      AND     Indicador   = @iIndicador 

      IF @iFound = 0
      BEGIN
         INSERT INTO CURVAS_PRODUCTO
         SELECT @CodigoCurva
         ,      @Modulo
         ,      @Producto
         ,      @Moneda
         ,      @Instrumento
         ,      @Emisor
         ,      @CurAlter
         ,      @Spread
         ,      @CurSpread
         ,      @TasaDesde
         ,      @TasaHasta
         ,      @TipoTasa
         ,      @TipoBase
         ,      @iIndicador 
      END
   END

END
GO
