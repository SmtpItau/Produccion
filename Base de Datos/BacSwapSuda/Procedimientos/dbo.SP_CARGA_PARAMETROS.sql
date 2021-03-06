USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGA_PARAMETROS]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CARGA_PARAMETROS]  
AS
BEGIN

SET NOCOUNT ON

SELECT  fechaproc,
        fechaprox,
       'UF_Hoy'    = CONVERT(FLOAT, 0),
       'UF_Man'    = CONVERT(FLOAT, 0),
       'IVP_Hoy'   = CONVERT(FLOAT, 0),
       'IVP_Man'   = CONVERT(FLOAT, 0),
       'DO_Hoy'    = CONVERT(FLOAT, 0),
       'DO_Man'    = CONVERT(FLOAT, 0),
       'DA_Hoy'    = CONVERT(FLOAT, 0),
       'DA_Man'    = CONVERT(FLOAT, 0),
        nombre,
        rut,
	'hora'     = CONVERT(CHAR(8),GETDATE(),108)
  INTO #Parametros
  FROM SwapGeneral

/* RESCATA VALOR DE UF -------------------------------------------------------------- */

UPDATE #Parametros SET UF_Hoy = ISNULL(View_Valor_Moneda.vmvalor, 0.0)
                  FROM View_Valor_Moneda     
                 WHERE View_Valor_Moneda.vmfecha  = fechaproc
                   AND View_Valor_Moneda.vmcodigo = 998

UPDATE #Parametros SET UF_Man = ISNULL(View_Valor_Moneda.vmvalor, 0.0)
                  FROM View_Valor_Moneda
                 WHERE View_Valor_Moneda.vmfecha  = fechaprox
                   AND View_Valor_Moneda.vmcodigo = 998

/* RESCATA VALOR DE IVP ------------------------------------------------------------- */

UPDATE #Parametros SET IVP_Hoy = ISNULL(View_Valor_Moneda.vmvalor, 0.0)
                  FROM View_Valor_Moneda
                 WHERE View_Valor_Moneda.vmfecha  = fechaproc
                   AND View_Valor_Moneda.vmcodigo = 997

UPDATE #Parametros SET IVP_Man = ISNULL(View_Valor_Moneda.vmvalor, 0.0)
                  FROM View_Valor_Moneda
                 WHERE View_Valor_Moneda.vmfecha  = fechaprox
                   AND View_Valor_Moneda.vmcodigo = 997

/* RESCATA VALOR DE DOLAR OBSERVADO  ----------------------------------------------- */

UPDATE #Parametros SET DO_Hoy = ISNULL(View_Valor_Moneda.vmvalor, 0.0)
                  FROM View_Valor_Moneda
                 WHERE View_Valor_Moneda.vmfecha  = fechaproc
                   AND View_Valor_Moneda.vmcodigo = 994

UPDATE #Parametros SET DO_Man = ISNULL(View_Valor_Moneda.vmvalor, 0.0)
                  FROM View_Valor_Moneda
                 WHERE View_Valor_Moneda.vmfecha  = fechaprox
                   AND View_Valor_Moneda.vmcodigo = 994

/* RESCATA VALOR DE DOLAR ACUERDO --------------------------------------------------- */

UPDATE #Parametros  SET DA_Hoy = ISNULL(View_Valor_Moneda.vmvalor, 0.0)
                   FROM View_Valor_Moneda
                  WHERE View_Valor_Moneda.vmfecha  = fechaproc
                    AND View_Valor_Moneda.vmcodigo = 995

UPDATE #Parametros SET DA_Man = ISNULL(View_Valor_Moneda.vmvalor, 0.0)
                  FROM View_Valor_Moneda
                 WHERE View_Valor_Moneda.vmfecha  = fechaprox
                   AND View_Valor_Moneda.vmcodigo = 995

SELECT fecha_proc = CONVERT(CHAR(10), fechaproc, 103),
       fecha_prox = CONVERT(CHAR(10), fechaprox, 103),
       UF_Hoy,
       UF_Man,
       IVP_Hoy,
       IVP_Man,
       DO_Hoy,
       DO_Man,
       DA_Hoy,
       DA_Man,
       nombre,
       rut,
       hora 
 FROM #Parametros

SET NOCOUNT OFF

END  -- FIN PROCEDIMIENTO

GO
