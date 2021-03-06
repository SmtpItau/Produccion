USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_AYUDA_LEE_CLIENTES]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_AYUDA_LEE_CLIENTES]
   (   @nTipo     INTEGER
   ,   @Usuario   VARCHAR(15)
   )
AS
BEGIN

   SET NOCOUNT ON

   CREATE TABLE #TMP_RETORNO
   (   Llave    VARCHAR(12)
   ,   Codigo   INTEGER
   ,   Nombre   VARCHAR(70)
   ,   Rut      NUMERIC(10)
   ,   Dv       CHAR(1)
   )

   IF @nTipo = 1
   BEGIN
      INSERT INTO #TMP_RETORNO
      SELECT DISTINCT
             Llave        = LTRIM(RTRIM( cli.clrut )) + '-' + LTRIM(RTRIM( cli.cldv ))
         ,   Codigo       = cli.clcodigo
         ,   Nombre       = LTRIM(RTRIM( SUBSTRING(cli.clnombre, 1, 70) ))
         ,   Rut          = LTRIM(RTRIM( cli.clrut ))
         ,   Dv           = LTRIM(RTRIM( cli.cldv ))
      FROM   BacParamSuda.dbo.CLIENTE         cli with(nolock)
             INNER JOIN PERFIL_USUARIO_LINEAS usr with(nolock) ON usr.Usuario = @Usuario and usr.Tipo_Cliente = cli.cltipcli and usr.Activado = 1
      WHERE  cli.cltipcli = 1

   END ELSE
   BEGIN
      INSERT INTO #TMP_RETORNO
      SELECT DISTINCT
             Llave        = LTRIM(RTRIM( cli.clrut )) + '-' + LTRIM(RTRIM( cli.cldv ))
         ,   Codigo       = cli.clcodigo
         ,   Nombre       = LTRIM(RTRIM( SUBSTRING(cli.clnombre, 1, 70) ))
         ,   Rut          = LTRIM(RTRIM( cli.clrut ))
         ,   Dv           = LTRIM(RTRIM( cli.cldv ))
      FROM   BacParamSuda.dbo.CLIENTE         cli with(nolock)
             INNER JOIN PERFIL_USUARIO_LINEAS usr with(nolock) ON usr.Usuario = @Usuario and usr.Tipo_Cliente = cli.cltipcli and usr.Activado = 1
      WHERE  cli.cltipcli <> 1

   END 

   SELECT Llave  = Llave
      ,   Codigo = Codigo
      ,   Nombre = Nombre
      ,   Rut    = Rut
      ,   Dv     = Dv
   FROM   #TMP_RETORNO 
   ORDER BY Nombre

END
GO
