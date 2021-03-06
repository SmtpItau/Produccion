USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SADP_LEER_VALEVISTAS]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SADP_LEER_VALEVISTAS]      
AS      
BEGIN       
 SET NOCOUNT ON ;      
       
 DECLARE       
   @sCtaADMINISTRADORA  VARCHAR(40)      
 ,  @sNombreAdministradora VARCHAR(40)      
 ,  @sRutAdministradora  VARCHAR(10)      
 ,  @iRutAdministradora  INT      
       
 ,  @sCtaAgencia   VARCHAR(40)      
 ,  @sNombreAgencia   VARCHAR(40)      
 ,  @sRutAgencia   VARCHAR(10)      
      
 ,  @sCtaCorredora   VARCHAR(40)      
 ,  @sNombreCorredora  VARCHAR(40)      
 ,  @sRutCorredora   VARCHAR(10)      
 ,  @sCodFFMM    VARCHAR(10)      
 ,  @sCodCDB    VARCHAR(10)      
 ,  @sCodAgenciA   VARCHAR(10)      
        
  SET @sCtaADMINISTRADORA  = (SELECT  sCuentaCorriente       
                                FROM SADP_CUENTASCORRIENTES sc      
                               INNER      
                                JOIN SADP_CONTROL sc2      
                                  ON sc.iRutCliente = sc2.iRut_FFMM      
                                 AND sc.iCodCliente = 0      
                                 AND sc.id_banco    = 27      
            AND sc.icodmoneda  =999) ;      
                                       
  SET @sCtaAgencia   = (SELECT  sCuentaCorriente       
                                FROM SADP_CUENTASCORRIENTES sc      
                               INNER      
                                JOIN SADP_CONTROL sc2      
                                  ON sc.iRutCliente = sc2.iRut_Agencia      
                                 AND sc.iCodCliente = 0      
                                 AND sc.id_banco    = 27      
            AND sc.icodmoneda  =999) ;      
                                       
  SET @sCtaCorredora   = (SELECT  sCuentaCorriente       
                                FROM SADP_CUENTASCORRIENTES sc      
                               INNER      
                                JOIN SADP_CONTROL sc2      
                                  ON sc.iRutCliente = sc2.iRut_CDB      
                                 AND sc.iCodCliente = 0      
                                 AND sc.id_banco    = 27      
            AND sc.icodmoneda  =999) ;      
 SELECT       
   @sNombreAdministradora = sc.Nombre_FFMM      
 ,  @iRutAdministradora  = sc.iRut_ffmm      
 ,  @sRutAdministradora  = ltrim(rtrim(CONVERT(CHAR(9),sc.iRut_ffmm)))+sc.cDv_ffmm      
 ,  @sNombreAgencia   = sc.Nombre_Agencai      
 ,  @sRutAgencia   = ltrim(rtrim(CONVERT(CHAR(9),sc.iRut_agencia)))+sc.cDv_agencia      
 ,  @sNombreCorredora  = sc.Nombre_CDB      
 ,  @sRutCorredora   = ltrim(rtrim(CONVERT(CHAR(9),sc.iRut_CDB)))+sc.cDv_CDB      
 ,  @sCodFFMM    = sc.COD_FFMM      
 ,  @sCodCDB    = SC.COD_CDB      
 ,  @sCodAgenciA   = SC.COD_AGENCIA  
  FROM SADP_CONTROL sc           ;      
      
 DECLARE @TBL_EOF011501       
   TABLE(H01USERID  VARCHAR(10) NOT NULL DEFAULT ''      
 ,  H01PROGRM  VARCHAR(10) NOT NULL DEFAULT ''      
 ,  H01TIMSYS  VARCHAR(12) NOT NULL DEFAULT ''      
 ,  H01SCRCOD  VARCHAR(2) NOT NULL DEFAULT ''      
 ,  H01OPECOD  VARCHAR(4) NOT NULL DEFAULT ''      
 ,  H01FLGMAS  VARCHAR(1) NOT NULL DEFAULT ''      
 ,  H01FLGWK1  VARCHAR(1) NOT NULL DEFAULT ''      
 ,  H01FLGWK2  VARCHAR(1) NOT NULL DEFAULT ''      
 ,  H01FLGWK3  VARCHAR(1) NOT NULL DEFAULT ''      
 ,  E01OFMBNK  VARCHAR(2) NOT NULL DEFAULT ''      
 ,  E01OFMBRN  NUMERIC(3) NOT NULL DEFAULT 0      
 ,  E01OFMCCY  VARCHAR(3) NOT NULL DEFAULT ''      
 ,  E01OFMDSC  VARCHAR(35) NOT NULL DEFAULT ''      
 ,  E01OFMCKN  NUMERIC(9) NOT NULL DEFAULT 0       
 ,  E01OFMFTY  VARCHAR(1) NOT NULL DEFAULT ''      
 ,  E01OFMEM1  NUMERIC(2) NOT NULL DEFAULT 0      
 ,  E01OFMEM2  NUMERIC(2) NOT NULL DEFAULT 0      
 ,  E01OFMEM3  NUMERIC(2) NOT NULL DEFAULT 0      
 ,  E01DEBOPC  VARCHAR(2) NOT NULL DEFAULT ''      
 ,  E01DEBCON  VARCHAR(25) NOT NULL DEFAULT ''      
 ,  E01DEBBNK  VARCHAR(2) NOT NULL DEFAULT ''      
 ,  E01DEBBRN  NUMERIC(3) NOT NULL DEFAULT 0      
 ,  E01DEBCCY  VARCHAR(3) NOT NULL DEFAULT ''      
 ,  E01DEBGLN  NUMERIC(16) NOT NULL DEFAULT 0      
 ,  E01DEBACC  NUMERIC(12) NOT NULL DEFAULT 0      
 ,  E01OFMAMT  NUMERIC(15) NOT NULL DEFAULT 0      
 ,  E01OFMBNF  VARCHAR(35) NOT NULL DEFAULT ''      
 ,  E01OFMBN1  VARCHAR(35) NOT NULL DEFAULT ''      
 ,  E01OFMBN2  VARCHAR(35) NOT NULL DEFAULT ''      
 ,  E01OFMAPL  VARCHAR(35) NOT NULL DEFAULT ''      
 ,  E01OFMAP1  VARCHAR(35) NOT NULL DEFAULT ''      
 ,  E01OFMAP2  VARCHAR(35) NOT NULL DEFAULT ''      
 ,  E01OFMCUN  NUMERIC(9) NOT NULL DEFAULT 0      
 ,  E01OFMAD1  VARCHAR(70) NOT NULL DEFAULT ''       
 ,  E01OFMAD2  VARCHAR(70) NOT NULL DEFAULT ''      
 ,  E01OFMAD3  VARCHAR(70) NOT NULL DEFAULT ''      
 ,  E01OFMCO1  VARCHAR(70) NOT NULL DEFAULT ''      
 ,  E01OFMCO2  VARCHAR(70) NOT NULL DEFAULT ''      
 ,  E01OFMCO3  VARCHAR(70) NOT NULL DEFAULT ''      
 ,  E01OFMCLS  VARCHAR(1) NOT NULL DEFAULT ''      
 ,  E01FRMPAG  VARCHAR(1) NOT NULL DEFAULT ''      
 ,  E01LETAMT  VARCHAR(160) NOT NULL DEFAULT ''      
 ,  E01OFMAPV  VARCHAR(1) NOT NULL DEFAULT ''      
 ,  E01OFMPTH  VARCHAR(80) NOT NULL DEFAULT ''      
 ,  E01OFMCOM  NUMERIC(15) NOT NULL DEFAULT 0      
 ,  E01OFMIVA  NUMERIC(15) NOT NULL DEFAULT 0      
 ,  E01OFMBTH  NUMERIC(4) NOT NULL DEFAULT 0      
 ,  E01NEWCKN  NUMERIC(9) NOT NULL DEFAULT 0      
 ,  E01OFMBID  VARCHAR(15) NOT NULL DEFAULT ''      
 ,  E01OFMAID  VARCHAR(15) NOT NULL DEFAULT ''       
 ,  E01OFMCTY  VARCHAR(4) NOT NULL DEFAULT ''      
 ,  D01OFMCTY  VARCHAR(35) NOT NULL DEFAULT ''      
 ,  E01OFMLAV  VARCHAR(1) NOT NULL DEFAULT ''      
 ,  SISTEMA   VARCHAR(4) NOT NULL DEFAULT ''      
 ,  OPERACION  NUMERIC(10) NOT NULL DEFAULT 0      
    )      
      
    DECLARE @xUsuanrio VARCHAR(7)      
  SET @xUsuanrio = ( SELECT cUser FROM SADP_DATOS_ENVIO )       
      
      
      
      
 INSERT INTO @TBL_EOF011501(      
   H01USERID      
 ,  H01PROGRM      
 ,  H01SCRCOD      
 ,  E01OFMFTY      
 ,  E01OFMCCY      
 ,  E01DEBOPC      
 ,  E01DEBCON      
 ,  E01OFMBNK      
 ,  E01DEBBRN      
 ,  E01DEBGLN      
 ,  E01DEBACC      
 ,  E01OFMAMT      
 ,  E01OFMBNF      
 ,  E01OFMBN1      
 ,  E01OFMBN2      
 ,  E01OFMCUN      
 ,  E01OFMCLS      
 ,  E01FRMPAG      
 ,  E01OFMCTY      
 ,  H01OPECOD      
 ,  OPERACION      
 ,  sistema)      
   
 SELECT  @xUsuanrio,       
   'EOF011501',      
   '01',      
   'B',      
   'CLP',      
   '03',      
   '2.CARGO CUENTA CLIENTE',      
            '01',      
            '0',      
            '0',      
            CASE WHEN sdp.cModulo ='FFMM' THEN @sCtaADMINISTRADORA      
     WHEN sdp.cModulo ='CDB'  THEN @sCtaCorredora      
     WHEN SDP.cModulo ='GPI'  THEN @sCtaAgencia       
     ELSE 0 END    AS E01DEBACC ,      
            E01OFMAMT= nMonto,      
            substring(sNomBeneficiario,1,30),      
            substring(sNomBeneficiario,31,30),      
            substring(sNomBeneficiario,61,30),      
   CASE WHEN sdp.cModulo ='FFMM' THEN @sCodFFMM      
     WHEN sdp.cModulo ='CDB'  THEN @sCodCDB      
     WHEN SDP.cModulo ='GPI'  THEN @sCodAgenciA       
     ELSE 0 END    AS E01OFMCUN ,      
      
            'B',      
            2,      
            '222',      
            '0005' ,      
            sdp.Id_Detalle_Pago,    
            sdp.cModulo      
   FROM sadp_detalle_pagos sdp       
  WHERE iFormaPago= 5      
    AND CESTADO='E'  
    AND (sdp.vNumTransferencia='' OR sdp.vNumTransferencia =0)        
 SELECT * FROM @TBL_EOF011501;  
          
END  
  
  
  
-- SELECT * FROM sadp_detalle_pagos WHERE cModulo ='CDB' and iformapago=5  
 --UPDATE sadp_detalle_pagos SET vNumTransferencia =''  
--	where cModulo ='CDB' AND vNumTransferencia =122 and iformapago=5
-- SELECT * FROM tbl_mensajes_servicios ms
GO
