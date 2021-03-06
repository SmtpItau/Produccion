USE [BacTraderSuda]
GO
/****** Object:  View [dbo].[CLIENTE]    Script Date: 16-05-2022 10:13:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[CLIENTE]
AS

	SELECT	Clrut,Cldv,Clcodigo,Clnombre,Clgeneric,Cldirecc,Clcomuna,Clregion,Cltipcli,Clfecingr,Clctacte,Clfono,Clfax
		,   Clapelpa,Clapelma,Clnomb1,Clnomb2,Clapoderado,Clciudad,Clmercado,Clgrupo,Clpais,Clcalidadjuridica,Cltipoml
		,   Cltipomx,Clbanca,Clrelac,Clnumero,Clcomex,Clchips,Claba,Clswift,Clnfm,Clfmutuo,Clfeculti,Clejecuti,Clentidad
		,	Clgraba,Clcompint,Clcalle,Clctausd,Clcaljur,Clnemo,Climplic,Clopcion,Clcalidad,Cltipode,Clrelacion,Clcatego
		,	Clsector,Clestado,Clclsbif,Clfesbif,Clclbco,Clfecbco,Clactivida,Cltelef,Usuario,Cltipemp,Relbco,Fecact,Cltipsis
		,	Poder,Firma,Feca85,Relcia,Relcor,Infosoc,Art85,Dec85,Clconres,Clcodban,Cod_Inst,Rut_Grupo,Clcodfox,Clcrf,Clerf
		,	Clvctolineas,Clvalidalinea,Oficinas,Clclaries,Codigo_Otc,Bloqueado,CLFECCONDGRL,clcosto,mxcontab,clrutcliexterno
		,	cldvcliexterno,clBrokers,RutBancoReceptor,CodBancoReceptor,clCondicionesGenerales,clFechaFirma_cond,fecha_escritura
		,	nombre_notaria,ClCompBilateral,NUEVO_CCG_FIRMADO,VERSION_CONTRATOS_CCG,FECHA_FIRMA_NUEVO_CCG,CLAUSULA_RETROACTIVA_FIRMADA
		,	seg_comercial,ejecutivo_comercial,garantiatotal,motivo_bloqueo,ClVigente,garantiaefectiva,ClRecMtdCod,FechaFirmaCG_Pactos
		,	EMAIL,ComDer,ClFechaFirmaContratoComDer,ClClasificaDecimales,ClCantidadDecimales,Secuencia,Codigo_AS400,Codigo_CGI
	FROM	BacParamSuda.dbo.Cliente with(nolock)
-- Base de Datos --
GO
