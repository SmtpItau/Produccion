USE [Reportes]
GO
/****** Object:  UserDefinedFunction [dbo].[Fx_Convalida_Pais]    Script Date: 16-05-2022 10:17:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[Fx_Convalida_Pais] --fx_homologa_nombreconcepto
	(	@desctipo	     char(3) --RCM
	,	@codigo_h		varchar(50) --13 --USD
	)	RETURNS varchar(max)	
AS 
BEGIN   

    DECLARE @cododesc_h varchar(max)
    DECLARE @id_desctipo int 
    DECLARE @id_reporte int 
    DECLARE @id_descreporte int 
    DECLARE @descreporte varchar(50) = 'Pais'
    DECLARE @reporte varchar(10) = 'AS400'
    DECLARE @cododesc int = 1 --si devuelvo el codigo = 0 o la descripcion = 1

    SET @cododesc_h = ''

    SELECT @id_desctipo = TRF.id_reporte
    FROM dbo.TBL_REPORTES_FUSION TRF
    WHERE TRF.desc_reporte = @desctipo 	

    SELECT @id_reporte = TDF1.id_descreporte  
    FROM dbo.TB_DESCREPORTE_FUSION TDF1 
    WHERE TDF1.desc_descreporte = @reporte

    SELECT @id_descreporte = TDF.id_desctipo   
    FROM dbo.TB_DESCTIPO_FUSION TDF	  
    WHERE TDF.desc_desctipo = @descreporte 

    SELECT @cododesc_h = dbo.Fx_Convalida_Tipos(@id_descreporte,@id_desctipo,@id_reporte,@codigo_h,@cododesc)

    RETURN @cododesc_h

END  

GO
