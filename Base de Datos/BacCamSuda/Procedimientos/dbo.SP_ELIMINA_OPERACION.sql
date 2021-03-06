USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ELIMINA_OPERACION]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ELIMINA_OPERACION] 
   (  @numope   NUMERIC(7) 
   ,  @usuario  CHAR(15) 
   )
AS
BEGIN

   SET NOCOUNT ON

   IF EXISTS( SELECT 1 FROM BacParamSuda..MDLBTR WHERE sistema = 'BCC' AND numero_operacion = @numope AND Estado_Paquete = 'A' )
   BEGIN
      SELECT -4, 'OPERACION NO SE PUEDE ANULAR... ES PARTE DE UN GRUPO DE PAGO.'
      RETURN
   END

   DECLARE @tipmer      CHAR(4)
   DECLARE @tipope      CHAR(1)
   DECLARE @codmon      CHAR(3)
   DECLARE @fecha       CHAR(8)
   DECLARE @tesoreria   CHAR(4)
   DECLARE @operacion   CHAR(3)
   DECLARE @estado      NUMERIC(3)
   DECLARE @linerut     NUMERIC(10)
   DECLARE @linecodigo  NUMERIC(10)
   DECLARE @linefpago   INTEGER
   DECLARE @linemonto   FLOAT
   DECLARE @ticam       NUMERIC(19,4)
   DECLARE @costofondo  NUMERIC(15,04)
   DECLARE @monmo       NUMERIC(19,4)
   DECLARE @ussme       NUMERIC(19,4)
   DECLARE @uss30dias   NUMERIC(19,4) 
   DECLARE @codcnv      CHAR(3)
   DECLARE @tctra       NUMERIC(19,4)
   DECLARE @parida      NUMERIC(19,8)
   DECLARE @partr       NUMERIC(19,8)
   DECLARE @oper_contra CHAR(1)   -- Operacione Inversa en Operaciones M/X-USD
   DECLARE @moterm      CHAR(15)
   DECLARE @monumfut    float
   DECLARE @morutcli    float

   SET @fecha = (SELECT CONVERT(CHAR(8),acfecpro,112) FROM MEAC)

   if ( select 1 from memo where monumope = @numope and moterm = 'CORREDORA' and morutcli = 97023000 and monumfut = 0 ) = 1
   BEGIN

	declare @monumope float
	declare @msg varchar(120)

	select @monumope=MONUMOPE from memo 
         where monumfut = @numope 
           and MOTIPMER = 'EMPR' and moestatus = ''
	
	if @monumope is null
	   set @msg = 'No se puede anular directamente las operaciones Corredora, anule la operaciÃ³n real EMPRESA relacionada'
	else
	   set @msg = 'No se puede anular directamente las operaciones Corredora, anule la operaciÃ³n real EMPRESA relacionada Nro.'+ convert(varchar, @monumope)

	select 1, @msg
	return
   END


   SELECT 'rutemisor'        = e.acrut,
          'codigoemisor'     = e.accodigo,
          'digchkemisor'     = e.acdv,
          'nombreemisor'     = e.acnombre,
          'rutcliente'       = morutcli,
          'digchkcliente'    = a.cldv,
          'nombrecliente'    = a.clnombre,
          'direccioncliente' = a.cldirecc,
          'fecharecibe'      = CONVERT(CHAR(10),movaluta2,103),
          'fechaentrega'     = CONVERT(CHAR(10),movaluta1,103),
          'montoopera'       = momonmo,
          'montousd'         = moussme,
          'montoclp'         = momonpe,
          'tipocamcie'       = moticam,
          'tipocamtra'       = motctra,
          'paricie'          = moparme,
          'paritra'          = mopartr,
          'parifin'          = moparfi,
          'modoimpreso'      = moimpreso,
          'monedaopera'      = d.mnglosa,
          'monedaconve'      = mocodcnv,
          'noopera'          = monumope,
          'tipoopera'        = motipope,
          'entregamos'       = b.glosa,
          'recibimos'        = c.glosa,
          'operador'         = mooper,
          'tipocamtrf'       = motcfin,
          'retiro'           = morecib,
          'monop'            = mocodmon,
          'tipomercado'      = CONVERT(CHAR(40),motipmer),
          'moneda'           = mocodmon,
          'estado'           = moestatus,
          'codigo_area'      = codigo_area
     INTO  #tempape
     FROM  MEMO
           INNER JOIN VIEW_CLIENTE       A ON a.clrut  = morutcli AND a.clcodigo = mocodcli
           INNER JOIN VIEW_FORMA_DE_PAGO B ON b.codigo = moentre
           INNER JOIN VIEW_FORMA_DE_PAGO C ON c.codigo = morecib
           INNER JOIN VIEW_MONEDA        D ON mocodmon = SUBSTRING(d.mnnemo, 1, 3)
        ,  MEAC                          E
    WHERE  monumope    = @numope                     

   UPDATE  #tempape 
      SET  tipomercado     = descripcion
     FROM  VIEW_PRODUCTO
    WHERE  noopera         = @numope  
      AND  codigo_producto = SUBSTRING(RTRIM(tipomercado),1,4)

	/*
	*	recuperamos operacion relacionada ccbb
	*/
      SELECT @monumfut = monumfut,
             @moterm   = moterm,
	     @morutcli = morutcli
     	FROM MEMO 
       WHERE monumope = @numope

   UPDATE  MEMO
      SET  moaprob         = motipope,
           moestatus       = 'A',
           anula_usuario   = @USUARIO,
           anula_fecha     = acfecpro,
           anula_hora      = CONVERT ( CHAR(10) , GETDATE(), 108 ),
           anula_motivo    = ''
     FROM  MEAC
    WHERE  monumope        = @numope



    /*
    *	Anula operacion ccbb sin asociar
    */
    IF @monumfut = 0 AND @moterm = 'CORREDORA' and @morutcli != 97023000
    BEGIN
	UPDATE MEMO
      	   SET moaprob         = motipope
           ,   moestatus       = 'A'
           ,   anula_usuario   = @USUARIO
           ,   anula_fecha     = ( SELECT acfecpro FROM MEAC )
           ,   anula_hora      = CONVERT ( CHAR(10) , GETDATE(), 108 )
	,   Observacion   = 'Anulación automatica Operacion Corredora.'
		WHERE monumope        = @numope 


	/*
	*	Se registra la anulación
	*/
	Insert TxOnlineCorredora 
		select 	FechaProceso,
			'',
			'',
			Id,
			Tipo,
			Monto,
			MONEDA,
			CotraMoneda,
			TipoCambio,
			Paridad,
			Precio,
			PrecioTransferencia,
			RutClienteFinal,
			DvClienteFinal,
			origen,
			Fecha,
			Entregamos,
			ValutaEntregamos,
			Recibimos,
			ValutaRecibimos,
			'A',
			TipoMercado,
			Filler
		   From TxOnlineCorredora
		  where Id = @numope 
	
		SELECT 0, 'OPERACION EMPRESA CANAL CORREDORA.' -- SALE POR QUE ESTAS OPERACIONES NO AFECTAN EN NINGUN PROCESO
		RETURN 0
    END


    /*
    *	Anula operacion ccbb relacionada a EMPR
    */
    IF @monumfut > 0 AND @moterm = 'EMPRESAS' and ( SELECT RTRIM( moterm ) FROM MEMO WHERE monumope = @monumfut AND moestatus = '' ) = 'CORREDORA' 
    BEGIN
	UPDATE MEMO
      	   SET moaprob         = motipope
           ,   moestatus       = 'A'
           ,   anula_usuario   = @USUARIO
           ,   anula_fecha     = ( SELECT acfecpro FROM MEAC )
           ,   anula_hora      = CONVERT ( CHAR(10) , GETDATE(), 108 )
	,   Observacion   = 'Anulación automatica Operacion Corredora.'
		WHERE monumope        = @monumfut 


	/*
	*	Se registra la anulación
	*/
	Insert TxOnlineCorredora 
		select 	FechaProceso,
			'',
			'',
			Id,
			Tipo,
			Monto,
			MONEDA,
			CotraMoneda,
			TipoCambio,
			Paridad,
			Precio,
			PrecioTransferencia,
			RutClienteFinal,
			DvClienteFinal,
			origen,
			Fecha,
			Entregamos,
			ValutaEntregamos,
			Recibimos,
			ValutaRecibimos,
			'A',
			TipoMercado,
			Filler
		   From TxOnlineCorredora
		  where Id = @monumfut 
	
		/*
		*	Desagrupa las operaciones ccbb que fueron asociadas a la operación (ccbb) de calce
		*/
		UPDATE MEMO SET monumfut = 0 where monumfut =  @monumfut and moterm = 'CORREDORA' and moestatus = ''

--		SELECT 0, 'OPERACION EMPRESA CANAL CORREDORA.' -- SALE POR QUE ESTAS OPERACIONES NO AFECTAN EN NINGUN PROCESO
--		RETURN 0
    END	

   DELETE VIEW_PLANILLA_SPT
    WHERE operacion_numero                     = @numope      
      AND CONVERT(CHAR(8),operacion_fecha,112) = @fecha

   /****   Elimina Operacion de Posicion ***/
   SELECT @tipmer     = motipmer,
          @tipope     = motipope,
          @ticam    = moticam,
          @monmo      = momonmo,
          @ussme      = moussme,
          @codmon     = mocodmon,
          @codcnv     = mocodcnv,
          @tctra      = motctra,
          @parida     = moparme,
          @partr      = mopartr,
          @uss30dias  = mouss30,
          @costofondo = mocostofo,
          @moterm     = moterm
   FROM   MEMO
   WHERE  monumope    = @numope

      SET @ussme       = @ussme * -1
      SET @monmo       = @monmo * -1
      SET @uss30dias   = @uss30dias * -1
      SET @oper_contra = CASE WHEN @tipope = 'C' THEN 'V' ELSE 'C' END

   IF @tipmer = 'EMPR' 
   BEGIN
	
      EXECUTE Sp_Recalc @codmon, @tipmer, @tipope, @costofondo, @uss30dias, @moterm
      IF @codcnv = 'USD'  -- Operaciones Empresas M/X-USD
      BEGIN
         EXECUTE Sp_Recalc @codmon,  @tipmer, @oper_contra , @CostoFondo , @ussme, @moterm
      END

      EXECUTE SP_RECALC_EMPRESAS @tipope 
                               , @ticam
                               , @ussme
                               , @codmon
                               , @codcnv
                               , @tctra
                               , @parida
                               , @partr
                               , @monmo            
   END ELSE
   BEGIN   
      EXECUTE Sp_Recalc @codmon, @tipmer, @tipope, @ticam, @uss30dias, @moterm

      IF @codcnv = 'USD'  -- Operaciones Puntas M/X-USD
      BEGIN
         EXECUTE Sp_Recalc @codmon,  @tipmer, @oper_contra , @ticam , @ussme, @moterm
      END
   END

   /*** Fin Eliminacion ***/
   SELECT 0, * FROM #TEMPAPE

   -- anulación en Pantalla de envio LBTR
   UPDATE BacParamSuda..MDLBTR
   SET    estado_envio     = 'A'
   WHERE  sistema          = 'BCC'
   AND    numero_operacion = @numope   

 EXECUTE cal_resumenMonedas   -- VB+- 06/07/2009 Calcula los porductos en linea 
   SET NOCOUNT OFF
END
GO
