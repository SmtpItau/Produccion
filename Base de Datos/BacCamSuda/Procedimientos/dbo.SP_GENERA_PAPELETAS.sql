USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GENERA_PAPELETAS]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- EXEC SP_GENERA_PAPELETAS '900254', 0

CREATE PROCEDURE [dbo].[SP_GENERA_PAPELETAS]( @Numero  CHAR(9)  
                                 , @Recibe  INTEGER )  
AS  
BEGIN   
  
DECLARE @NumOper NUMERIC(10)  
 SELECT @NumOper = CONVERT(NUMERIC(10),@Numero)  
  
/******************************************************************/  
DECLARE        @Firma1 char(15)  
DECLARE        @Firma2 char(15)   
DECLARE        @sMooper char(15)  
DECLARE        @sMoterm char(15)   
  
DECLARE @xMensajeBloqueos			VARCHAR(100)
	SET @xMensajeBloqueos				= ISNULL(( SELECT Mensaje_Error FROM BacLineas.dbo.LINEA_TRANSACCION_DETALLE
												WHERE Id_Sistema = 'BCC' AND NumeroOperacion = @Numero
												AND Error = 'S'
												AND Linea_Transsaccion = 'BLQCLI' ), '')

   SELECT @Firma1  = res.Firma1,  
   @Firma2  = res.Firma2,  
   @sMooper = ori.mooper,  
   @sMoterm = CASE ori.moterm WHEN 'FORWARD'   THEN 'FORWARD'  
                                     WHEN 'BOLSA'     THEN 'OTC'  
                                     WHEN 'DATATEC'   THEN 'DATATEC'  
                                     WHEN 'BACTRAD2'  THEN 'MANUAL'  
                                     ELSE                  ori.moterm  
                     END   
   FROM  BacCamSuda..MEMO ori with(nolock)  
         LEFT JOIN BacLineas..DETALLE_APROBACIONES res with(nolock) ON res.Numero_Operacion = ori.MONUMOPE  
   WHERE res.Numero_Operacion=@NumOper  
  
/******************************************************************/  
  
  
   IF EXISTS (SELECT 1 FROM MEMO with(nolock) WHERE monumope = @NumOper )   
   BEGIN   
   
      SELECT  --'nombreentidad'   = (SELECT acnombre FROM MEAC with(nolock))  
	         'nombreentidad'   = (SELECT RazonSocial FROM BacParamSuda.dbo.Contratos_ParametrosGenerales  with(nolock))
             ,'NumeroOperac'    = monumope  
             ,'Entidad     '  = moentidad  
             ,'Codigomoneda'    = mocodmon  
             ,'Codigomoncnv'    = mocodcnv  
             ,'glosamoneda'   = a.mnglosa --> (SELECT mnglosa  From VIEW_MONEDA with(nolock) Where mnnemo = mocodmon)  
             ,'glosamoncnv'   = b.mnglosa --> (SELECT mnglosa  From VIEW_MONEDA with(nolock) Where mnnemo = mocodcnv)  
             ,'Tipomercado '  = CASE motipmer  
                                  WHEN 'EMPR' THEN 'EMPRESA'  
                                  WHEN 'PTAS' THEN 'PUNTA'  
                                  WHEN 'CUPO' THEN 'CUPO'  
                                  WHEN 'ARRI' THEN 'ARRIENDO'  
                                  WHEN 'CANJ' THEN 'CANJE'  
                                  WHEN 'ARBI' THEN 'ARBITRAJE'  
                                  WHEN 'VB2 ' THEN 'VB2'   
                                  WHEN 'FUTU' THEN 'FUTURO'   
                                  WHEN 'OVER' THEN 'OVER'  
                                  WHEN 'WEEK' THEN 'WEEK'  
                                  WHEN '1446' THEN '1446'   
                               END   
            ,'TipOperacion' = CASE motipope  
                                  WHEN 'C' THEN 'Compra'  
                                  WHEN 'I' THEN 'Ingreso'  
                                  WHEN 'R' THEN 'Restitución'  
                                  ELSE 'Venta' END  
           ,'Montooperaci'  = momonmo  
           ,'Tipocambio  '  = moticam   
           ,'NomCliente  '  = CASE motipmer WHEN 'ARBI' THEN ISNULL((SELECT DISTINCT nombre FROM view_corresponsal WHERE cod_corresponsal = CONVERT(INTEGER,swift_entregamos) ),' ') ELSE monomcli END  
           ,'Rutcliente  '  = morutcli   
           ,'Codcliente  ' = mocodcli  
           ,'telefono    '  = clfono    --> (Select clfono   From  view_cliente Where clrut = morutcli AND clcodigo = mocodcli )  
           ,'ctactepeso  '  = clctacte  --> (Select clctacte From  view_cliente Where clrut = morutcli AND clcodigo = mocodcli )  
           ,'ctacteUSD   '  = ClCtausd  --> (Select ClCtausd From  view_cliente Where clrut = morutcli AND clcodigo = mocodcli )  
           ,'numeroCLien '  = (SELECT claglosa FROM  view_abreviatura_cliente with(nolock) Where clarutcli = morutcli AND clacodigo = mocodcli)  
           ,'sucursal    '  = cldirecc  --> (Select cldirecc From  view_cliente Where clrut = morutcli AND clcodigo = mocodcli )  
           ,'Operador    '  = mooper  
           ,'Terminal    '  = moterm  
           ,'Hora        '  = mohora   
           ,'FechaOperaci'  = mofech  
           ,'Valormoneda '  = moprecio  
           ,'Valor       '  = motctra   -- valor paridad   
           ,'paridad     '  = moparme      
           ,'Recibe      '  = CONVERT(CHAR(5),morecib)             + ' ' + ISNULL((Select glosa From view_forma_de_pago with(nolock) Where codigo = morecib),' NO EXISTE FORMA DE PAGO')  
           ,'Forma_pa_nac'  = CONVERT(CHAR(5),forma_pago_cli_nac)  + ' ' + ISNULL((Select glosa From view_forma_de_pago with(nolock) Where codigo = forma_pago_cli_nac),' NO EXISTE FORMA DE PAGO')  
           ,'Entrega     '  = CONVERT(CHAR(5),moentre)             + ' ' + ISNULL((Select glosa From view_forma_de_pago with(nolock) Where codigo = moentre),' NO EXISTE FORMA DE PAGO')  
           ,'Forma_pa_ext'  = (CONVERT(CHAR(5),forma_pago_cli_ext) + ' ' + ISNULL((Select glosa From view_forma_de_pago with(nolock) Where codigo = forma_pago_cli_ext), ' NO EXISTE FORMA DE PAGO'))  
           ,'Valuta1     '  =  movaluta1   
           ,'Valuta2     '  =  movaluta2   
           ,'paridaCierre'  =  moparme   
           ,'paridaTransa'  =  mopartr   
           ,'Observacion '  = RTRIM(LTRIM(Observacion))  
           ,'DigitoVerifi'  = cldv --> (Select cldv From VIEW_CLIENTE Where clrut = morutcli AND clcodigo = mocodcli)  
           ,'FechaProceso'  = (Select acfecpro  From meac)  
           ,'montoenpesos'  = momonpe  
           ,'montodolares'  = moussme      
           ,'EntregamosA'   = CASE Swift_Recibimos    WHEN ' ' THEN ' ' ELSE ISNULL(( Select DISTINCT nombre From VIEW_CORRESPONSAL Where  cod_corresponsal =  CONVERT(INTEGER,Swift_Recibimos) ),' ') END  
           ,'RecibimosEn'   = CASE Swift_Corresponsal WHEN ' ' THEN ' ' ELSE ISNULL(( Select DISTINCT nombre From VIEW_CORRESPONSAL Where  cod_corresponsal =  CONVERT(INTEGER,Swift_Corresponsal) ),' ') END  
           ,'STATUS     '   = moestatus  
           ,'Concepto   '   = ISNULL((SELECT conc_opera FROM tbomadelcorp WHERE CONVERT(INTEGER,mocodoma)=CONVERT(INTEGER,codi_opera)),' ')  
           ,'VamosVienen'   = movamos  
           ,'Girador    '   = Clnombre --> (SELECT Clnombre FROM view_cliente WHERE clrut = morutgir AND clcodigo = mocodigogirador)  
           ,'Obs_Limite '   = RTRIM(moobservlim)  
           ,'Obs_Linea  '   = RTRIM(moobservlin) + ' ' + RTRIM(@xMensajeBloqueos)
           ,'Autorizador'   = autorizador_limite  
           ,'Swift'  = Clswift --> (SELECT Clswift FROM view_cliente WHERE clrut = morutcli AND clcodigo = mocodcli)  
           ,'Corres_Cli' = ISNULL(Nombre_Corresponsal,' ') --> (SELECT Nombre_Corresponsal FROM view_cliente_corresponsal WHERE rut_cliente = morutcli)  
           ,'Cuenta_Cli'    = ISNULL(Cuenta_Corresponsal,' ') --> (SELECT Cuenta_Corresponsal FROM view_cliente_corresponsal WHERE rut_cliente = morutcli)  
           ,'mofecvcto'         = mofecvcto  
           ,'Firma1'  = @Firma1  
           ,'Firma2'  = @Firma2  
           ,'Mooper'  = @sMooper   
           ,'Moterm'  = @sMoterm   
           ,'CLIENTE'  = monomcli  
           From MEMO            WITH(NOLOCK)  
                INNER JOIN VIEW_CLIENTE                WITH(NOLOCK) ON clrut = morutcli AND clcodigo = mocodcli  
                LEFT  JOIN VIEW_CLIENTE_CORRESPONSAL   WITH(NOLOCK) ON rut_cliente = morutcli  
                INNER JOIN VIEW_MONEDA               a WITH(NOLOCK) ON a.mnnemo = mocodmon  
                INNER JOIN VIEW_MONEDA               b WITH(NOLOCK) ON b.mnnemo = mocodcnv  
           Where Monumope       = @Numoper  
   End   
   Else Begin   
         IF EXISTS (SELECT monumope FROM memoh WHERE monumope = @NumOper  ) begin   
      
             Select  --'nombreentidad' = (Select ACNOMBRE From meac ) 
			         'nombreentidad' = (SELECT RazonSocial FROM BacParamSuda.dbo.Contratos_ParametrosGenerales  with(nolock))
                    ,'NumeroOperac'  = monumope  
                    ,'Entidad     '  = moentidad  
                    ,'Codigomoneda'  = mocodmon  
                    ,'Codigomoncnv'  = mocodcnv  
                    ,'glosamoneda'   = (Select mnglosa  From VIEW_MONEDA  Where mnnemo = mocodmon)  
                    ,'glosamoncnv'   = (Select mnglosa  From VIEW_MONEDA  Where mnnemo = mocodcnv)  
                    ,'Tipomercado '  = CASE motipmer WHEN 'EMPR' THEN 'EMPRESA'  
										   WHEN 'PTAS' THEN 'PUNTA'  
										   WHEN 'CUPO' THEN 'CUPO'  
										   WHEN 'ARRI' THEN 'ARRIENDO'  
										   WHEN 'CANJ' THEN 'CANJE'  
										   WHEN 'ARBI' THEN 'ARBITRAJE'  
										   WHEN 'VB2 ' THEN 'VB2'   
										   WHEN 'FUTU' THEN 'FUTURO'   
										   WHEN 'OVER' THEN 'OVER'  
										   WHEN 'WEEK' THEN 'WEEK'  
										   WHEN '1446' THEN '1446'   
										   END   
														,'TipOperacion'  = CASE motipope WHEN 'C' THEN 'Compra'  
										   WHEN 'I' THEN 'Ingreso'  
										   WHEN 'R' THEN 'Restitución'  
										   ELSE 'Venta' END  
                    ,'Montooperaci' = momonmo  
                    ,'Tipocambio  '  = moticam   
                    ,'NomCliente  '  = CASE motipmer WHEN 'ARBI' THEN ISNULL((SELECT DISTINCT nombre FROM view_corresponsal WHERE cod_corresponsal = CONVERT(INTEGER,swift_entregamos) ),' ') ELSE monomcli END  
                    ,'Rutcliente  '  = morutcli   
                    ,'Codcliente  '  = mocodcli  
                    ,'telefono    '  = (Select clfono   From  view_cliente Where clrut = morutcli AND clcodigo = mocodcli )  
                    ,'ctactepeso  '  = (Select clctacte From  view_cliente Where clrut = morutcli AND clcodigo = mocodcli )  
                    ,'ctacteUSD   '  = (Select ClCtausd From  view_cliente Where clrut = morutcli AND clcodigo = mocodcli )  
                    ,'numeroCLien '  = (SELECT claglosa FROM  view_abreviatura_cliente Where clarutcli = morutcli AND clacodigo = mocodcli)  
                    ,'sucursal    ' = (Select cldirecc From  view_cliente Where clrut = morutcli AND clcodigo = mocodcli )  
                    ,'Operador    '  = mooper  
                    ,'Terminal    '  = moterm  
                    ,'Hora        '  = mohora   
                    ,'FechaOperaci'  = mofech  
                    ,'Valormoneda '  = moprecio  
                    ,'Valor       '  = motctra   -- valor paridad   
                    ,'paridad     '  = moparme      
                    ,'Recibe      '  = CONVERT(CHAR(5),morecib) + ' ' + ISNULL((Select glosa From view_forma_de_pago  Where codigo = morecib),' NO EXISTE FORMA DE PAGO')  
                    ,'Forma_pa_nac'  = CONVERT(CHAR(5),forma_pago_cli_nac) + ' ' + ISNULL((Select glosa From VIEW_FORMA_DE_PAGO  Where codigo = forma_pago_cli_nac),' NO EXISTE FORMA DE PAGO')  
                    ,'Entrega     '  = CONVERT(CHAR(5),moentre) + ' ' + ISNULL((Select glosa From view_forma_de_pago  Where codigo = moentre),' NO EXISTE FORMA DE PAGO')  
                    ,'Forma_pa_ext'  = (CONVERT(CHAR(5),forma_pago_cli_ext) + ' ' + ISNULL((Select glosa From view_forma_de_pago Where codigo = forma_pago_cli_ext), ' NO EXISTE FORMA DE PAGO'))  
                    ,'Valuta1     '  =  movaluta1   
                    ,'Valuta2     ' =  movaluta2   
                    ,'paridaCierre'  =  moparme   
                    ,'paridaTransa'  =  mopartr   
                    ,'Observacion '  = RTRIM(LTRIM(Observacion))  
                    ,'DigitoVerifi'  = (Select cldv From VIEW_CLIENTE Where clrut = morutcli AND clcodigo = mocodcli)  
                    ,'FechaProceso'  = (Select acfecpro  From meac)  
                    ,'montoenpesos'  = momonpe  
                    ,'montodolares'  = moussme      
                    ,'EntregamosA'   = CASE Swift_Recibimos  WHEN ' ' THEN ' ' ELSE ISNULL(( Select DISTINCT nombre From VIEW_CORRESPONSAL Where  cod_corresponsal =  CONVERT(INTEGER,Swift_Recibimos) ),' ') END  
                    ,'RecibimosEn'   = CASE Swift_Corresponsal WHEN ' ' THEN ' ' ELSE ISNULL(( Select DISTINCT nombre From VIEW_CORRESPONSAL Where  cod_corresponsal =  CONVERT(INTEGER,Swift_Corresponsal) ),' ') END  
                    ,'STATUS     '   = moestatus  
                    ,'Concepto   '   = ISNULL((SELECT conc_opera FROM tbomadelcorp WHERE CONVERT(INTEGER,mocodoma)=CONVERT(INTEGER,codi_opera)),' ')  
                    ,'VamosVienen'   = movamos  
                    ,'Girador    '   = (SELECT Clnombre FROM view_cliente WHERE clrut = morutgir AND clcodigo = mocodigogirador)  
                    ,'Obs_Limite '   = RTRIM(moobservlim)  
                    ,'Obs_Linea  '   = RTRIM(moobservlin) + ' ' + RTRIM(@xMensajeBloqueos)
                    ,'Autorizador'   = autorizador_limite  
                    ,'Swift'  = (SELECT Clswift FROM view_cliente WHERE clrut = morutcli AND clcodigo = mocodcli)  
                    ,'Corres_Cli' = (SELECT Nombre_Corresponsal FROM view_cliente_corresponsal WHERE rut_cliente = morutcli)  
                    ,'Cuenta_Cli'    = (SELECT Cuenta_Corresponsal FROM view_cliente_corresponsal WHERE rut_cliente = morutcli)  
                    ,'mofecvcto' = mofecvcto  
                    ,'Firma1'  = @Firma1  
                    ,'Firma2'  = @Firma2  
                    ,'Mooper'  = @sMooper   
                    ,'Moterm'  = @sMoterm   
                    ,'CLIENTE'  = monomcli  
               From MEMOH WITH(NOLOCK) Where Monumope = @Numoper  
         End   
         Else Begin   
                select -1, 'error:  no se encuentra numero operacion.'  
         End  
   End  
End  
GO
