USE [BacBonosExtSuda]
GO
/****** Object:  View [dbo].[VIEW_CLIENTE_OPERADOR]    Script Date: 11-05-2022 16:32:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE VIEW [dbo].[VIEW_CLIENTE_OPERADOR]
AS
SELECT 	oprutcli,    
	opcodcli,    
	oprutope,    
	opdvope, 
	opnombre   

FROM BacParamSuda..CLIENTE_OPERADOR


-- select * from VIEW_CORRESPOSAL 
-- select * from VIEW_CORRESPONSAL



GO
