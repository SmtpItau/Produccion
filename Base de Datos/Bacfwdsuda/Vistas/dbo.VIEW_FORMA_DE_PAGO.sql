USE [Bacfwdsuda]
GO
/****** Object:  View [dbo].[VIEW_FORMA_DE_PAGO]    Script Date: 13-05-2022 10:34:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[VIEW_FORMA_DE_PAGO]
AS 
   SELECT
 codigo,
 glosa,
 perfil,
 codgen,
 glosa2,
 cc2756,
 afectacorr,
 diasvalor,
 numcheque,
 ctacte
   FROM BACPARAMSUDA..FORMA_DE_PAGO

GO
