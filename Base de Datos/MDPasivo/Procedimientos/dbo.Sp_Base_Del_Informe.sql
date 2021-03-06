USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Base_Del_Informe]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[Sp_Base_Del_Informe]
            (
                @acfecproc   CHAR(10) OUTPUT,
                @acfecprox   CHAR(10) OUTPUT,
                @uf_hoy      FLOAT    OUTPUT,
                @uf_man      FLOAT    OUTPUT,
                @ivp_hoy     FLOAT    OUTPUT,
                @ivp_man     FLOAT    OUTPUT,
                @do_hoy      FLOAT    OUTPUT,
                @do_man      FLOAT    OUTPUT,
                @da_hoy      FLOAT    OUTPUT,
                @da_man      FLOAT    OUTPUT,
                @acnomprop   CHAR(40) OUTPUT,
                @rut_empresa CHAR(12) OUTPUT,
                @hora        CHAR(8)  OUTPUT,
                @fecha_busqueda DATETIME
            )
AS
BEGIN

   SET DATEFORMAT dmy


   Select @fecha_busqueda = ISNULL(@fecha_busqueda,(SELECT Fecha_Proceso FROM DATOS_GENERALES))

   DECLARE @FechaCierreUF DATETIME
   DECLARE @FechaCierreObs DATETIME
   DECLARE @lFlag  INTEGER

   SET NOCOUNT ON

   EXECUTE SP_UltimoDia @fecha_busqueda
                     ,  'S'
                     ,  @FechaCierreObs OUTPUT

   SELECT @FechaCierreUF = @FechaCierreObs

   WHILE 1 = 1
   BEGIN
      EXECUTE Sp_FechaHabil @FechaCierreObs, 1, @lFlag OUTPUT

      IF @lFlag = 0  -- CUANDO NO ES FERIADO
      BEGIN
         BREAK
      END 

      SELECT @FechaCierreObs = DATEADD(d, -1, @FechaCierreObs)

   END

   IF @FechaCierreObs <> @fecha_busqueda 
   BEGIN

      /* RETORNAREL ULTIMO DIA HABIL DEL MES ANTERIOR */

      EXECUTE SP_UltimoDia @fecha_busqueda
                     ,  'N'
                     ,  @FechaCierreObs OUTPUT

      SELECT @FechaCierreUF = @FechaCierreObs

      WHILE 1 = 1
      BEGIN
         EXECUTE Sp_FechaHabil @FechaCierreObs, 1, @lFlag OUTPUT

         IF @lFlag = 0  -- CUANDO NO ES FERIADO
         BEGIN
            BREAK
         END 

         SELECT @FechaCierreObs = DATEADD(d, -1, @FechaCierreObs)

      END

   END
               

   SELECT 
       'acfecproc'   = Fecha_Proceso,
       'acfecprox'   = Fecha_Proxima,
       'UF_Hoy'      = CONVERT(FLOAT, 0),
       'UF_Cie'      = CONVERT(FLOAT, 0),
       'IVP_Hoy'     = CONVERT(FLOAT, 0),
       'IVP_Man'     = CONVERT(FLOAT, 0),
       'DO_Hoy'      = CONVERT(FLOAT, 0),
       'DO_Man'      = CONVERT(FLOAT, 0),
       'DA_Hoy'      = CONVERT(FLOAT, 0),
       'DA_Man'      = CONVERT(FLOAT, 0),
       'acnomprop'   = Nombre_Entidad,
       'rut_empresa' = RTRIM(CONVERT(CHAR(10),(SELECT rcrut FROM ENTIDAD))) + '-' + (SELECT rcdv FROM ENTIDAD),
       'hora'        = CONVERT(varchar(30), getdate(),108)
  INTO #PARAMETROS
  FROM DATOS_GENERALES



/* RESCATA VALOR DE UF -------------------------------------------------------------- */

  UPDATE #PARAMETROS SET uf_hoy = ISNULL(vmvalor, 0.0)
                  FROM VALOR_MONEDA 
                 WHERE vmfecha  = acfecproc
                   AND vmcodigo = 998

  UPDATE #PARAMETROS SET uf_cie = ISNULL(vmvalor, 0.0) 
                  FROM VALOR_MONEDA
                 WHERE vmfecha  = @FechaCierreObs
                   AND vmcodigo = 998

/* RESCATA VALOR DE IVP ------------------------------------------------------------- */

   UPDATE #PARAMETROS SET ivp_hoy = ISNULL(vmvalor, 0.0)
                  FROM VALOR_MONEDA
                 WHERE vmfecha  = acfecproc
                   AND vmcodigo = 997

   UPDATE #PARAMETROS SET ivp_man = ISNULL(vmvalor, 0.0)
                  FROM VALOR_MONEDA 
                 WHERE vmfecha  = acfecprox
                   AND vmcodigo = 997

/* RESCATA VALOR DE DO -------------------------------------------------------------- */

   UPDATE #PARAMETROS SET do_hoy = ISNULL(vmvalor, 0.0)
                  FROM VALOR_MONEDA 
                 WHERE vmfecha  = acfecproc
                   AND vmcodigo = 994

   UPDATE #PARAMETROS SET do_man = ISNULL(vmvalor, 0.0)
                  FROM VALOR_MONEDA 
                 WHERE vmfecha = @FechaCierreObs
                   AND vmcodigo = 994

/* RESCATA VALOR DE DA -------------------------------------------------------------- */

   UPDATE #PARAMETROS SET da_hoy = ISNULL(vmvalor, 0.0)
                  FROM VALOR_MONEDA 
                 WHERE vmfecha  = @FechaCierreObs
                   AND vmcodigo = 994

   UPDATE #PARAMETROS SET da_man = ISNULL(vmvalor, 0.0)
                  FROM VALOR_MONEDA 
                 WHERE vmfecha  = @FechaCierreObs
                   AND vmcodigo = 994
	

   SELECT @acfecproc   = (SELECT CONVERT(CHAR(10), acfecproc, 103) FROM #PARAMETROS)
   SELECT @acfecprox   = (SELECT CONVERT(CHAR(10), acfecprox, 103) FROM #PARAMETROS)
   SELECT @uf_hoy      = (SELECT uf_hoy  FROM #PARAMETROS)
   SELECT @uf_man      = (SELECT uf_cie  FROM #PARAMETROS)
   SELECT @ivp_hoy     = (SELECT ivp_hoy FROM #PARAMETROS)
   SELECT @ivp_man     = (SELECT ivp_man FROM #PARAMETROS)
   SELECT @do_hoy      = (SELECT do_hoy  FROM #PARAMETROS)
   SELECT @do_man      = (SELECT do_man  FROM #PARAMETROS)
   SELECT @da_hoy      = (SELECT da_hoy  FROM #PARAMETROS)
   SELECT @da_man      = (SELECT da_man  FROM #PARAMETROS)
   SELECT @acnomprop   = (SELECT acnomprop   FROM #PARAMETROS)
   SELECT @rut_empresa = (SELECT rut_empresa FROM #PARAMETROS)
   SELECT @hora        = (SELECT hora FROM #PARAMETROS)

   SET NOCOUNT OFF

END

GO
