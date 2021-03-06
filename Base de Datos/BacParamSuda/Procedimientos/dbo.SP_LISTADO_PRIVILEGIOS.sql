USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTADO_PRIVILEGIOS]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LISTADO_PRIVILEGIOS]
   (   @xEmisor   CHAR(15)
   ,   @Usuario   CHAR(15)
   ,   @TipoInf   CHAR(1)
   ,   @Modulo    CHAR(3)   = ''
   )
AS
BEGIN 

   SET NOCOUNT ON

   DECLARE @dFechaProceso    CHAR(10)
       SET @dFechaProceso    = (SELECT CONVERT(CHAR(10), acfecproc, 103) FROM BacTraderSuda..MDAC with(nolock) )

   DECLARE @dFechaEmision    CHAR(10)
       SET @dFechaEmision    = CONVERT(CHAR(10), GETDATE(), 103)

   DECLARE @cHoraEmision     CHAR(10)
       SET @cHoraEmision     = CONVERT(CHAR(10), GETDATE(), 108)

   DECLARE @Nombre           VARCHAR(50)
   DECLARE @Tipo             VARCHAR(50)

   IF @TipoInf = 'U'
      SELECT @Nombre            = LTRIM(RTRIM( us.nombre )) --> LTRIM(RTRIM( SUBSTRING( us.nombre, 1, CHARINDEX('-', us.nombre, 1) - 1 )))
      ,      @Tipo              = LTRIM(RTRIM( us.tipo_usuario ))  
      ,      @Tipo              = LTRIM(RTRIM( SUBSTRING(us.tipo_usuario,1,25) )) -- LTRIM(RTRIM( CONVERT(CHAR(25), SUBSTRING(us.tipo_usuario,1,25) ))) 
                                + ' - ' 
                                + LTRIM(RTRIM( SUBSTRING(gt.Descripcion, 1,25) )) -- LTRIM(RTRIM( CONVERT(CHAR(25), SUBSTRING(gt.Descripcion,1,25)  ))) 
      FROM   BacParamSuda..USUARIO                     us with(nolock)
             LEFT JOIN BacParamSuda..GEN_TIPOS_USUARIO gt with(nolock) ON gt.Tipo_Usuario = us.tipo_usuario
      WHERE  usuario            = @Usuario
   ELSE
      SELECT @Nombre            = Descripcion
      ,      @Tipo              = Tipo_Usuario
      FROM   BacParamSuda..GEN_TIPOS_USUARIO with(nolock)
      WHERE  Tipo_Usuario       = @Usuario

   SELECT Usuario            = @Nombre
        , Tipousuario        = @Tipo
        , Puntero            = gm.indice
        , Modulo             = dt.Modulo
        , Sistema            = CONVERT(CHAR(20), si.nombre_sistema)
        , OpcionMenu         = dt.Opcion
        , Posicion           = gm.Posicion
        , NombreMenu         = REPLACE( UPPER(REPLICATE('    ', gm.Posicion) + dt.Nombre), '&', '')
        , Descripcion        = CASE WHEN DATALENGTH( dt.Descripcion ) = 0 THEN '-' /*REPLICATE('.', 255)*/ ELSE '- ' + dt.Descripcion END
        , UsuarioEmisor      = @xEmisor
        , FechaProceso       = @dFechaProceso
        , FechaEmision       = @dFechaEmision
        , HoraEmision        = @cHoraEmision
        , TituloInforme      = 'INFORME DE PRIVILEGIOS POR ' + CASE WHEN @TipoInf = 'U' THEN 'USUARIO' ELSE 'TIPO DE USUARIO' END
        , GlosaIndicador     = '---------------------'
        , Contador           = identity(Int)
   INTO   #TMP_RETORNO
   FROM   BacParamSuda..GEN_MENU                  gm with(nolock)
          LEFT JOIN BacParamSuda..DETALLE_MENU    dt with(nolock) ON dt.Modulo     = gm.entidad AND dt.Opcion = gm.nombre_objeto
          LEFT JOIN BacParamSuda..GEN_PRIVILEGIOS gp with(nolock) ON gp.entidad    = dt.Modulo  AND gp.opcion = dt.Opcion AND gp.habilitado = 'S'
          LEFT JOIN BacParamSuda..SISTEMA_CNT     si with(nolock) ON si.id_sistema = dt.Modulo
   WHERE  (gm.entidad         = @Modulo  OR @Modulo  = '')
   AND    (gp.usuario         = @Usuario OR @Usuario = '')
   AND     gp.tipo_privilegio = @TipoInf
   ORDER BY gp.usuario, gm.entidad, gm.indice

   UPDATE #TMP_RETORNO SET GlosaIndicador = 'MENU'   WHERE Posicion  = 0
   UPDATE #TMP_RETORNO SET GlosaIndicador = 'OPCION' WHERE Posicion <> 0

   DECLARE @nRegistros   NUMERIC(9)
       SET @nRegistros   = (SELECT MAX(Contador) FROM #TMP_RETORNO)

   DECLARE @nContador    NUMERIC(9)
       SET @nContador    = (SELECT MIN(Contador) FROM #TMP_RETORNO)

   DECLARE @nPosicion    INTEGER
       SET @nPosicion    = -1

   DECLARE @nPosAnterior INTEGER
       SET @nPosAnterior = -1

   WHILE @nRegistros >= @nContador
   BEGIN
      SET @nPosicion = (SELECT Posicion FROM #TMP_RETORNO WHERE Contador = @nContador)

      IF @nPosicion  > 1
      BEGIN
         SET @nPosAnterior = (SELECT Posicion FROM #TMP_RETORNO WHERE Contador = (@nContador -1) )

         IF @nPosAnterior < @nPosicion
            UPDATE #TMP_RETORNO SET GlosaIndicador = 'SUB MENU' WHERE Contador = (@nContador -1)
      END

      SET @nContador = @nContador + 1
   END

   SELECT Usuario
   ,      Tipousuario
   ,      Puntero
   ,      Modulo
   ,      Sistema
   ,      OpcionMenu
   ,      Posicion
   ,      NombreMenu
   ,      Descripcion
   ,      UsuarioEmisor
   ,      FechaProceso
   ,      FechaEmision
   ,      HoraEmision
   ,      TituloInforme
   ,      GlosaIndicador
-- ,      OpcionMenu
-- ,      Posicion
-- ,      NombreMenu
   ,      Contador
   FROM   #TMP_RETORNO

END


GO
