USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Resumen_Cartera_INTER]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_Resumen_Cartera_INTER]  
         (   @Cdolar        CHAR(01)
         ,   @fechacarX     CHAR(10)
         ,   @fechacar1X    CHAR(10)
         )
AS
BEGIN

   SET DATEFORMAT dmy
   SET NOCOUNT ON

   DECLARE @fechacar   DATETIME
   ,       @fechacar1  DATETIME

   SELECT @fechacar   =  CONVERT(DATETIME,@fechacarX,112)
   ,      @fechacar1  =  CONVERT(DATETIME,@fechacar1X,112)

   DECLARE @Fecha_proceso      CHAR(10)
      ,    @Fecha_proxima	   CHAR(10)	
      ,    @uf_hoy	   FLOAT
      ,    @uf_cie	   FLOAT
      ,    @ivp_hoy	   FLOAT
      ,    @ivp_man	   FLOAT
      ,    @do_hoy	   FLOAT
      ,    @do_man	   FLOAT
      ,    @da_hoy	   FLOAT
      ,    @da_man	   FLOAT
      ,    @Nombre_entidad	   CHAR(40)
      ,    @rut_empresa	   CHAR(12)
      ,    @nRutemp	   NUMERIC(09,00)
      ,    @hora	   CHAR(08)
      ,    @fecha_busqueda DATETIME


   SELECT @fecha_busqueda = @fechacar

   EXECUTE	Sp_Base_Del_Informe
		@Fecha_proceso	OUTPUT
	,	@Fecha_proxima	OUTPUT
	,	@uf_hoy		OUTPUT
	,	@uf_cie		OUTPUT
	,	@ivp_hoy	OUTPUT
	,	@ivp_man	OUTPUT
	,	@do_hoy		OUTPUT
	,	@do_man		OUTPUT
	,	@da_hoy		OUTPUT
	,	@da_man		OUTPUT
	,	@Nombre_entidad	OUTPUT
	,	@rut_empresa	OUTPUT
	,	@hora		OUTPUT
        ,       @fecha_busqueda

         GOTO RESUMEN_CARTERA_INTERBANCARIO



RESUMEN_CARTERA_INTERBANCARIO:
IF @fechacar = (SELECT Fecha_proceso FROM VIEW_DATOS_GENERALES) OR @fechacar1 = (SELECT Fecha_proxima FROM VIEW_DATOS_GENERALES)
  
   IF EXISTS(SELECT 1 FROM RESULTADO_DEVENGO
             WHERE  rsfecha     = @fechacar 
               AND  (rstipopero = 'IB' or rstipopero ='TD' or rstipopero ='LBC') 
               AND  rstipoper   = 'DEV'   
               AND  rscartera   = '121'   
               AND (  ( @cDolar = 'S' and CHARINDEX( STR(rsmonemi,3), '994- 13-995-988' ) > 0 ) or 
                                              ( @cDolar = 'N' and CHARINDEX( STR(rsmonemi,3), '994- 13-995-988' ) = 0 )  ))
   BEGIN

   SELECT 'Instrumento'    = ISNULL((SELECT inserie   FROM VIEW_INSTRUMENTO WHERE incodigo = rscodigo ),'N/A')
      ,   'Moneda_Emision' = ISNULL((SELECT mnsimbol  FROM VIEW_MONEDA      WHERE mncodmon = rsmonpact ),'N/A')
      ,   'Emisor'         = ISNULL((SELECT emgeneric FROM VIEW_EMISOR      WHERE emrut    = rsrutemis),'N/A')
      ,   'Nominal'        = ISNULL(SUM(rsnominal),0.0)
      ,   'Valor_Compra'   = ISNULL(SUM(rsvalcomp),0.0)
      ,   'Interes_Acum'   = ISNULL(SUM(rsinteres_acum),0.0)
      ,   'Reajuste_Acum'  = ISNULL(SUM(rsreajuste_acum),0.0)
      ,   'Proceso'        = ISNULL(SUM(rsvppresen),0.0)
      ,   'Interes'        = ISNULL(SUM(rsinteres),0.0)
      ,   'Reajuste'       = ISNULL(SUM(rsreajuste),0.0)
      ,   'Prox_Proceso'   = ISNULL(SUM(rsvppresenx),0.0)
      ,   'Fecha_Cartera'  = @fechacar
      ,   'fecproc'        = @Fecha_proceso
      ,   'fecprox'	   = @Fecha_proxima
      ,   'uf_hoy'	   = @uf_hoy
      ,   'uf_cie'	   = @uf_cie
      ,   'ivp_hoy'	   = @ivp_hoy
      ,   'ivp_man'	   = @ivp_man
      ,   'do_hoy'	   = @do_hoy
      ,   'do_man'	   = @do_man
      ,   'da_hoy'	   = @da_hoy
      ,   'da_man'	   = @da_man
      ,   'Fecha_Emision'  = CONVERT(CHAR(10),GETDATE(),103)
      ,   'Hora_Emision'   = CONVERT(CHAR(08),GETDATE(),108)
      ,   'Fecha1'	   = CONVERT(CHAR(10),@fechacar,103)
      ,	  'Fecha2'	   = CONVERT(CHAR(10),@fechacar1,103)
      ,   'tipo_cliente'   = space(30)
      ,   'tipo_emisor'    = space(30)
      ,   'plazo_pacto'    = space(30)
   INTO #TEMPINTER
   FROM RESULTADO_DEVENGO
   WHERE  rsfecha     = @fechacar
    AND  (rstipopero  = 'IB' or rstipopero ='TD' or rstipopero ='LBC') 
    AND   rstipoper   = 'DEV'   
    AND   rscartera   = '121'   
    AND  (  ( @cDolar = 'S' and CHARINDEX( STR(rsmonemi,3), '994- 13-995-988' ) > 0 ) or 
                                              ( @cDolar = 'N' and CHARINDEX( STR(rsmonemi,3), '994- 13-995-988' ) = 0 )  )


   GROUP BY rscodigo, rsmonpact, rsrutemis
   ORDER BY rscodigo, rsmonpact, rsrutemis

   SELECT * FROM #TEMPINTER

   END ELSE
   BEGIN

       IF NOT EXISTS ( SELECT 1 FROM CARTERA_INTERBANCARIA 

                       WHERE    (LTRIM(RTRIM(Codigo_Subproducto)) <> 'FPD') AND
				(  ( @cDolar = 'S' and CHARINDEX( STR(moneda_pacto,3), '994- 13-995-988' ) > 0 ) or 
                                ( @cDolar = 'N' and CHARINDEX( STR(moneda_pacto,3), '994- 13-995-988' ) = 0 )  ))

       BEGIN

          GOTO VALORES_POR_DEFECTO

       END

   SELECT 'Instrumento'    = ISNULL((SELECT inserie   FROM VIEW_INSTRUMENTO WHERE incodigo = codigo ),'N/A')
      ,   'Moneda_Emision' = ISNULL((SELECT mnsimbol  FROM VIEW_MONEDA      WHERE mncodmon = moneda_pacto ),'N/A')
      ,   'Emisor'         = ISNULL((select clnombre from view_cliente where Rut_Cliente=clrut AND codigo_cliente = clcodigo),'N/A')
      ,   'Nominal'        = ISNULL(SUM(nominal),0.0)
      ,   'Valor_Compra'   = ISNULL(SUM(valor_compra),0.0)
      ,   'Interes_Acum'   = ISNULL(SUM(Interes_compra),0.0)
      ,   'Reajuste_Acum'  = ISNULL(SUM(Reajuste_compra),0.0)
      ,   'Proceso'        = ISNULL(SUM(valor_presente_tir_compra),0.0)
      ,   'Interes'        = CONVERT(FLOAT,0)
      ,   'Reajuste'       = CONVERT(FLOAT,0)
      ,   'Prox_Proceso'   = ISNULL(SUM(valor_presente_tir_compra),0.0)
      ,   'Fecha_Cartera'  = @fechacar
      ,   'fecproc'        = @Fecha_proceso
      ,   'fecprox'	   = @Fecha_proxima
      ,   'uf_hoy'	   = @uf_hoy
      ,   'uf_cie'	   = @uf_cie
      ,   'ivp_hoy'	   = @ivp_hoy
      ,   'ivp_man'	   = @ivp_man
      ,   'do_hoy'	   = @do_hoy
      ,   'do_man'	   = @do_man
      ,   'da_hoy'	   = @da_hoy
      ,   'da_man'	   = @da_man
      ,   'Fecha_Emision'  = CONVERT(CHAR(10),GETDATE(),103)
      ,   'Hora_Emision'   = CONVERT(CHAR(08),GETDATE(),108)
      ,   'Fecha1'	   = CONVERT(CHAR(10),@fechacar,103)
      ,	  'Fecha2'	   = CONVERT(CHAR(10),@fechacar1,103)
      ,   'tipo_cliente'   = space(30)
      ,   'tipo_emisor'    = space(30)
      ,   'plazo_pacto'    = space(30)
   INTO #TEMPINTER1
   FROM	CARTERA_INTERBANCARIA 
   WHERE   (LTRIM(RTRIM(Codigo_Subproducto)) <> 'FPD') AND
		(  ( @cDolar = 'S' and CHARINDEX( STR(moneda_pacto,3), '994- 13-995-988' ) > 0 ) or 
                   ( @cDolar = 'N' and CHARINDEX( STR(moneda_pacto,3), '994- 13-995-988' ) = 0 )  )
   GROUP BY codigo, moneda_pacto, Rut_Cliente,codigo_cliente
   ORDER BY codigo, moneda_pacto, Rut_Cliente

   SELECT * FROM #TEMPINTER1

  END ELSE

      GOTO CARTERA_HISTORICA_TRADER

      GOTO FIN

CARTERA_HISTORICA_TRADER:


   BEGIN   
   IF NOT EXISTS(SELECT 1 FROM RESULTADO_DEVENGO
                 WHERE  rsfecha = @fechacar
                  AND  (rstipopero ='IB' OR rstipopero ='TD' or rstipopero ='LBC') 
                  AND   rstipoper = 'DEV'   
                  AND   rscartera = '121'   
                  AND (  ( @cDolar = 'S' and CHARINDEX( STR(rsmonemi,3), '994- 13-995-988' ) > 0 ) or 
                                              ( @cDolar = 'N' and CHARINDEX( STR(rsmonemi,3), '994- 13-995-988' ) = 0 )  ))
   BEGIN

      GOTO VALORES_POR_DEFECTO

   END

   SELECT 'Instrumento'    = ISNULL((SELECT inserie   FROM VIEW_INSTRUMENTO WHERE incodigo = rscodigo ),'N/A')
      ,   'Moneda_Emision' = ISNULL((SELECT mnsimbol  FROM VIEW_MONEDA      WHERE mncodmon = rsmonpact ),'N/A')
      ,   'Emisor'         = ISNULL((SELECT emgeneric FROM VIEW_EMISOR      WHERE emrut    = rsrutemis),'N/A')
      ,   'Nominal'        = ISNULL(SUM(rsnominal),0.0)
      ,   'Valor_Compra'   = ISNULL(SUM(rsvalcomp),0.0)
      ,   'Interes_Acum'   = ISNULL(SUM(rsinteres_acum),0.0)
      ,   'Reajuste_Acum'  = ISNULL(SUM(rsreajuste_acum),0.0)
      ,   'Proceso'        = ISNULL(SUM(rsvppresen),0.0)
      ,   'Interes'        = ISNULL(SUM(rsinteres),0.0)
      ,   'Reajuste'       = ISNULL(SUM(rsreajuste),0.0)
      ,   'Prox_Proceso'   = ISNULL(SUM(rsvppresenx),0.0)
      ,   'Fecha_Cartera'  = @fechacar
      ,   'fecproc'        = @Fecha_proceso
      ,   'fecprox'	   = @Fecha_proxima
      ,   'uf_hoy'	   = @uf_hoy
      ,   'uf_cie'	   = @uf_cie
      ,   'ivp_hoy'	   = @ivp_hoy
      ,   'ivp_man'	   = @ivp_man
      ,   'do_hoy'	   = @do_hoy
      ,   'do_man'	   = @do_man
      ,   'da_hoy'	   = @da_hoy
      ,   'da_man'	   = @da_man
      ,   'Fecha_Emision'  = CONVERT(CHAR(10),GETDATE(),103)
      ,   'Hora_Emision'   = CONVERT(CHAR(08),GETDATE(),108)
      ,   'Fecha1'	   = CONVERT(CHAR(10),@fechacar,103)
      ,	  'Fecha2'	   = CONVERT(CHAR(10),@fechacar1,103)
      ,   'tipo_cliente'   = space(30)
      ,   'tipo_emisor'    = space(30)
      ,   'plazo_pacto'    = space(30)
   INTO #TEMP3   
   FROM RESULTADO_DEVENGO
   WHERE   rsfecha = @fechacar
    AND   (rstipopero = 'IB'    OR rstipopero = 'TD' OR rstipopero = 'LBC') 
    AND    rstipoper  = 'DEV'
    AND    rscartera  = '121'
    AND     (  ( @cDolar = 'S' and CHARINDEX( STR(rsmonemi,3), '994- 13-995-988' ) > 0 ) or 
       ( @cDolar = 'N' and CHARINDEX( STR(rsmonemi,3), '994- 13-995-988' ) = 0 )  )
   GROUP BY rscodigo, rsmonpact, rsrutemis
   ORDER BY rscodigo, rsmonpact, rsrutemis

   SELECT * FROM #TEMP3

   END

   GOTO FIN



VALORES_POR_DEFECTO:

   SELECT 'Instrumento'    = ''
      ,   'Moneda_Emision' = ''
      ,   'Emisor'         = ''
      ,   'Nominal'        = ''
      ,   'Valor_Compra'   = ''
      ,   'Interes_Acum'   = ''
      ,   'Reajuste_Acum'  = ''
      ,   'Proceso'        = ''
      ,   'Interes'        = ''
      ,   'Reajuste'       = ''
      ,   'Prox_Proceso'   = ''
      ,   'Fecha_Cartera'  = @fechacar
      ,   'fecproc'        = @Fecha_proceso
      ,   'fecprox'	   = @Fecha_proxima
      ,   'uf_hoy'	   = @uf_hoy
      ,   'uf_cie'	   = @uf_cie
      ,   'ivp_hoy'	   = @ivp_hoy
      ,   'ivp_man'	   = @ivp_man
      ,   'do_hoy'	   = @do_hoy
      ,   'do_man'	   = @do_man
      ,   'da_hoy'	   = @da_hoy
      ,   'da_man'	   = @da_man
      ,   'Fecha_Emision'  = CONVERT(CHAR(10),GETDATE(),103)
      ,   'Hora_Emision'   = CONVERT(CHAR(08),GETDATE(),108)
      ,   'Fecha1'	   = CONVERT(CHAR(10),@fechacar,103)
      ,	  'Fecha2'	   = CONVERT(CHAR(10),@fechacar1,103)
      ,   'tipo_cliente'   = ''
      ,   'tipo_emisor'    = space(30)
      ,   'plazo_pacto'    = ''
      
FIN:
   SET NOCOUNT OFF
END

GO
