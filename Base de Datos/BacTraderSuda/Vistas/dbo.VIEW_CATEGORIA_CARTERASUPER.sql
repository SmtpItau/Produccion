USE [BacTraderSuda]
GO
/****** Object:  View [dbo].[VIEW_CATEGORIA_CARTERASUPER]    Script Date: 16-05-2022 10:13:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  vista dbo.view_categoria_carterasuper    fecha de la secuencia de comandos: 05/04/2001 9:20:53 ******/
CREATE VIEW [dbo].[VIEW_CATEGORIA_CARTERASUPER]
AS
select
--digo_carterasuper 
nombre_carterasuper    
from BACPARAMsuda..CATEGORIA_CARTERASUPER

GO
