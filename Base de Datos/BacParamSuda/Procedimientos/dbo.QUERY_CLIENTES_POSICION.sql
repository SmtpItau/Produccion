USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[QUERY_CLIENTES_POSICION]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[QUERY_CLIENTES_POSICION]
AS
BEGIN

   SET NOCOUNT ON

   CREATE TABLE #TMP_CLIENTES
   (   Rut         NUMERIC(12)
   ,   Dv          CHAR(1)
   ,   Nombre      VARCHAR(150)
   )

   INSERT INTO #TMP_CLIENTES
   SELECT DISTINCT 
          Rut         = clrut
   ,      Dv          = cldv
   ,      Nombre      = clnombre
   FROM   BactraderSuda..MDCP
          INNER JOIN BacParamSuda.dbo.CLIENTE ON clrut = cprutcli and clcodigo = cpcodcli
   WHERE  cpnominal > 0

   INSERT INTO #TMP_CLIENTES
   SELECT DISTINCT 
          Rut         = clrut
   ,      Dv          = cldv
   ,      Nombre      = clnombre
   FROM   BactraderSuda..MDCI
          INNER JOIN BacParamSuda.dbo.CLIENTE ON clrut = cirutcli and clcodigo = cicodcli

   INSERT INTO #TMP_CLIENTES
   SELECT DISTINCT 
          Rut         = clrut
   ,      Dv          = cldv
   ,      Nombre      = clnombre
   FROM   BactraderSuda..MDVI
          INNER JOIN BacParamSuda.dbo.CLIENTE ON clrut = virutcli and clcodigo = vicodcli

   INSERT INTO #TMP_CLIENTES
   SELECT DISTINCT 
          Rut         = clrut
   ,      Dv          = cldv
   ,      Nombre      = clnombre
   FROM   BacFwdSuda.dbo.MFCA
          INNER JOIN BacParamSuda.dbo.CLIENTE ON clrut = cacodigo and clcodigo = cacodcli

   INSERT INTO #TMP_CLIENTES
   SELECT DISTINCT 
          Rut         = clrut
   ,      Dv          = cldv
   ,      Nombre      = clnombre
   FROM   BacSwapSuda.dbo.CARTERA
          INNER JOIN BacParamSuda.dbo.CLIENTE ON clrut = rut_cliente and clcodigo = codigo_cliente

   INSERT INTO #TMP_CLIENTES
   SELECT DISTINCT 
          Rut         = clrut
   ,      Dv          = cldv
   ,      Nombre      = clnombre
   FROM   BacCamSuda.dbo.MEMO
          INNER JOIN BacParamSuda.dbo.CLIENTE ON clrut = morutcli and clcodigo = mocodcli


   SELECT DISTINCT Rut, Dv, Nombre FROM #TMP_CLIENTES ORDER BY Nombre

END
GO
