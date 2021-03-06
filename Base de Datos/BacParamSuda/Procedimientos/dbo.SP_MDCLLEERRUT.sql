USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MDCLLEERRUT]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_MDCLLEERRUT]   
                                    (@nrutcli     NUMERIC(10)  
                                    ,@ndigito     CHAR(1)  
                                    ,@ncodcli     NUMERIC(10)  
                                     )  
AS  
BEGIN  
 SET NOCOUNT ON   
 DECLARE @oRutReceptor   NUMERIC(10)  
              , @oCodReceptor   NUMERIC(10)  
              ,@oNomReceptor   VARCHAR(70)  
  
   
 SELECT @oRutReceptor = RutBancoReceptor  
               ,@oCodReceptor     = CodBancoReceptor  
 FROM   CLIENTE WITH(NOLOCK)  
 WHERE  clrut             = @nrutcli  
        AND clcodigo      = @ncodcli  
   
 SET @oNomReceptor = ''  
   
 SELECT @oNomReceptor = ISNULL(clnombre, '')  
 FROM   CLIENTE WITH(NOLOCK)  
 WHERE  clrut            = @oRutReceptor  
        AND clcodigo     = @oCodReceptor  
   
 SELECT clrut,  
        cldv,  
        clcodigo,  
        clnombre,  
        clgeneric,  
        cldirecc,  
        clcomuna,  
        clregion,  
        cltipomx,  
        CONVERT(CHAR(10), clfecingr, 103), -- 10  
        clctacte,  
        clfono,  
        clfax,  
        cltipcli,  
        clcalidadjuridica,  
        clciudad,  
        clentidad,  
        clmercado,  
        clgrupo,  
        clapoderado, -- 20  
        clpais,  
        clnomb1,  
        clnomb2,  
        clapelpa,  
        clapelma,  
        clnemo,  
        clctausd,  
        climplic,  
        claba,  
        clchips, -- 30  
        clswift,  
        clopcion,  
        clrelacion,  
        clcatego,  
        clsector,  
        clclsbif,  
        clactivida,  
        cltipemp,  
        relbco,  
        poder, -- 40  
        firma,  
        relcia,  
        relcor,  
        infosoc,  
        art85,  
        dec85,  
        rut_grupo,  
        clcodfox,  
        cod_inst,  
        clcodban, -- 50  
        clcrf,  
        clerf,  
        CONVERT(CHAR(10), clvctolineas, 103),  
        oficinas,  
        clclaries,  
        codigo_Otc,  
        Bloqueado,  
        clcosto,  
        Clejecuti,  
        mxcontab, -- 60  
        clrutcliexterno,  
        cldvcliexterno,  
        clBrokers,  
        @oRutReceptor,  
        @oCodReceptor,  
        @oNomReceptor,  
        clCondicionesGenerales,  
        clFechaFirma_cond,  
        fecha_escritura,  
        nombre_notaria, -- 70  
        Clfmutuo,  
        ClCompBilateral,  
        NUEVO_CCG_FIRMADO,  
        VERSION_CONTRATOS_CCG,  
        FECHA_FIRMA_NUEVO_CCG,  
        clausula_retroactiva_firmada, -- 76  
        seg_comercial, -- 77  
        garantiatotal, -- 78  
        motivo_bloqueo, -- 79  
        ejecutivo_comercial, -- 80  
        clvigente, -- 81  
        garantiaefectiva, --> 82  
        Metodologia = BacLineas.dbo.FN_RIEFIN_METODO_LCR(@nrutcli, @ncodcli, @nrutcli, @ncodcli),  
        FechaFirmaCG_Pactos, --> 83 PRD - 6056  
        email, --> 85  
        ComDer, --> 86 PRD - 19121  
        ClFechaFirmaContratoComDer, --> 87 PRD - 19121 V1  
        ClClasificaDecimales, --> 88 PRD-21639  
        ClCantidadDecimales   --> 89 PRD-21639  
        -- Datos Fusión  
          ,      Secuencia  --> 90   
          ,      Codigo_AS400  --> 91   
          ,      Codigo_CGI    --> 92   
    ,      ClCodEmpRelacionada    --> 93  
    ,      ClCod_Contra    --> 94  
    ,      ClCod_Emp_Cen    --> 95  
    ,      CNPJ    --> 96  
	,	   isnull(cod_colateral,'') as cod_colateral
 FROM   CLIENTE WITH(NOLOCK)  
 LEFT JOIN CLI_COLATERAL l ON rut_cliente=clrut and cod_cliente=clcodigo
 WHERE  clrut = @nrutcli  
   --     AND (cldv = @ndigito OR @ndigito = 0)  
        AND clcodigo = @ncodcli  
END

--GO
--GRANT EXECUTE ON BACPARAMSUDA.dbo.SP_MDCLLEERRUT to grp_bactrader
--GO
GO
