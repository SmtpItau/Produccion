USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PAPELETARIC]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_PAPELETARIC]
                         ( @xNumeroOperacion     NUMERIC(10))
AS BEGIN
SET NOCOUNT ON

DECLARE @mtoesc             CHAR (170)
DECLARE @TotalC             FLOAT
DECLARE @Tipcli             INTEGER
DECLARE @tipo_Operacion     CHAR(3)
DECLARE @ControlLimites     CHAR(250)
DECLARE @ControlPrecio      CHAR(250)
------------------------------------------------------------------------------------------------------------
Set RowCount 1 
------------------------------------------------------------------------------------------------------------
     /*SELECT @ControlLimites = ''
     SELECT @ControlLimites = ''**  Control de Limites  ** '' + ISNULL(rtrim(view_usuario.nombre),'''') + Char(13)
       FROM view_control_limites      
  Inner JOIN view_usuario              ON view_usuario.usuario      = Trader_Autorizador 
      WHERE NUMERO_OPERACION = @xNumeroOperacion
*/

	SELECT @ControlLimites = ''
	SELECT @ControlLimites = '**  Control de Limites  ** ' + ISNULL(rtrim(usr.nombre),'') + Char(13)
	FROM	baclineas..DETALLE_APROBACIONES	with(nolock)
			INNER JOIN BacParamSuda..USUARIO AS usr ON
				usr.usuario      = Operador_Autoriza
	WHERE   Id_Sistema = 'BTR'
	AND     Numero_Operacion		= @xNumeroOperacion

/*
     SELECT @ControlPrecio  = ''''
     SELECT @ControlPrecio  = ''**  Control Interes por Pagar ** ''  + ISNULL(rtrim(view_usuario.nombre),'''') 
       FROM VIEW_CONTROL_LIMITES_GENERALES as a
 INNER JOIN view_usuario              ON view_usuario.usuario      = Trader_Autorizador 
      WHERE Tipo_Operacion = ''RI''    And Codigo_Tipo_Limite = 6
        and Codigo_limite      = 1   And NUMERO_OPERACION   = @xNumeroOperacion
*/
------------------------------------------------------------------------------------------------------------
Set RowCount 0
------------------------------------------------------------------------------------------------------------
    SELECT mofecpro         , morutcart    , monumdocu    , mocorrela   , monumoper   , motipoper
         , movpresen        , MOTIR        , mofecinip    , mofecvenp   , monominal   , movalvenp
         , morutcli         , mocodcli     , motipret     , mohora      , mousuario   , moterminal
         , Tipo_Deposito    , momonpact    , mostatreg    , mocorrelao  , moobserv    , mobasemi
         , moforpagi        , Ejecutivo    , Sucursal     , Fecha_PagoMañana , Condicion_Captacion
         , morutContraparte  , mocodcontraparte,moclave_dcv,numero_certificado_dcv,ISNULL(acnomprop,'ITAU-CORPBANCA') as acnomprop
         
          
    INTO #tmp_mdmo
    FROM Mdmo
		LEFT JOIN MDAC ON
			acrutprop = morutcart  
     WHERE motipoper  = 'RIC' AND monumoper  = @xnumerooperacion --AND Mostatreg <> 'A'
    UNION 
    SELECT mofecpro         , morutcart    , monumdocu    , mocorrela   , monumoper   , motipoper
         , movpresen        , MOTIR        , mofecinip    , mofecvenp   , monominal   , movalvenp
         , morutcli         , mocodcli     , motipret     , mohora      , mousuario   , moterminal
         , Tipo_Deposito    , momonpact    , mostatreg    , mocorrelao  , moobserv    , mobasemi
         , moforpagi        , Ejecutivo    , Sucursal     , Fecha_PagoMañana , Condicion_Captacion          
         , morutContraparte  , mocodcontraparte,moclave_dcv,numero_certificado_dcv,ISNULL(acnomprop,'ITAU-CORPBANCA') as acnomprop
    FROM Mdmh
    	LEFT JOIN MDAC ON
			acrutprop = morutcart
     WHERE motipoper  = 'RIC' AND monumoper  = @xnumerooperacion --AND Mostatreg <> 'A'



--''FAS 02/03/2009 RESCATE DE DAP BANCO EMISOR Y RECOMPRA ANTICIPADA DE DEPÓSITOS 

    SELECT 'Fecpro'    = CONVERT(CHAR(10),mofecpro,103)          --Fecha de Operación(1)  
         , 'Rutcart'   = RTRIM(LTRIM(STR(morutcart))+'-'+rcdv)  --Rut de Catera(2)  
         , monumdocu                                         --Numero de Documento(3)  
         , mocorrela                                         --Correlativo Operación(4)  
         , monumoper                                         --Numero de Operación(5)  
         , motipoper                                         --Tipo de Operación(6)  
         , monominal										 --Nominal(7)  
        , movpresen											 --Valor Inicio $$(8)  
         , 'Tasa'    = ISNULL(Tasa,MOTIR)                    --Tasa Captación(9)  
         , 'Tasa_tran'   = ISNULL(MOTIR,Tasa_tran)               --Tasa Transferencia(10)  
         , 'FechaIni'   = CONVERT(CHAR(10),mofecinip,103)       --Fecha de Inicio(11)  
         , 'FechaVcto'   = CONVERT(CHAR(10),mofecvenp,103)      --Fecha de Vencimiento(12)  
         , 'plazo'    = DATEDIFF(DAY,mofecinip,mofecvenp)        --Plazo(13)  
         , 'Inicio'    = monominal                             --Valor Inicio(14)  
         , movalvenp                                        --Valor Final(15)  
         , 'monpact'   = mnnemo                                 --Moneda de la Operación(16)  
         , 'forpagini'   = glosa                                --Forma pago Inicio(17)  
         , 'Rutcliente'   = Isnull(morutcli,0)                 --Rut de Cliente(18)  
         , 'dvcl'    = Isnull('-'+cliente.cldv,' ')  
         , mocodcli                                         --Codigo de Cliente(19)  
         , 'motipret'   = CASE motipret WHEN 'R' THEN 'RETENER' ELSE 'ENTREGAR' END   --Tipo de Retiro(20)  
         , 'custodia'   = CASE Custodia WHEN 'P' THEN 'PROPIA'  WHEN 'C' THEN 'CLIENTE' ELSE 'DCV' END--Custodia(21)  
         , mohora                                           --Hora de la Operación(22)  
         , mousuario                                        --Usuario(23)  
         , moterminal                                       --Terminal(24)   
         , 'tipodep'   = CASE #tmp_mdmo.Tipo_Deposito WHEN 'R' THEN 'RENOVABLE' ELSE 'FIJO' END --Tipo de Deposito(25)  
         , 'nomentidad'   = rcnombre                            --Nombre Entidad(26)  
         , 'nomcliente'   = cliente.clnombre                            --Nombre del Cliente(27)  
         , 'Direccion'   = cliente.Cldirecc  
         , 'Fono'    = cliente.Clfono  
         , 'Fax'    = cliente.Clfax  
         , 'GlTipoCli'   = tbglosa --a.descripcion   
         , 'As400'    = ISNULL(cliente.Codigo_As400 ,'0')  
         , 'CodigoDCV'   = ISNULL(moclave_dcv ,'')    
         , 'CuentaDCV'   = ISNULL(GEN_CAPTACION.numero_certificado_dcv,#tmp_mdmo.numero_certificado_dcv)  
         , 'ValorMoneda'  = CASE momonpact WHEN 999 THEN 1 ELSE ISNULL(vmvalor,0) END --Valor Unidad Monetaria   
         , mostatreg   
         , 'CantCortes'   = 1  
         , mocorrelao   -- Correlativo de Cortes    
         , 'TotalOpe'   = (CASE mnnemo WHEN 'USD' THEN monominal ELSE movpresen END)  
         , 'Condicion'   = CASE #tmp_mdmo.Condicion_Captacion WHEN 'E' THEN 'ENDOSABLE' ELSE 'NOMINATIVO' END  
         , 'Ejecutivo'   = ''--generico  
         , 'Sucursal'   = ISNULL(VIEW_SUCURSAL.nombre,mousuario)  
         , 'Observa'   = moobserv  
         , 'DiaPago'   = CONVERT(CHAR(10),Fecha_PagoMañana,103)  
         , 'montof'    = 1-- ISNULL(monto_final,movalvenp)  
         , 'Autorizador'  = Ltrim(Rtrim(@ControlLimites)) --+ @ControlPrecio    
         , 'fecha_inicio'  = ISNULL(fecha_origen,MOFECPRO)  
         , 'base'    = mobasemi  
         , 'certificado_dcv' = ISNULL(GEN_CAPTACION.numero_certificado_dcv,#tmp_mdmo.numero_certificado_dcv)          
         , 'rut_contraparte' = ISNULL(morutContraparte,0)   
         , 'cldvContra'   = Isnull('-'+ cli.cldv,' ')  
         , 'cod_contraparte' =  mocodcontraparte  
         , 'razonSocialContra' = cli.clnombre   
         , 'valor_recompra'  = ISNULL(valor_recompra,movalvenp)
         , 'acnomprop'    = acnomprop
      INTO #TEMP2  
      FROM #tmp_mdmo  
  LEFT JOIN GEN_CAPTACION             ON monumoper                 = numero_operacion          AND mocorrela = correla_operacion And mocorrelao = correla_corte   
  LEFT JOIN VIEW_CLIENTE  as cliente  ON morutcli                  = cliente.clrut             AND mocodcli  = cliente.clcodigo   
  --LEFT JOIN VIEW_TIPO_CLIENTE   AS A  ON CLtipcli                  = CONVERT(INTEGER,a.codigo)   
  LEFT JOIN TABLA_GENERAL_DETALLE  ON   
   tbcateg = 72  
   AND tbcodigo1 = CLtipcli  
  LEFT JOIN VIEW_ENTIDAD              ON morutcart                 = rcrut    
  LEFT JOIN VIEW_MONEDA               ON momonpact                 = mncodmon     
  LEFT JOIN VIEW_FORMA_DE_PAGO        ON VIEW_FORMA_DE_PAGO.codigo = moforpagi  
  LEFT JOIN view_ejecutivo            ON VIEW_EJECUTIVO.codigo     = Ejecutivo  
  LEFT JOIN VIEW_VALOR_MONEDA         ON mofecpro                  = vmfecha                   AND momonpact = vmcodigo       
  LEFT JOIN VIEW_SUCURSAL             ON codigo_sucursal           = #tmp_mdmo.sucursal  
  LEFT JOIN view_cliente cli    ON morutContraparte    = cli.clrut AND mocodcontraparte  = cli.clcodigo  
 ORDER BY mocorrela  
         , mocorrelao  


	UPDATE #TEMP2 SET TotalOpe = ROUND(valor_recompra*ValorMoneda,0)
	WHERE monpact <> 'USD'

   SET ROWCOUNT 1
   Select @TotalC = SUM(TotalOpe) From #Temp2
   SET ROWCOUNT 0
   EXECUTE dbo.sp_Montoescrito @TotalC, @Mtoesc OUTPUT

   select 'Fecpro'         = (Fecpro),
          'Rutcart'        = (Rutcart), 
          'monumdocu'      = (monumdocu),
          'mocorrela'      = (mocorrela),
          'monumoper'      = (monumoper),
          'motipoper'      = (motipoper), 
          'monominal'      = (monominal),
          'movpresen'      = CASE WHEN monpact = 'USD' THEN monominal ELSE (monominal*ValorMoneda) END, -- jcamposd(movpresen),
          'Tasa'           = (Tasa)     ,
          'Tasa_tran'      = (Tasa_tran),
          'FechaIni'       = (FechaIni)  ,
          'FechaVcto'      = (FechaVcto) ,
          'plazo'          = (plazo)     ,
          'movalini'       = (Inicio)    ,
          'movalvenp'      = (movalvenp) ,
          'monpact'        = (monpact) ,
          'forpagini'      = (forpagini) ,
          'Rutcliente'     = (rtrim(Ltrim(Rutcliente))+Dvcl),
          'Dvcl'           = (Dvcl),
          'mocodcli'       = (mocodcli)   ,
          'motipret'       = (motipret)   ,
          'custodia'       = (custodia)  ,
          'mohora'         = (mohora)    ,
          'mousuario'      = (mousuario) ,
          'moterminal'     = (moterminal) ,
          'tipodep'        = (tipodep)   ,
          'nomentidad'     = (nomentidad) ,
          'nomcliente'     = (nomcliente) ,
          'ValorMoneda'    = (ValorMoneda) ,
          'mostatreg'      = (mostatreg),
          'cantcortes'     = (CantCortes),
          'Inical$$'       = CASE WHEN monpact = 'USD' THEN (monominal * CantCortes) ELSE ((valor_recompra*ValorMoneda)*CantCortes) END,  -- jcamposd(movpresen * CantCortes),
          'FinalUm'        = Round(monominal*CantCortes,2),--jcamposd --Round(montof*CantCortes,2),  --MIN(Round(CantCortes * movalvenp,2)),
          'mocorrelao'     = (mocorrelao),
          'TotalOpe'       = (TotalOpe),
          'MontoEsc'       = @Mtoesc,
          'Condicion'      = (Condicion),
          'Ejecutivo'      = (Ejecutivo),
          'Sucursal'       = (Sucursal),
          'GlTipoCli'      = (GlTipoCli),
           'As400'         = (As400),
          'CodigoDCV'      = (CodigoDCV),
          'CuentaDCV'      = (CuentaDCV),
          'Direccion'      = (Direccion),
          'Fono'           = (Fono),
          'Fax'            = (Fax),
          'Observa'        = (Observa),
          'DiaPago'        = (DiaPago),
          'Autorizador'    = (Autorizador),
          'FechaInicio'    = (convert(char(12),fecha_inicio,103)),
          'base'           = (base),
          'TITULO'         = CASE WHEN Mostatreg = 'A' THEN 'ANULACION CAPTACION' ELSE 'RECOMPRA CAPTACION' END,
          'certificado_dcv'= certificado_dcv,
          'rut_contraparte'= rtrim(Ltrim(rut_contraparte))+(cldvContra),
          'cod_contraparte'= cod_contraparte,
          'razonSocialContra'= razonSocialContra
          ,'valor_recompra'  = ISNULL(valor_recompra,0)
          ,'acnomprop'		 = acnomprop
     from #temp2
 Order by mocorrelao
        , monominal 
        , movpresen 
        , Tasa      
        , Tasa_tran 
        , movalvenp  
        , monpact  
        , mostatreg 
        , TotalOpe 

   SET NOCOUNT OFF


END
GO
