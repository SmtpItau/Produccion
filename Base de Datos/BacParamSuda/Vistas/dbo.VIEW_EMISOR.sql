USE [BacParamSuda]
GO
/****** Object:  View [dbo].[VIEW_EMISOR]    Script Date: 13-05-2022 10:59:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE VIEW [dbo].[VIEW_EMISOR]
AS
select emcodigo,
 emrut,
 emdv,
 emnombre,
 emgeneric,
 emdirecc,
 emcomuna,
 emtipo,
 emglosa,
 embonos,
 clasificacion1,
 clasificacion2,
 tipo_corto1,
 tipo_largo1,
 tipo_corto2,
 tipo_largo2
from  BACPARAMsuda..EMISOR



GO
