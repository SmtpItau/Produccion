USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_BASE_DEL_INFORME]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BASE_DEL_INFORME]
            (
                @acfecpro   CHAR(10) OUTPUT,
                @acfecprx   CHAR(10) OUTPUT,
                @uf_hoy      FLOAT    OUTPUT,
                @uf_man      FLOAT    OUTPUT,
                @ivp_hoy     FLOAT    OUTPUT,
                @ivp_man     FLOAT    OUTPUT,
                @do_hoy      FLOAT    OUTPUT,
                @do_man      FLOAT    OUTPUT,
                @da_hoy      FLOAT    OUTPUT,
                @da_man      FLOAT    OUTPUT,
                @acnombre    CHAR(40) OUTPUT,
                @rut_empresa CHAR(12) OUTPUT,
                @hora        CHAR(8)  OUTPUT
           )
AS BEGIN
   SET NOCOUNT ON
   SELECT 
       'acfecpro'  = acfecproc,
       'acfecprx'  = acfecprox,
       'UF_Hoy'    = CONVERT(FLOAT, 0),
       'UF_Man'    = CONVERT(FLOAT, 0),
       'IVP_Hoy'   = CONVERT(FLOAT, 0),
       'IVP_Man'   = CONVERT(FLOAT, 0),
       'DO_Hoy'    = CONVERT(FLOAT, 0),
       'DO_Man'    = CONVERT(FLOAT, 0),
       'DA_Hoy'    = CONVERT(FLOAT, 0),
       'DA_Man'    = CONVERT(FLOAT, 0),
       'acnombre'  = acnomprop,
       'rut_empresa' = RTRIM(CONVERT(CHAR(10),acrutprop)) ,
       'hora'      = CONVERT(varchar(30), getdate(),108)   
  INTO #PARAMETROS
  FROM VIEW_MDAC
  
/* RESCATA VALOR DE UF -------------------------------------------------------------- */
  UPDATE #PARAMETROS SET uf_hoy = ISNULL(vmvalor, 0.0)
                  FROM valor_moneda 
                 WHERE vmfecha  = acfecpro
                   AND vmcodigo = 998
  UPDATE #PARAMETROS SET uf_man = ISNULL(vmvalor, 0.0)
                  FROM valor_moneda
                 WHERE vmfecha  = acfecprx
                   AND vmcodigo = 998
/* RESCATA VALOR DE IVP ------------------------------------------------------------- */
   UPDATE #PARAMETROS SET ivp_hoy = ISNULL(vmvalor, 0.0)
                  FROM valor_moneda
                 WHERE vmfecha  = acfecpro
                   AND vmcodigo = 997
   UPDATE #PARAMETROS SET ivp_man = ISNULL(vmvalor, 0.0)
                  FROM valor_moneda 
                 WHERE vmfecha  = acfecprx
                   AND vmcodigo = 997
/* RESCATA VALOR DE DO -------------------------------------------------------------- */
   UPDATE #PARAMETROS SET do_hoy = ISNULL(vmvalor, 0.0)
                  FROM valor_moneda 
                 WHERE vmfecha  = acfecpro
                   AND vmcodigo = 994
   UPDATE #PARAMETROS SET do_man = ISNULL(vmvalor, 0.0)
                  FROM valor_moneda 
                 WHERE vmfecha  = acfecprx
                   AND vmcodigo = 994
/* RESCATA VALOR DE DA -------------------------------------------------------------- */
   UPDATE #PARAMETROS SET da_hoy = ISNULL(vmvalor, 0.0)
                  FROM valor_moneda 
                 WHERE vmfecha  = acfecpro
                   AND vmcodigo = 995
   UPDATE #PARAMETROS SET da_man = ISNULL(vmvalor, 0.0)
                  FROM valor_moneda 
                 WHERE vmfecha  = acfecprx
                   AND vmcodigo = 995
 
   SELECT @acfecpro    = CONVERT(CHAR(10), acfecpro, 103),
          @acfecprx    = CONVERT(CHAR(10), acfecprx, 103),
          @uf_hoy      = uf_hoy,
          @uf_man      = uf_man,
          @ivp_hoy     = ivp_hoy,
          @ivp_man     = ivp_man,
          @do_hoy      = do_hoy,
          @do_man      = do_man,
          @da_hoy      = da_hoy,
          @da_man      = da_man,
          @acnombre    = acnombre ,
          @rut_empresa = rut_empresa,
          @hora        = hora 
          FROM #PARAMETROS
 SET NOCOUNT OFF
END
-- SELECT * FROM VIEW_MDAC
-- select * from valor_moneda
GO
