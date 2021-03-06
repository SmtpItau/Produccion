USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Vencimientos_FPD]    Script Date: 16-05-2022 11:18:12 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_Vencimientos_FPD]
   (   @xfechapro       CHAR(10)
   ,   @xfechavto       CHAR(10)
   )
AS
BEGIN
    SET DATEFORMAT dmy

   DECLARE   @fechapro         DATETIME
         ,   @fechavto         DATETIME
   SELECT    @fechapro       = CONVERT(DATETIME,@xfechapro,112)
         ,   @fechavto       = CONVERT(DATETIME,@xfechavto,112)     
 
   DECLARE  @acfecproc	      CHAR(10)
	,   @acfecprox	      CHAR(10)
	,   @uf_hoy	      FLOAT
	,   @uf_man	      FLOAT
	,   @ivp_hoy	      FLOAT
	,   @ivp_man	      FLOAT
	,   @do_hoy	      FLOAT
	,   @do_man	      FLOAT
	,   @da_hoy	      FLOAT
	,   @da_man	      FLOAT
	,   @acnomprop	      CHAR(40)
	,   @rut_empresa      CHAR(12)
	,   @nRutemp	      NUMERIC(09,0)
	,   @hora	      CHAR(08)
	,   @paso	      CHAR(01)
        ,   @fecha_busqueda   DATETIME  

   SELECT   @fecha_busqueda = (SELECT Fecha_Proceso FROM VIEW_DATOS_GENERALES)

   EXECUTE  Sp_Base_Del_Informe
	    @acfecproc	   OUTPUT
	,   @acfecprox	   OUTPUT
	,   @uf_hoy	   OUTPUT
	,   @uf_man	   OUTPUT
	,   @ivp_hoy	   OUTPUT
	,   @ivp_man	   OUTPUT
	,   @do_hoy	   OUTPUT
	,   @do_man	   OUTPUT
	,   @da_hoy	   OUTPUT
	,   @da_man	   OUTPUT
	,   @acnomprop	   OUTPUT
	,   @rut_empresa   OUTPUT
	,   @hora	   OUTPUT
        ,   @fecha_busqueda

   SET @PASO = 'N'





   IF EXISTS (SELECT 1 FROM CARTERA_INTERBANCARIA WHERE Fecha_Vencimiento_Pacto <= @fechavto)
   BEGIN

      SELECT 'NumeroDocumento'   = ISNULL(Numero_Documento,0)
         ,   'Serie'             = ISNULL((SELECT descripcion FROM VIEW_PRODUCTO WHERE codigo_producto = ISNULL(Serie,'')),'')
         ,   'ValorNominal'      = ISNULL(nominal,0)
         ,   'ValorInicial'      = isnull(Valor_Compra_UM,0)--ISNULL(Valor_Inicialum,0)
         ,   'ValorFinal'        = ISNULL(Valor_vencimiento,0)
         ,   'TasaPacto'         = ISNULL(Tasa_Pacto,0)
         ,   'MonedaPacto'       = ISNULL((SELECT mnnemo FROM VIEW_MONEDA        WHERE Moneda_Pacto = mncodmon),' ')   
         ,   'FormaPago_I'       = ISNULL((SELECT glosa  FROM VIEW_FORMA_DE_PAGO WHERE Forma_Pago_Inicio = codigo),' ')
         ,   'FormaPago_V'       = ISNULL((SELECT glosa  FROM VIEW_FORMA_DE_PAGO WHERE Forma_Pago_vencimiento = codigo),' ')
         ,   'FechaVcto'         = CONVERT(CHAR(10),Fecha_Vencimiento_Pacto,103)
         ,   'Fechainicio'       = CONVERT(CHAR(10),Fecha_Inicio_Pacto,103)
         ,   'Plazo'             = DATEDIFF(DD,Fecha_Inicio_Pacto,Fecha_Vencimiento_Pacto)
         ,   'Cliente'           = ISNULL((SELECT clnombre FROM VIEW_CLIENTE WHERE clrut = Rut_Cliente AND clcodigo= Codigo_Cliente),'NO EXISTE CLIENTE')
         ,   'mascara'           = ISNULL(Mascara,'')
         ,   'FechaTitulo'       = @fechavto
         ,   'fecproc'	         = @acfecproc
         ,   'fecprox'	         = @acfecprox
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
         ,   'Titulo'            = 'VENCIMIENTO FACILIDAD PERMANENTE DE DEPOSITO'
         ,   'TITULO2'           = 'DESDE EL ' +CONVERT(CHAR(10),@FECHAPRO,103) + ' HASTA EL ' + CONVERT(CHAR(10),@fechavto,103)
         ,   'FechaProceso'      = CONVERT(CHAR(10),(SELECT Fecha_Proceso FROM VIEW_DATOS_GENERALES),103)
	 ,   'fecha_venc'	 = Fecha_Vencimiento_Pacto

      FROM   CARTERA_INTERBANCARIA
      WHERE  Fecha_Vencimiento_Pacto <= @fechavto
		and Codigo_Subproducto = 'FPD'

      SET @PASO = 'S'

    END ELSE BEGIN

     IF EXISTS (SELECT 1 FROM CARTERA_HISTORICA_TRADER WHERE tipoper = 'FPD' AND fecvenp <= @fechavto)-- AND @fechapro = fecha_proceso)
   BEGIN
      SELECT 'NumeroDocumento'   = ISNULL(numoper,0)
         ,   'Serie'             = ISNULL(instser,'')
         ,   'ValorNominal'      = ISNULL(nominal,0)
         ,   'ValorInicial'      = isnull(valcomu,0)--ISNULL(valinip,0)
         ,   'ValorFinal'        = ISNULL(valvenc,0) 
         ,   'TasaPacto'         = ISNULL(taspact,0)
         ,   'MonedaPacto'       = ISNULL((SELECT mnnemo   FROM VIEW_MONEDA        WHERE monpact = mncodmon),' ')   
         ,   'FormaPago_I'       = ISNULL((SELECT glosa    FROM VIEW_FORMA_DE_PAGO WHERE forpagi = codigo),' ')
         ,   'FormaPago_V'       = ISNULL((SELECT glosa    FROM VIEW_FORMA_DE_PAGO WHERE forpagv = codigo),' ')
         ,   'FechaVcto'         = CONVERT(CHAR(10),fecvenp,103)
         ,   'Fechainicio'       = CONVERT(CHAR(10),fecinip,103)
         ,   'Plazo'             = DATEDIFF(DD,fecinip,fecvenp)
         ,   'Cliente'           = ISNULL((SELECT clnombre FROM VIEW_CLIENTE WHERE clcodigo = codcli AND rutcli = clrut),'NO EXISTE CLIENTE')
         ,   'mascara'           = ISNULL(mascara,'')
         ,   'FechaTitulo'       = @fechavto
         ,   'fecproc'	         = @acfecproc
         ,   'fecprox'	         = @acfecprox
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
         ,   'Titulo'            = 'VENCIMIENTO FACILIDAD PERMANENTE DE DEPOSITO'
         ,   'TITULO2'           = 'DESDE EL ' +CONVERT(CHAR(10),@FECHAPRO,103) + ' HASTA EL ' + CONVERT(CHAR(10),@fechavto,103)
         ,   'FechaProceso'      = CONVERT(CHAR(10),(SELECT Fecha_Proceso FROM VIEW_DATOS_GENERALES),103)
	 ,   'fecha_venc'	 = fecvenp

   FROM   CARTERA_HISTORICA_TRADER
   WHERE  fecvenp   <= @fechavto
	AND tipoper = 'FPD'    

   SET @PASO = 'S'

END

END

IF @PASO = 'N'

      SELECT 'NumeroDocumento'   = '' 
         ,   'Serie'             = '' 
         ,   'ValorNominal'      = '' 
         ,   'ValorInicial'      = '' 
         ,   'ValorFinal'        = '' 
         ,   'TasaPacto'         = '' 
         ,   'MonedaPacto'       = '' 
         ,   'FormaPago_I'       = '' 
         ,   'FormaPago_V'       = '' 
         ,   'FechaVcto'         = '' 
         ,   'Fechainicio'       = '' 
         ,   'Plazo'             = '' 
         ,   'Cliente'           = '' 
         ,   'mascara'           = '' 
         ,   'FechaTitulo'       = @fechavto
         ,   'fecproc'	         = @acfecproc
         ,   'fecprox'	         = @acfecprox
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
         ,   'Titulo'            = 'VENCIMIENTO FACILIDAD PERMANENTE DE DEPOSITO'
         ,   'TITULO2'           = 'DESDE EL ' +CONVERT(CHAR(10),@FECHAPRO,103) + ' HASTA EL ' + CONVERT(CHAR(10),@fechavto,103)
         ,   'FechaProceso'      = CONVERT(CHAR(10),(SELECT Fecha_Proceso FROM VIEW_DATOS_GENERALES),103)
	 ,   'fecha_venc'	 = ''

END


GO
