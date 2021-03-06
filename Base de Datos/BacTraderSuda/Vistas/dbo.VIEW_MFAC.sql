USE [BacTraderSuda]
GO
/****** Object:  View [dbo].[VIEW_MFAC]    Script Date: 16-05-2022 10:13:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[VIEW_MFAC]
AS SELECT 
 acrutprop
 ,acdigprop
 ,acnomprop
 ,acdirprop
 ,actelefono
 ,acfax
 ,acfecante
 ,acfecproc
 ,acfecprox
 ,acsucmesa
 ,acofimesa
 ,accodmonloc
 ,accodmondol
 ,accodmonuf
 ,accodmondolobs
 ,acnumoper
 ,acnumdecimales
 ,acpais
 ,acplaza
 ,accodempresa
 ,accodclie
 ,actipocalculo
 ,actipparfwd
 ,actcaparfwd
 ,acsw_pd
 ,acsw_fd
 ,acsw_ciemefwd
 ,acsw_devenfwd
 ,acsw_contafwd
 ,acnumlogs
 ,accodbcch
    FROM BACFWDSUDA..MFAC

GO
