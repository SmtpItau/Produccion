USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Vctos_Vtas_Conpacto_Reporte]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_Vctos_Vtas_Conpacto_Reporte]
        						(
							@XFECHAPRO      CHAR(10) 	,
							@XFECHAVTO      CHAR(10)	,
							@inorden	INTEGER		,
							@infamilia	NUMERIC(05)	,
							@icdolar	CHAR(01)
							)

AS
BEGIN

   SET DATEFORMAT dmy

--////REPORTE VENCIMIENTOS DE VENTAS CON PACTO ///////---
   DECLARE      @FECHAPRO         DATETIME
         ,      @FECHAVTO         DATETIME

   SELECT       @FECHAPRO       = CONVERT(DATETIME,@XFECHAPRO,112)
         ,      @FECHAVTO       = CONVERT(DATETIME,@XFECHAVTO,112)     
 
      DECLARE	@Fecha_proceso	CHAR	(10)	,
		@Fecha_proxima	CHAR	(10)	,
		@uf_hoy		FLOAT		,
		@uf_man		FLOAT		,
		@ivp_hoy	FLOAT		,
		@ivp_man	FLOAT		,
		@do_hoy		FLOAT		,
		@do_man		FLOAT		,
		@da_hoy		FLOAT		,
		@da_man		FLOAT		,
		@Nombre_entidad	CHAR	(40)	,
		@rut_empresa	CHAR	(12)	,
		@nRutemp	NUMERIC	(09,0)	,
		@hora		CHAR	(08)	,
		@paso		CHAR	(01)    ,
                @fecha_busqueda DATETIME  

        SELECT @fecha_busqueda= (SELECT Fecha_proceso FROM VIEW_DATOS_GENERALES)

	EXECUTE	Sp_Base_Del_Informe
		@Fecha_proceso	OUTPUT
	,	@Fecha_proxima	OUTPUT
	,	@uf_hoy		OUTPUT
	,	@uf_man		OUTPUT
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

set @paso='N'
-- Sp_Vctos_Vtas_Conpacto_Reporte '20010914','20010914'
--select * from CARTERA_HISTORICA_TRADER
IF @fechapro = @fecha_busqueda

begin

IF EXISTS (SELECT 1 FROM CARTERA_VENTA_PACTO WHERE CONVERT(CHAR(10),vifecvenp,112) <= CONVERT(CHAR(10),@fechavto,112) 
					     AND  (vicodigo = @infamilia OR @infamilia = 0)
					     AND   CHARINDEX(STR(vimonpact,3),CASE WHEN @icdolar ='N' THEN  '997-998-999' ELSE '988-994-995- 13' END)>0    )

BEGIN


         SELECT
             'NumeroDocumento'   = CONVERT(CHAR(07),REPLICATE('0', 07 - LEN(LTRIM(STR(ISNULL(vinumoper,0))))) + LTRIM(STR(ISNULL(vinumoper,0))))
         ,   'Serie'             = ISNULL(viinstser,'')
         ,   'ValorNominal'      = ISNULL(vinominal,0)
         ,   'ValorInicial'      = CASE WHEN LTRIM(RTRIM(Tipo_Operacion)) = 'VIX' THEN ISNULL(vivalinip,0)
					WHEN  LTRIM(RTRIM(Tipo_Operacion)) = 'VI'AND vimonpact = 999 THEN ISNULL(vivalinip,0)
					WHEN  LTRIM(RTRIM(Tipo_Operacion)) = 'VI'AND vimonpact <> 999 THEN ISNULL(vivalinip,0)
				   END
         ,   'ValorFinal'        = CASE WHEN LTRIM(RTRIM(Tipo_Operacion)) = 'VIX' THEN ISNULL(vivalvenp,0)
					WHEN  LTRIM(RTRIM(Tipo_Operacion)) = 'VI'AND vimonpact = 999 THEN ISNULL(vivalvenp,0)
					WHEN  LTRIM(RTRIM(Tipo_Operacion)) = 'VI'AND vimonpact <> 999 THEN (ISNULL(vivalvenp,0)* ISNULL((SELECT b.vmvalor FROM VIEW_VALOR_MONEDA b WHERE  b.vmcodigo = vimonpact AND b.vmfecha = (SELECT MAX(c.vmfecha)FROM VIEW_VALOR_MONEDA c WHERE c.vmcodigo = vimonpact AND c.vmfecha <= vifecvenp AND c.vmfecha >= vifecinip)),1))
				   END
         ,   'TasaPacto'         = ISNULL(vitaspact,0)
         ,   'MonedaPacto'       = ISNULL((SELECT mnnemo   FROM VIEW_MONEDA WHERE vimonpact=mncodmon),' ')   
         ,   'FormaPago'         = ISNULL((SELECT glosa FROM VIEW_FORMA_DE_PAGO WHERE viforpagi = codigo),' ')
         ,   'FechaVcto'         = ISNULL(vifecvenp,' ')
         ,   'Fechainicio'       = ISNULL(vifecinip,' ')
         ,   'Plazo'             = DATEDIFF(DD,vifecinip,vifecvenp)
         ,   'Cliente'           = ISNULL((SELECT clnombre FROM VIEW_CLIENTE WHERE clcodigo = vicodcli AND virutcli = clrut),'NO EXISTE CLIENTE')
         ,   'FechaTitulo'       = @fechavto
         ,   'fecproc'	         = @Fecha_proceso
         ,   'fecprox'	         = @Fecha_proxima
	 ,   'uf_hoy'	         = @uf_hoy
	 ,   'uf_man'	         = @uf_man
	 ,   'ivp_hoy'	         = @ivp_hoy
	 ,   'ivp_man'           = @ivp_man
	 ,   'do_hoy'	         = @do_hoy
	 ,   'do_man'	         = @do_man
	 ,   'da_hoy'	         = @da_hoy
	 ,   'da_man'	         = @da_man
	 ,   'rut_empresa'       = @rut_empresa
	 ,   'hora'		 = @hora
         ,   'fecha'             = CONVERT(CHAR(10),GETDATE(),103)  
         ,   'Titulo'            = CASE WHEN @icdolar = 'N' THEN 'VENCIMIENTO VENTAS CON PACTO AL ' + CONVERT(CHAR(10),@fechavto,103)
					ELSE 'VENCIMIENTO VENTAS CON PACTO EN DOLARES AL ' + CONVERT(CHAR(10),@fechavto,103) END
         ,   'Tipo'              = tipo_operacion
	 ,   'orden'		 = @inorden
         ,   'FechaVctoc'        = ISNULL(CONVERT(CHAR(10),vifecvenp,112),' ')
         ,   'FechaVctocc'       = ISNULL(CONVERT(CHAR(10),vifecvenp,103),' ')
	 ,   'familia'		 = inglosa
	 ,   'numero_doc'	 = CONVERT(CHAR(12),REPLICATE('0', 07 - LEN(LTRIM(STR(vinumdocu)))) + LTRIM(STR(vinumdocu))+ '-' +
                                   REPLICATE('0', 03 - LEN(LTRIM(STR(vicorrela)))) + LTRIM(STR(vicorrela)))
	 ,   'vcto_papel'	 = DATEDIFF(DAY ,@fecha_busqueda,vifecven)
	 ,   'tasa_papel'	 = ISNULL(vitircomp,0)
	 ,   'tasa_trans'	 = ISNULL(Precio_Transferencia,0)

   FROM   CARTERA_VENTA_PACTO 	, 
	  VIEW_INSTRUMENTO	
  WHERE  CONVERT(CHAR(10),vifecvenp,112) <= CONVERT(CHAR(10),@fechavto,112)
   AND	  vicodigo = incodigo
   AND	  (vicodigo = @infamilia OR @infamilia = 0)
   AND	  CHARINDEX(STR(vimonpact,3),CASE WHEN @icdolar ='N' THEN  '997-998-999' ELSE '988-994-995- 13' END)>0    

   SET @PASO='S'

END
END ELSE BEGIN 

IF EXISTS (SELECT 1 FROM CARTERA_HISTORICA_TRADER
           WHERE  (codigo_cartera = 'VI' OR  codigo_cartera = 'VIX')
            AND   CONVERT(CHAR(10),fecvenp,112) <= CONVERT(CHAR(10),@fechavto,112)
            AND   @fechapro = fecha_proceso AND	  (codigo = @infamilia OR @infamilia = 0)
            AND	  CHARINDEX(STR(monpact,3),CASE WHEN @icdolar ='N' THEN  '997-998-999' ELSE '988-994-995- 13' END)>0 )

BEGIN
         SELECT
             'NumeroDocumento'   = CONVERT(CHAR(07),REPLICATE('0', 07 - LEN(LTRIM(STR(ISNULL(numoper,0))))) + LTRIM(STR(ISNULL(numoper,0))))
         ,   'Serie'             = ISNULL(instser,'')
         ,   'ValorNominal'      = ISNULL(nominal,0)
         ,   'ValorInicial'      = CASE WHEN LTRIM(RTRIM(codigo_cartera)) = 'VIX' THEN ISNULL(valinip,0)
					WHEN  LTRIM(RTRIM(codigo_cartera)) = 'VI'AND monpact = 999 THEN ISNULL(valinip,0)
					WHEN  LTRIM(RTRIM(codigo_cartera)) = 'VI'AND monpact <> 999 THEN ISNULL(valinip,0)
				   END
         ,   'ValorFinal'        = CASE WHEN LTRIM(RTRIM(codigo_cartera)) = 'VIX' THEN ISNULL(valvenp,0)
					WHEN  LTRIM(RTRIM(codigo_cartera)) = 'VI'AND monpact = 999 THEN ISNULL(valvenp,0)
					WHEN  LTRIM(RTRIM(codigo_cartera)) = 'VI'AND monpact <> 999 THEN (ISNULL(valvenp,0)* ISNULL((SELECT b.vmvalor FROM VIEW_VALOR_MONEDA b WHERE  b.vmcodigo = monpact AND b.vmfecha = (SELECT MAX(c.vmfecha)FROM VIEW_VALOR_MONEDA c WHERE c.vmcodigo = monpact AND c.vmfecha <= fecvenp AND c.vmfecha >= fecinip)),1))
				   END
         ,   'TasaPacto'         = ISNULL(taspact,0)
         ,   'MonedaPacto'       = ISNULL((SELECT mnnemo   FROM VIEW_MONEDA WHERE monpact=mncodmon),' ')   
         ,   'FormaPago'         = ISNULL((SELECT glosa FROM VIEW_FORMA_DE_PAGO WHERE forpagi = codigo),' ')
         ,   'FechaVcto'         = ISNULL(fecvenp,' ')
         ,   'Fechainicio'       = ISNULL(fecinip,' ')
         ,   'Plazo'             = DATEDIFF(DD,fecinip,fecvenp)
         ,   'Cliente'           = ISNULL((SELECT clnombre FROM VIEW_CLIENTE WHERE clcodigo = codcli AND rutcli = clrut),'NO EXISTE CLIENTE')
         ,   'FechaTitulo'       = @fechavto
         ,   'fecproc'	         = @Fecha_proceso
         ,   'fecprox'	         = @Fecha_proxima
	 ,   'uf_hoy'	         = @uf_hoy
	 ,   'uf_man'	         = @uf_man
	 ,   'ivp_hoy'	         = @ivp_hoy
	 ,   'ivp_man'           = @ivp_man
	 ,   'do_hoy'	         = @do_hoy
	 ,   'do_man'	         = @do_man
	 ,   'da_hoy'	         = @da_hoy
	 ,   'da_man'	         = @da_man
	 ,   'rut_empresa'       = @rut_empresa
	 ,   'hora'		 = @hora
         ,   'fecha'             = CONVERT(CHAR(10),GETDATE(),103)  
         ,   'Titulo'            = CASE WHEN @icdolar = 'N' THEN 'VENCIMIENTO VENTAS CON PACTO AL ' + CONVERT(CHAR(10),@fechavto,103)
					ELSE 'VENCIMIENTO VENTAS CON PACTO EN DOLARES AL ' + CONVERT(CHAR(10),@fechavto,103) END
         ,   'Tipo'              = codigo_cartera 
	 ,   'orden'		 = @inorden
         ,   'FechaVctoc'        = ISNULL(CONVERT(CHAR(10),fecvenp,112),' ')
         ,   'FechaVctocc'        = ISNULL(CONVERT(CHAR(10),fecvenp,103),' ')
	 ,   'familia'		 = inglosa
	 ,   'numero_doc'	 = CONVERT(CHAR(12),REPLICATE('0', 07 - LEN(LTRIM(STR(numdocu)))) + LTRIM(STR(numdocu))+ '-' +
                                   REPLICATE('0', 03 - LEN(LTRIM(STR(correla)))) + LTRIM(STR(correla)))
	 ,   'vcto_papel'	 = DATEDIFF(DAY ,@fecha_busqueda,fecven)
	 ,   'tasa_papel'	 = ISNULL(tircomp,0)
	 ,   'tasa_trans'	 = ISNULL(Precio_Transferencia,0)

   FROM   CARTERA_HISTORICA_TRADER 	, 
	  VIEW_INSTRUMENTO	
   WHERE  (codigo_cartera = 'VI' OR  codigo_cartera = 'VIX')
    AND   CONVERT(CHAR(10),fecvenp,112) <= CONVERT(CHAR(10),@fechavto,112)
    AND   @fechapro = fecha_proceso
    AND	  codigo = incodigo
    AND	  (codigo = @infamilia OR @infamilia = 0)
    AND	  CHARINDEX(STR(monpact,3),CASE WHEN @icdolar ='N' THEN  '997-998-999' ELSE '988-994-995- 13' END)>0    
    
   SET @PASO='S'

END
END

IF @PASO='N'

      SELECT   
             'NumeroDocumento'   = '' 
         ,   'Serie'             = ''
         ,   'ValorNominal'      = CONVERT(FLOAT,0)
         ,   'ValorInicial'      = CONVERT(FLOAT,0)
         ,   'ValorFinal'        = CONVERT(FLOAT,0)
         ,   'TasaPacto'         = CONVERT(FLOAT,0)
         ,   'MonedaPacto'       = ''
         ,   'FormaPago'         = ''
         ,   'FechaVcto'         = ''
         ,   'Fechainicio'       = ''
         ,   'Plazo'             = 0
         ,   'Cliente'           = ''
         ,   'FechaTitulo'       = @fechavto
         ,   'fecproc'	         = @Fecha_proceso
         ,   'fecprox'	         = @Fecha_proxima
	 ,   'uf_hoy'	         = @uf_hoy
	 ,   'uf_man'	         = @uf_man
	 ,   'ivp_hoy'	         = @ivp_hoy
	 ,   'ivp_man'           = @ivp_man
	 ,   'do_hoy'	         = @do_hoy
	 ,   'do_man'	         = @do_man
	 ,   'da_hoy'	         = @da_hoy
	 ,   'da_man'	         = @da_man
	 ,   'rut_empresa'       = @rut_empresa
	 ,   'hora'		 = @hora
         ,   'fecha'             = CONVERT(CHAR(10),GETDATE(),103)  
         ,   'Titulo'            = CASE WHEN @icdolar = 'N' THEN 'VENCIMIENTO VENTAS CON PACTO AL ' + CONVERT(CHAR(10),@fechavto,103)
					ELSE 'VENCIMIENTO VENTAS CON PACTO EN DOLARES AL ' + CONVERT(CHAR(10),@fechavto,103) END
	 ,   'Tipo' 		 = ''
	 ,   'orden'		 = @inorden
         ,   'FechaVctoc'        = ''
         ,   'FechaVctocc'       = ''
	 ,   'familia'		 = ''
	 ,   'numero_doc'	 = ''
	 ,   'vcto_papel'	 = ''
	 ,   'tasa_papel'	 = 0
	 ,   'tasa_trans'	 = 0

END

GO
