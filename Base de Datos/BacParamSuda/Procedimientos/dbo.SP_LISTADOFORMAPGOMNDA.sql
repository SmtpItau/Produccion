USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTADOFORMAPGOMNDA]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LISTADOFORMAPGOMNDA]
AS
BEGIN
 SET NOCOUNT ON
        SELECT   'codigo'  = ISNULL(mncodmon,0),
                  'glosa_corta'   = ISNULL(mnnemo,' '),
                  'glosa_larga'  = ISNULL(mnglosa,' '),
                  'glosa_forma' = ISNULL(' ',' ')
 INTO #TEMPORAL1
 FROM MONEDA
 ORDER BY mncodmon
 SELECT DISTINCT 'codigo'  = mfcodmon,
   'glosa'  = glosa,
   'mdapago'  = mfmonpag,
   'hora'     = CONVERT(varchar(10), GETDATE(), 108)
 INTO #TEMPORAL2
 FROM FORMA_DE_PAGO,MONEDA_FORMA_DE_PAGO
 WHERE codigo = mfcodfor 
 ORDER BY  MFCODMON
 
 SELECT  * FROM #TEMPORAL1,#TEMPORAL2 WHERE #TEMPORAL1..CODIGO=#TEMPORAL2..CODIGO 
 SET NOCOUNT OFF
END

GO
