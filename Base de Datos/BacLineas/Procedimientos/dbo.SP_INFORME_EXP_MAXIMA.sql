USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORME_EXP_MAXIMA]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_INFORME_EXP_MAXIMA]
AS
BEGIN
   SET NOCOUNT ON

      SELECT SUBSTRING(GP.descripcion,1,50) AS Grup_Descripcion
      ,      GP.codigo_grupo                AS Grup_Codigo
      ,      ISNULL(PG.totalposicion,0)     AS Grup_TotPosicion
      ,      ISNULL(PG.totalocupado,0)      AS Grup_TotOcupado
      ,      ISNULL(PG.totaldisponible,0)   AS Grup_TotDisponible
      ,      ISNULL(PG.porcentaje,0)        AS Grup_Totporcentaje
      ,      ISNULL(PG.totalexcedido,0)     AS Grup_TotExcedido
      ,      GP.sistema                     AS Sistema       
      FROM   GRUPO_POSICION GP
      LEFT OUTER JOIN POSICION_GRUPO PG
      ON GP.codigo_grupo = PG.codigo_grupo
      RETURN

   SET NOCOUNT OFF

END
GO
