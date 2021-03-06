USE [BacTraderSuda]
GO
/****** Object:  View [dbo].[VMDVM]    Script Date: 16-05-2022 10:13:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  vista dbo.vmdvm    fecha de la secuencia de comandos: 05/04/2001 9:20:55 ******/
/****** Objeto:  vista dbo.vmdvm    fecha de la secuencia de comandos: 07/02/2001 11:43:19 ******/
CREATE VIEW [dbo].[VMDVM]
AS
SELECT 
vmcodigo,
vmvalor,
vmptacmp,
vmptavta,
'VMFECHA'=CONVERT(CHAR(10),vmfecha,112),
vmtipo,
vmparidad,
vmparmer,
vmposini,
vmprecoi,
vmparini,
vmprecoc,
vmparidc,
vmposic,
vmpreco,
vmpreve,
vmpmeco,
vmpmeve,
vmtotco,
vmtotve,
vmutili,
vmparco,
vmparve,
vmorden,
vmctacmb,
vmcmbini,
vmreval,
vmarbit,
vmparmer1,
vmnumstgo 
FROM VIEW_VALOR_MONEDA

GO
