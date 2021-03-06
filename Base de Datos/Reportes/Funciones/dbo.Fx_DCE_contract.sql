USE [Reportes]
GO
/****** Object:  UserDefinedFunction [dbo].[Fx_DCE_contract]    Script Date: 16-05-2022 10:17:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[Fx_DCE_contract] --fx_homologa_nombreconcepto
	(	@num_operacion	varchar(50)
	,	@modulo_paso	char(5) 
	)	RETURNS varchar(max)	
AS 
BEGIN   

    DECLARE @numero_dce varchar(max)
    DECLARE @modulo     CHAR(7)
    
    IF(@modulo_paso = 'CCS')
	   SET @modulo = 'CCS'  
    
    IF(@modulo_paso = 'BFW')
	   SET @modulo = 'NDF'	   

    IF(@modulo_paso = 'IRS')
	   SET @modulo = 'SWAP'
    
    IF(@modulo_paso = 'OPT')
	   SET @modulo = 'OPTIONS' 
    
    SELECT @numero_dce = vdc.dce_contrato_dce 
    FROM VIEW_DCE_CONTRATO vdc 
    WHERE ltrim(rtrim(vdc.dce_contrato)) = LTRIM(RTRIM(@num_operacion))
    AND vdc.dce_tipo = @modulo
     
    RETURN @numero_dce

END


GO
