USE [Reportes]
GO
/****** Object:  UserDefinedFunction [dbo].[Fx_Convalida_Tipos]    Script Date: 16-05-2022 10:17:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[Fx_Convalida_Tipos] --fx_homologa_nombreconcepto
	(	@iddesctipo	int --RCM
	,	@idreporte	int --AS400
	,	@iddescreporte int --Tipo Monedas
	,	@codigo_h		varchar(20) --13
	,	@cododesc      int = 1--si devuelvo el codigo = 0 o la descripcion = 1
	)	RETURNS varchar(max)	
AS 
BEGIN   

    DECLARE @tipocodreporte varchar(max)
    SET @tipocodreporte	= ''

    IF(@cododesc = 0)
	   BEGIN	 
		  SELECT @tipocodreporte = TTH.tipos_codreporte_h 
		  FROM dbo.TBL_TIPOSFUSION_H TTH 
		  WHERE TTH.id_desctipo = @iddesctipo
		  AND TTH.id_reporte = @idreporte
		  AND TTH.id_descreporte = @iddescreporte
		  AND TTH.tipos_codreporte = @codigo_h
		  AND TTH.flag_activo = 1
	   END
    ELSE
	   BEGIN
		  SELECT @tipocodreporte = TTH.tipos_descreporte_h
		  FROM dbo.TBL_TIPOSFUSION_H TTH 
		  WHERE TTH.id_desctipo = @iddesctipo
		  AND TTH.id_reporte = @idreporte
		  AND TTH.id_descreporte = @iddescreporte
		  AND TTH.tipos_codreporte = @codigo_h
		  AND TTH.flag_activo = 1 
	   END  

    RETURN @tipocodreporte

END  

GO
