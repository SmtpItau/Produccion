USE [BacTraderSuda]
GO
/****** Object:  View [dbo].[VIEW_CLIENTE]    Script Date: 16-05-2022 10:13:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[VIEW_CLIENTE]
AS
SELECT        
Clrut
, Cldv
, Clcodigo
, Clnombre
, Clgeneric
, Cldirecc
, Clcomuna
, Clregion
, Cltipcli
, Clfecingr
, Clctacte
, Clfono
, Clfax
, Clapelpa
, Clapelma
, Clnomb1
, Clnomb2
, Clapoderado
, Clciudad
, Clmercado
, Clgrupo
, Clpais
, Clcalidadjuridica
, Cltipoml
, Cltipomx
, Clbanca
, Clrelac
, Clnumero
, Clcomex
, Clchips
, Claba
, Clswift
, Clnfm
, Clfmutuo
, Clfeculti
, Clejecuti
, Clentidad
, Clgraba
, Clcompint
, Clcalle
, Clctausd
, Clcaljur
, Clnemo
, Climplic
, Clopcion
, Clcalidad
, Cltipode
, Clrelacion
, Clcatego
, Clsector
, Clestado
, Clclsbif
, Clfesbif
, Clclbco
, Clfecbco
, Clactivida
, Cltelef
, Usuario
, Cltipemp
, Relbco
, Fecact
, Cltipsis
, Poder
, Firma
, Feca85
, Relcia
, Relcor
, Infosoc
, Art85
, Dec85
, Clconres
, Clcodban
, Cod_Inst
, Rut_Grupo
, Clcodfox
, Clcrf
, Clerf
, Clvctolineas
, Clvalidalinea
, Oficinas
, Clclaries
, Codigo_Otc
, Bloqueado
, clcosto
, Codigo_AS400
FROM BacParamSuda.dbo.CLIENTE

GO
