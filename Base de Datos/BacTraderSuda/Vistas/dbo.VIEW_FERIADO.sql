USE [BacTraderSuda]
GO
/****** Object:  View [dbo].[VIEW_FERIADO]    Script Date: 16-05-2022 10:13:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  vista dbo.view_feriado    fecha de la secuencia de comandos: 05/04/2001 9:20:53 ******/
/****** Objeto:  vista dbo.view_feriado    fecha de la secuencia de comandos: 07/02/2001 11:43:18 ******/
CREATE VIEW [dbo].[VIEW_FERIADO]
AS  
select  feano,
 feplaza,
 feene,
 fefeb,
 femar,
 feabr,
 femay,
 fejun,
 fejul,
 feago,
 fesep,
 feoct,
 fenov,
 fedic
from BACPARAMsuda..FERIADO

GO
