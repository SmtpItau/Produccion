USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[BBV_SELECT_VIEW_MOVIMIENTO_FORWARD]    Script Date: 16-05-2022 11:09:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[BBV_SELECT_VIEW_MOVIMIENTO_FORWARD]
AS
SELECT monumoper,mocodpos1,mocodmon1,mocodsuc1,mocodpos2,mocodmon2,mocodcart,mocodigo,mocodcli,motipoper,motipmoda,
       mofecha,motipcam,momdausd,momtomon1,moequusd1,moequmon1,momtomon2,moequusd2,moequmon2,moparmon1,mopremon1,
       moparmon2,mopremon2,moestado,moretiro,mocontraparte,moobserv,mospread,motasadolar,motasaufclp,moprecal,moplazo,
       mofecvcto,molock,mooperador,motasfwdcmp,motasfwdvta,mocalcmpdol,mocalcmpspr,mocalvtadol,mocalvtaspr,motasausd,
       motasacon,momtomon1ini,momtomon1fin,momtomon2ini,momtomon2fin,modiferen,mofpagomn,mofpagomx,mobroker,
       anula_usuario,anula_fecha,anula_hora,anula_motivo,codigo_area,contabiliza,moimpreso
 FROM VIEW_MOVIMIENTO_FORWARD
GO
