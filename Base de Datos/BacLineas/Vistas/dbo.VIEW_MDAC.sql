USE [BacLineas]
GO
/****** Object:  View [dbo].[VIEW_MDAC]    Script Date: 13-05-2022 10:48:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[VIEW_MDAC]
AS
   SELECT acrutprop
   ,      acdigprop
   ,      acnomprop
   ,      acfecante
   ,      acfecproc
   ,      acfecprox
   ,      acnumoper
   ,      acsw_pd
   ,      acsw_rc
   ,      acsw_rv
   ,      acsw_co
   ,      acsw_dv
   ,      acsw_cm
   ,      acsw_ptw
   ,      acsw_trd
   ,      acsw_btw
   ,      acsw_mesa
   ,      acsw_pc
   ,      acsw_fd
   ,      acsw_finmes
   ,      acfecsbif1
   ,      acfecsbif2
   ,      ac_maxpap
   ,      acnom_resoma
   ,      acfon_resoma
   ,      acdirprop
   ,      accomprop
   ,      acfecvmer
   ,      accomision
   ,      aciva
   ,      acrutcomi
   ,      acdigcomi
   ,      acnumlogs
   ,      acpatrimonio
   ,      acsw_mm
   FROM BacTraderSuda..MDAC





GO
