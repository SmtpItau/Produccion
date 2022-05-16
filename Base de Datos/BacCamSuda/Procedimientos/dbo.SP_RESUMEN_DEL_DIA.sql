USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RESUMEN_DEL_DIA]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_RESUMEN_DEL_DIA]
AS
BEGIN
 SELECT	        'ACPREHINI' = achedgeprecioinicial
		,'ACPOSHINI' = achedgeinicialspot+achedgeinicialfuturo
		,'ACPRECIE'  = acprecie
		,'ACPOSICH'  = achedgeactualspot+achedgeactualfuturo
                ,'ACPOSHSPT' = achedgeactualspot
                ,'ACUHEDGE'  = achedgeutilidad
		,'ACPOSINI'  = acposini
                ,'ACPREINI'  = acpreini
                ,'ACPOSIC'   = acposic
                ,'ACPMECO'   = acpmeco
                ,'ACTOTCO'   = actotco
                ,'ACPMEVE'   = acpmeve
                ,'ACTOTVE'   = actotve
                ,'ACUTILI'   = acutili
                ,'ACFECPRO'  = acfecpro
                ,'Hora'      = CONVERT(CHAR(08),GETDATE(),108)
 FROM meac
        
END




GO
