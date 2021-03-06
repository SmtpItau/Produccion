USE [Bacfwdsuda]
GO
/****** Object:  View [dbo].[movimiento_historico]    Script Date: 13-05-2022 10:34:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[movimiento_historico]
AS
SELECT  monumoper,
 mocodpos1,
 mocodmon1,
 mocodsuc1,
 mocodpos2,
 mocodmon2,
 mocodcart,
 mocodigo,
 mocodcli,
 motipoper,
 motipmoda,
 CONVERT(CHAR(8),mofecha,112)AS mofecha ,
 motipcam,
 momdausd,
 momtomon1,
 moequusd1,
 moequmon1,
 momtomon2,
 moequusd2,
 moequmon2,
 moparmon1,
 mopremon1,
 moparmon2,
 mopremon2,
 moestado,
 moretiro,
  mocontraparte,
 moobserv,
 mospread,
 motasadolar,
 motasaufclp,
 moprecal,
 moplazo,
 CONVERT(CHAR(8),mofecvcto,112)AS mofecvcto,
 molock,
 mooperador,
 motasfwdcmp,
 motasfwdvta,
 mocalcmpdol,
 mocalcmpspr,
 mocalvtadol,
 mocalvtaspr,
 motasausd,
 motasacon,
 momtomon1ini,
 momtomon1fin,
 momtomon2ini,
 momtomon2fin,
 modiferen, 
 mofpagomn,
 mofpagomx,
 mobroker,
 mopremio,
 motipopc
FROM mfmoh

GO
