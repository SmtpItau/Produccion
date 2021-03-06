USE [CbMdbOpc]
GO
/****** Object:  View [dbo].[TMP_OPCIONES]    Script Date: 16-05-2022 10:16:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
create view [dbo].[TMP_OPCIONES]
AS
SELECT     *
FROM
      CaDetContrato
,     OpcionesGeneral
WHERE
            (
            CaModalidad = 'C'
      AND CaBenchComp = 994
      AND   CaFechaVcto > FechaProx
            )
      OR
            (
            CaModalidad = 'E'
      AND   CaFechaVcto > FechaProc
            )


GO
