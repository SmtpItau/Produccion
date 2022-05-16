USE [BacTraderSuda]
GO
/****** Object:  View [dbo].[VIEW_MERS]    Script Date: 16-05-2022 10:13:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  vista dbo.view_MERS    fecha de la secuencia de comandos: 05/04/2001 9:20:54 ******/
CREATE VIEW [dbo].[VIEW_MERS]
AS
SELECT
rsfecha             ,
rsnemome             ,
rscodigome             ,
rsposicion              ,
rscuentacambio       , 
rscuentaajustada     , 
rsvalorajuste         ,
rsutilidad            ,
rsperdida             
FROM BACCAMSUDA..MERS

GO
