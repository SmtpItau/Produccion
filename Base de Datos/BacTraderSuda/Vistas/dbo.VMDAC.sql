USE [BacTraderSuda]
GO
/****** Object:  View [dbo].[VMDAC]    Script Date: 16-05-2022 10:13:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  vista dbo.vmdac    fecha de la secuencia de comandos: 05/04/2001 9:20:55 ******/
/****** Objeto:  vista dbo.vmdac    fecha de la secuencia de comandos: 07/02/2001 11:43:19 ******/
CREATE VIEW [dbo].[VMDAC]
AS SELECT 
 acrutprop,
 acdigprop,
 acnomprop,
 'acfecante'=CONVERT(CHAR(10),acfecante,112),
 'acfecproc'=CONVERT(CHAR(10),acfecproc,112),
 'acfecprox'=CONVERT(CHAR(10),acfecprox,112),
 acnumoper,
 acsw_pd,
 acsw_rc,
 acsw_rv,
 acsw_co,
 acsw_dv,
 acsw_cm,
 acsw_ptw,
 acsw_trd,
 acsw_btw,
 acsw_mesa,
 acsw_pc,
 acsw_fd,
 acsw_finmes,
 'acfecsbif1'=CONVERT(CHAR(10),acfecsbif1,112),
 'acfecsbif2'=CONVERT(CHAR(10),acfecsbif2,112),
 ac_maxpap,
 acnom_resoma,
 acfon_resoma,
 acdirprop,
 accomprop,
 'acfecvmer'=CONVERT(CHAR(10),acfecvmer,112),
 accomision,
 aciva,
 acrutcomi,
 acdigcomi,
 acnumlogs,
 acpatrimonio,
 acsw_mm
   FROM MDAC

GO
