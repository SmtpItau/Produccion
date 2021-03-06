USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGA_VARIABLES]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CARGA_VARIABLES]
   (   @iTag      INTEGER   
   ,   @cSistema  CHAR(3)   = ''
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @dFechaProceso   DATETIME
       SET @dFechaProceso   = (SELECT acfecproc FROM BacTraderSuda..MDAC with (nolock) )

   IF @iTag = 1
   BEGIN
      SELECT id_sistema, nombre_sistema 
        FROM BacParamSuda..SISTEMA_CNT with (nolock)
       WHERE operativo = 'S' AND gestion = 'N' ORDER BY nombre_sistema
      RETURN
   END

   IF @iTag = 2
   BEGIN
      SELECT DISTINCT id_sistema, codigo_producto, descripcion FROM BacParamSuda..PRODUCTO with (nolock)
                WHERE (id_Sistema = @cSistema OR @cSistema = '' ) 
             ORDER BY id_sistema, codigo_producto
      --> SELECT DISTINCT id_Sistema, Producto_LBTR, Descripcion FROM BacParamSuda..PRODUCTO_LBTR WHERE (id_Sistema = @cSistema OR @cSistema = '' ) ORDER BY id_Sistema, Producto_LBTR
      RETURN
   END

   IF @iTag = 3
   BEGIN
      SELECT mncodmon , mnglosa 
        INTO #TMP_MON
        FROM BacParamSuda..MONEDA with (nolock)
       WHERE mncodmon IN(999,13)

      INSERT INTO #TMP_MON
      SELECT DISTINCT moneda , mnglosa 
                 FROM MDLBTR with (nolock)
                      INNER JOIN BacParamSuda..MONEDA with (nolock) ON mncodmon = moneda
                WHERE fecha = @dFechaProceso AND moneda NOT IN(999,13)
                ORDER BY mnglosa

      SELECT * FROM #TMP_MON
      RETURN
   END

   IF @iTag = 4
   BEGIN
      SELECT DISTINCT forma_pago, glosa 
                 FROM MDLBTR with (nolock)
                      INNER JOIN BacParamSuda..FORMA_DE_PAGO with (nolock) ON codigo = forma_pago 
                WHERE fecha  = @dFechaProceso 
             ORDER BY glosa
      RETURN
   END

END
GO
