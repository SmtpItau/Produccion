USE [BacTraderSuda]
GO
/****** Object:  View [dbo].[VIEW_CLIENTE_RELACIONADO]    Script Date: 16-05-2022 10:13:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  vista dbo.view_cliente_relacionado    fecha de la secuencia de comandos: 05/04/2001 9:20:53 ******/
/****** Objeto:  vista dbo.view_cliente_relacionado    fecha de la secuencia de comandos: 07/02/2001 11:43:18 ******/
CREATE VIEW [dbo].[VIEW_CLIENTE_RELACIONADO]
AS
select clrut_padre,
 clcodigo_padre,
 clrut_hijo,
 clcodigo_hijo,
 clporcentaje
from  BACPARAMsuda..CLIENTE_RELACIONADO

GO
