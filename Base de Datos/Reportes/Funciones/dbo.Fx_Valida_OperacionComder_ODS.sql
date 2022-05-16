USE [Reportes]
GO
/****** Object:  UserDefinedFunction [dbo].[Fx_Valida_OperacionComder_ODS]    Script Date: 16-05-2022 10:17:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[Fx_Valida_OperacionComder_ODS] 
	(	@NumOper      Int
	)	RETURNS varchar(max)	
AS 
BEGIN   


    DECLARE @Comder int 

	Set @Comder =   ISNULL((    SELECT c.nReNumOper
            FROM Bacfwdsuda..mfca mfca INNER JOIN BDBOMESA.dbo.ComDer_RelacionMarcaComder c
             ON mfca.canumoper = nReNumOper
             where c.nReNumOper = @NumOper
			),	0)




    RETURN @Comder

END  

GO
