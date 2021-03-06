USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_ImprimePapOverWeek]    Script Date: 16-05-2022 11:18:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_ImprimePapOverWeek]
      (      @NumOpe     NUMERIC(10)
         ,   @FECHA_X    CHAR(10) )
AS
BEGIN

SET TRANSACTION ISOLATION LEVEL READ COMMITTED
SET DATEFORMAT dmy
SET NOCOUNT ON 

DECLARE @FECHA DATETIME
SELECT @FECHA = CONVERT(DATETIME , @FECHA_X ,112)

   DECLARE @nNum_Opera   NUMERIC(10)
   ,       @cMargen_1    VARCHAR(100)
   ,       @cMargen_2    VARCHAR(100)
   ,       @cTraspaso_1  VARCHAR(100)
   ,       @cTraspaso_2  VARCHAR(100)
   ,       @cSobreGiro_1 VARCHAR(100)
   ,       @cSobreGiro_2 VARCHAR(100)
   ,	   @PrimerDia    DATETIME
   ,	   @lFlag	 INTEGER

   SELECT @nNum_Opera   = @NumOpe
   ,      @cMargen_1    = ' '
   ,      @cMargen_2    = ' '
   ,      @cTraspaso_1  = ' '
   ,      @cTraspaso_2  = ' '
   ,      @cSobreGiro_1 = ' '
   ,      @cSobreGiro_2 = ' '

   EXECUTE Sp_Papeletas_Mensajes_Lineas 
           @nNum_Opera
     ,     'BCC' 
     ,     @cMargen_1     OUTPUT
     ,     @cMargen_2     OUTPUT
     ,     @cTraspaso_1   OUTPUT
     ,     @cTraspaso_2   OUTPUT
     ,     @cSobreGiro_1  OUTPUT
     ,     @cSobreGiro_2  OUTPUT




IF @FECHA = (SELECT FECHA_PROCESO FROM VIEW_DATOS_GENERALES)
BEGIN



	IF EXISTS ( SELECT * FROM VIEW_MOVIMIENTO_CAMBIO WHERE monumope = @NumOpe )
	BEGIN


 	  SELECT 'RutEmisor'        = e.Rut_entidad
         ,	 'DigChkEmisor'     = e.Digito_entidad
         ,	 'NombreEmisor'     = e.Nombre_entidad
         ,	 'RutCliente'       = CONVERT(NUMERIC(10),morutcli)
         ,	 'DigChkCliente'    = a.cldv
         ,	 'NombreCliente'    = a.clnombre
         ,	 'DireccionCliente' = isnull(a.cldirecc,' ')
         ,       'teléfono'         = isnull(a.clfono,0)
         ,       'Fax'              = isnull(a.clfax,0)
         ,       'TipoCliente'      = isnull((SELECT descripcion FROM VIEW_TIPO_CLIENTE    WHERE CONVERT(INTEGER,codigo_tipo_cliente) = CONVERT(INTEGER,a.cltipcli) ),' ')
         ,	 'fechaRecibe'      = CONVERT(CHAR(10),movaluta2,103)
         ,	 'fechaEntrega'     = CONVERT(CHAR(10),movaluta1,103)
         ,	 'MontoOpera'       = isnull(momonmo,0)
         ,	 'MontoUSD'         = isnull(moussme,0)
         ,	 'MontoCLP'         = isnull(momonpe,0)
         ,	 'TipoCamCie'       = isnull(moticam,0)
         ,	 'TipoCamTra'       = isnull(motctra,0)
         ,	 'PariCie'          = isnull(moparme,0)
         ,	 'PariTra'          = isnull(mopartr,0)
         ,	 'PariFin'          = isnull(moparfi,0)
         ,	 'Modoimpreso'      = isnull(moimpreso,' ')
         ,	 'Moneda'           = isnull(mocodmon,' ')
         ,	 'MonedaOpera'      = isnull(d.mnglosa,' ')
         ,	 'MonedaConve'      = isnull(mocodcnv,' ')
         ,	 'MonedaConversion' = isnull(o.mnglosa,' ')
         ,	 'NoOpera'          = isnull(monumope,0)
         ,	 'TipoOpera'        = isnull(motipope,' ')
         ,	 'Entregamos'       = isnull(b.glosa,' ')
         ,	 'Recibimos'        = isnull(c.glosa,' ')
         ,       'Recibimos en'     = ' '
         ,       'Entregamos a'     = ' '
         ,       'Desde'            = ' '
         ,       'Plaza Recibimos'  = 0
         ,       'Plaza Entregamos' = 0
         ,       'Plaza Desde'      = 0
         ,	 'Operador'         = isnull(mooper,' ')
         ,	 'TipoCamTrF'       = isnull(motcfin,0)
         ,	 'Retiro'           = isnull(morecib,0)
         ,	 'TipoMercado'      = CONVERT(CHAR(40),motipmer)
         , 	 'Estado'           = CASE moestatus WHEN 'A' THEN 'ANULADA' ELSE CASE WHEN @FECHA_X > = CONVERT(CHAR(12),movaluta2,112) AND Motipmer = 'OVER' THEN 'VENCIDA' ELSE ' ' END END
         , 	 'Exceso_Settle'    = SPACE(50)
	 , 	 'mofech'	    = CONVERT(CHAR(12),mofech,103)
	 , 	 'hora  '	    = CONVERT(CHAR(08),GETDATE(),108)
	 ,       'sector'           = 0
         ,       'centrocosto'      = 0
         ,       'oficina'          = 0
         ,       'MONTO'            = isnull(momonmo,0)
         ,       'TASA'             = isnull(motctra,0)
         ,       'CASA_MATRIZ'      = isnull((SELECT nombre FROM VIEW_PAIS WHERE codigo_pais = casa_matriz),' ')
         ,       'CODIGO_AREA'      = isnull(M.codigo_area,' ')
         ,       'OBSERVACIONES'    = isnull(observacion,' ')
         ,       'fecha_emision'    = convert(char(10),getdate(),103)
         ,       'hora_operacion'   = convert(char(10),mohora,103)
        ,        'Margen_1'         = @cMargen_1
        ,        'Margen_2'         = @cMargen_2
        ,        'Traspaso_1'       = @cTraspaso_1
        ,        'Traspaso_2'       = @cTraspaso_2
        ,        'SobreGireo_1'     = @cSobreGiro_1
        ,        'SobreGireo_2'     = @cSobreGiro_2
	,	 'Plazo'	    = DATEDIFF(DAY,movaluta1,movaluta2)
	,	 'Monto_Usd'	    = isnull(mousstr,0)
	,	 'Interes'	    = (isnull(mousstr,0) - isnull(moussme,0))
	,	 'fecha_inicio'     = CONVERT(CHAR(10), mofech, 103)
	,	 'fecha_vcto'       = movaluta2 
	,	 'fecha_vcto_c'       = SPACE(10)
	,	 'codigo_recibe'    = morecib
        ,        'numfut'           = monumfut
     	INTO    #TEMPAPE
     	FROM    VIEW_MOVIMIENTO_CAMBIO    M
        ,       VIEW_CLIENTE A
        ,       VIEW_FORMA_DE_PAGO B
        ,       VIEW_FORMA_DE_PAGO C
        ,       VIEW_MONEDA D
        ,       VIEW_MONEDA O
        ,       VIEW_DATOS_GENERALES E
    	WHERE   monumope = @NumOpe
        AND   	morutcli = a.clrut
        AND   	mocodcli = a.clcodigo
        AND  	morecib  = c.codigo
        AND  	moentre  = b.codigo
        AND  	mocodmon = SUBSTRING(d.MnNemo,1,3)
      	AND  	mocodcnv = SUBSTRING(o.MnNemo,1,3)


   ---------------------<< Define Tipo de Mercado
   	UPDATE  #TEMPAPE
      	SET     TipoMercado     = DESCRIPCION
        FROM    VIEW_PRODUCTO
        ,       VIEW_MOVIMIENTO_CAMBIO
    	WHERE   monumope        = @NumOpe
        AND     codigo_producto = motipmer


      SELECT @PrimerDia = fecha_vcto 
      FROM #TEMPAPE

      WHILE (1 = 1)
      BEGIN

         EXECUTE Sp_FechaHabil @PrimerDia, 1, @lFlag OUTPUT

         IF @lFlag = 0  -- CUANDO NO ES FERIADO
         BEGIN
            BREAK
         END 

         SELECT @PrimerDia = DATEADD(d, -1, @PrimerDia)

      END


	UPDATE #TEMPAPE SET 	fecha_vcto_c = CONVERT(CHAR(10), @PrimerDia , 103)
			,	Plazo	    = DATEDIFF(DAY,fecha_inicio,@PrimerDia)

   	SELECT * FROM #TEMPAPE

   END ELSE

 	  SELECT 'RutEmisor'        = 0
         ,	 'DigChkEmisor'     = ''
         ,	 'NombreEmisor'     = ''
         ,	 'RutCliente'       = 0
         ,	 'DigChkCliente'    = ''
         ,	 'NombreCliente'    = ''
         ,	 'DireccionCliente' = ''
         ,       'teléfono'         = 0
         ,       'Fax'              = 0
         ,       'TipoCliente'      = ''
         ,	 'fechaRecibe'      = ''
         ,	 'fechaEntrega'     = ''
         ,	 'MontoOpera'       = 0
         ,	 'MontoUSD'         = 0
         ,	 'MontoCLP'         = 0
         ,	 'TipoCamCie'       = 0
         ,	 'TipoCamTra'       = 0
         ,	 'PariCie'          = 0
         ,	 'PariTra'          = 0
         ,	 'PariFin'          = 0
         ,	 'Modoimpreso'      = ''
         ,	 'Moneda'           = ''
         ,	 'MonedaOpera'      = ''
         ,	 'MonedaConve'      = ''
         ,	 'MonedaConversion' = ''
         ,	 'NoOpera'          = 0
         ,	 'TipoOpera'        = ''
         ,	 'Entregamos'       = ''
         ,	 'Recibimos'        = ''
         ,       'Recibimos en'     = ''
         ,       'Entregamos a'     = ''
         ,       'Desde'            = ''
         ,       'Plaza Recibimos'  = 0
         ,       'Plaza Entregamos' = 0
         ,       'Plaza Desde'      = 0
         ,	 'Operador'         = ''
         ,	 'TipoCamTrF'       = 0
         ,	 'Retiro'           = 0
         ,	 'TipoMercado'      = ''
         , 	 'Estado'           = ''
         , 	 'Exceso_Settle'    = SPACE(50)
	 , 	 'mofech'	    = ''
	 , 	 'hora  '	    = CONVERT(CHAR(08),GETDATE(),108)
	 ,       'sector'           = 0
         ,       'centrocosto'      = 0
         ,       'oficina'          = 0
         ,       'MONTO'            = 0
         ,       'TASA'             = 0
         ,       'CASA_MATRIZ'      = ''
         ,       'CODIGO_AREA'      = ''
         ,       'OBSERVACIONES'    = ''
         ,       'fecha_emision'    = CONVERT(CHAR(10),GETDATE(),103)
         ,       'hora_operacion'   = ''
         ,        'Margen_1'        = ''
         ,        'Margen_2'        = ''
         ,        'Traspaso_1'      = ''
         ,        'Traspaso_2'      = ''
         ,        'SobreGireo_1'    = ''
         ,        'SobreGireo_2'    = ''
	 ,	  'Plazo'	    = 0
	 ,	  'Monto_Usd'	    = 0
	 ,	  'Interes'	    = 0
	,	 'fecha_inicio'     = ''
	,	 'fecha_vcto'       = ''
	,	 'fecha_vcto_c'     = ''
	,	 'codigo_recibe'    = 0
        ,        'numfut'           = 0.0
END ELSE
BEGIN

	IF EXISTS ( SELECT * FROM VIEW_MOVIMIENTO_CAMBIO WHERE monumope = @NumOpe )
	BEGIN


 	  SELECT 'RutEmisor'        = e.Rut_entidad
         ,	 'DigChkEmisor'     = e.Digito_entidad
         ,	 'NombreEmisor'     = e.Nombre_entidad
         ,	 'RutCliente'       = morutcli
         ,	 'DigChkCliente'    = a.cldv
         ,	 'NombreCliente'    = a.clnombre
         ,	 'DireccionCliente' = isnull(a.cldirecc,' ')
         ,       'teléfono'         = isnull(a.clfono,0)
         ,       'Fax'              = isnull(a.clfax,0)
         ,       'TipoCliente'      = isnull((SELECT descripcion FROM VIEW_TIPO_CLIENTE    WHERE CONVERT(INTEGER,codigo_tipo_cliente) = CONVERT(INTEGER,a.cltipcli) ),' ')
         ,	 'fechaRecibe'      = CONVERT(CHAR(10),movaluta2,103)
         ,	 'fechaEntrega'     = CONVERT(CHAR(10),movaluta1,103)
         ,	 'MontoOpera'       = isnull(momonmo,0)
         ,	 'MontoUSD'         = isnull(moussme,0)
         ,	 'MontoCLP'         = isnull(momonpe,0)
         ,	 'TipoCamCie'       = isnull(moticam,0)
         ,	 'TipoCamTra'       = isnull(motctra,0)
         ,	 'PariCie'          = isnull(moparme,0)
         ,	 'PariTra'          = isnull(mopartr,0)
         ,	 'PariFin'          = isnull(moparfi,0)
         ,	 'Modoimpreso'      = isnull(moimpreso,' ')
         ,	 'Moneda'           = isnull(mocodmon,' ')
         ,	 'MonedaOpera'      = isnull(d.mnglosa,' ')
         ,	 'MonedaConve'      = isnull(mocodcnv,' ')
         ,	 'MonedaConversion' = isnull(o.mnglosa,' ')
         ,	 'NoOpera'          = isnull(monumope,0)
         ,	 'TipoOpera'        = isnull(motipope,' ')
         ,	 'Entregamos'       = isnull(b.glosa,' ')
         ,	 'Recibimos'        = isnull(c.glosa,' ')
         ,       'Recibimos en'     = ' '
         ,       'Entregamos a'     = ' '
         ,       'Desde'            = ' '
         ,       'Plaza Recibimos'  = 0
         ,       'Plaza Entregamos' = 0
         ,       'Plaza Desde'      = 0
         ,	 'Operador'         = isnull(mooper,' ')
         ,	 'TipoCamTrF'       = isnull(motcfin,0)
         ,	 'Retiro'           = isnull(morecib,0)
         ,	 'TipoMercado'      = CONVERT(CHAR(40),motipmer)
         , 	 'Estado'           = CASE moestatus WHEN 'A' THEN 'ANULADA' ELSE CASE WHEN @FECHA_X > = CONVERT(CHAR(12),movaluta2,112) AND Motipmer = 'OVER' THEN 'VENCIDA' ELSE ' ' END END
         , 	 'Exceso_Settle'    = SPACE(50)
	 , 	 'mofech'	    = CONVERT(CHAR(12),mofech,103)
	 , 	 'hora  '	    = CONVERT(CHAR(08),GETDATE(),108)
	 ,       'sector'           = 0
         ,       'centrocosto'      = 0
         ,       'oficina'          = 0
         ,       'MONTO'            = isnull(momonmo,0)
         ,       'TASA'             = isnull(motctra,0)
         ,       'CASA_MATRIZ'      = isnull((SELECT nombre FROM VIEW_PAIS WHERE codigo_pais = casa_matriz),' ')
         ,       'CODIGO_AREA'      = isnull(M.codigo_area,' ')
         ,       'OBSERVACIONES'    = isnull(observacion,' ')
         ,       'fecha_emision'    = convert(char(10),getdate(),103)
         ,       'hora_operacion'   = convert(char(10),mohora,103)
         ,       'Margen_1'         = ' '
         ,       'Margen_2'         = ' '
         ,       'Traspaso_1'       = ' '
         ,       'Traspaso_2'       = ' '
         ,       'SobreGireo_1'     = ' '
         ,       'SobreGireo_2'     = ' '
	,	 'Plazo'	    = DATEDIFF(DAY,movaluta1,movaluta2)
	,	 'Monto_Usd'	    = isnull(mousstr,0)
	,	 'Interes'	    = (isnull(mousstr,0) - isnull(moussme,0))
	,	 'fecha_inicio'     = CONVERT(CHAR(10), mofech, 103)
	,	 'fecha_vcto'       = movaluta2 --(movaluta2 - c.diasvalor)
	,	 'fecha_vcto_c'     = space(10)
	,	 'codigo_recibe'    = morecib
        ,        'numfut'           = monumfut
     	INTO    #TEMPAPE1
     	FROM    VIEW_MOVIMIENTO_CAMBIO M
        ,       VIEW_CLIENTE A
        ,       VIEW_FORMA_DE_PAGO B
        ,       VIEW_FORMA_DE_PAGO C
        ,       VIEW_MONEDA D
        ,       VIEW_MONEDA O
        ,       VIEW_DATOS_GENERALES E
    	WHERE   monumope = @NumOpe
        AND   	morutcli = a.clrut
        AND   	mocodcli = a.clcodigo
        AND  	morecib  = c.codigo
        AND  	moentre  = b.codigo
        AND  	mocodmon = SUBSTRING(d.MnNemo,1,3)
      	AND  	mocodcnv = SUBSTRING(o.MnNemo,1,3)

   ---------------------<< Define Tipo de Mercado
   	UPDATE  #TEMPAPE1
      	SET     TipoMercado     = DESCRIPCION
        FROM    VIEW_PRODUCTO
        ,       VIEW_MOVIMIENTO_CAMBIO
    	WHERE   monumope        = @NumOpe
        and     codigo_producto = motipmer

      SELECT @PrimerDia = fecha_vcto 
      FROM #TEMPAPE1

      WHILE (1 = 1)
      BEGIN

         EXECUTE Sp_FechaHabil @PrimerDia, 1, @lFlag OUTPUT

         IF @lFlag = 0  -- CUANDO NO ES FERIADO
         BEGIN
            BREAK
         END 

         SELECT @PrimerDia = DATEADD(d, -1, @PrimerDia)

      END

	UPDATE #TEMPAPE1 SET 	fecha_vcto_c = CONVERT(CHAR(10), @PrimerDia , 103)
			,	Plazo	    = DATEDIFF(DAY,fecha_inicio,@PrimerDia)


   	SELECT * FROM #TEMPAPE1

END ELSE

	SELECT   'RutEmisor'        = 0
     ,	 'CodigoEmisor'     = 0
        , 	 'DigChkEmisor'     = ''
        , 	 'NombreEmisor'     = ''
        , 	 'RutCliente'       = 0
        , 	 'DigChkCliente'    = ''
        , 	 'NombreCliente'    = ''
        , 	 'DireccionCliente' = ''
        , 	 'fechaRecibe'      = ''
        , 	 'fechaEntrega'     = ''
        , 	 'MontoOpera'       = 0
        , 	 'MontoUSD'         = 0
        , 	 'MontoCLP'         = 0
        , 	 'TipoCamCie'       = 0
        , 	 'TipoCamTra'       = 0
        , 	 'PariCie'          = 0
        , 	 'PariTra'          = 0
        , 	 'PariFin'          = 0
        , 	 'Modoimpreso'      = ''
        , 	 'Moneda'           = ''
        , 	 'MonedaOpera'      = ''
        , 	 'MonedaConve'      = ''
        , 	 'MonedaConversion' = ''
        , 	 'NoOpera'          = 0
        , 	 'TipoOpera'        = ''
        , 	 'Entregamos'       = ''
        , 	 'Recibimos'        = ''
        , 	 'Operador'         = ''
        , 	 'TipoCamTrF'       = 0
        , 	 'Retiro'           = 0
        , 	 'TipoMercado'      = ''
        ,  	 'Estado'           = ''
        ,  	 'Exceso_Settle'    = ''
	,  	 'mofech'	    = ''
	,  	 'hora  '	    = CONVERT(CHAR(08),GETDATE(),108)
        ,        'MONTO'            = 0
        ,        'TASA'             = 0
        ,        'CASA_MATRIZ'      = 0
        ,        'CODIGO_AREA'      = ''
        ,        'OBSERVACIONES'    = ''
        ,        'fecha_emision'    = convert(char(10),getdate(),103)
        ,        'hora_operacion'   = ''
        ,        'Margen_1'         = ''
        ,        'Margen_2'         = ''
        ,        'Traspaso_1'       = ''
        ,        'Traspaso_2'       = ''
        ,        'SobreGireo_1'     = ''
        ,        'SobreGireo_2'     = ''
	,	 'Plazo'	    = 0
	,	 'Monto_Usd'	    = 0
	,	 'Interes'	    = 0
	,	 'fecha_inicio'     = ''
	,	 'fecha_vcto'       = ''
	,	 'fecha_vcto_c'     = ''
	,	 'codigo_recibe'    = 0
        ,        'numfut'           = 0.0
END
END

GO
