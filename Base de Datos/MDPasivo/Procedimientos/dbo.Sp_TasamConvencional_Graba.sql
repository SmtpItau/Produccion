USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_TasamConvencional_Graba]    Script Date: 16-05-2022 11:18:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_TasamConvencional_Graba]
		(	@codigoprod	char(5)		,
			@codigom	numeric(5,0)	,
			@diasdesde	numeric(5,0)	,
			@diashasta	numeric(5,0)	,
			@tasamin	numeric(8,4)	,
			@tasamax	numeric(8,4)	,
			@montomin	numeric(19,4)	,	
			@montomax	numeric(19,4)
		)

AS
BEGIN
        SET NOCOUNT ON
        SET DATEFORMAT dmy


	IF EXISTS(SELECT codigo_producto FROM TASAS_MAXIMAS_CONVENCIONAL WHERE codigo_producto 		= @codigoprod 
										and codigo_moneda	= @codigom 
										and diasdesde 		= @diasdesde
										and diashasta 		= @diashasta
										and montominimo 	= @montomin
										and montomaximo  	= @montomax
										and tasaminima 		= @tasamin
										and tasamaxima 		= @tasamax) 

   		BEGIN
	   	DELETE FROM TASAS_MAXIMAS_CONVENCIONAL 
			WHERE	codigo_producto	= @codigoprod 	
		    	and	codigo_moneda	= @codigom
			and 	diasdesde 	= @diasdesde
			and 	diashasta 	= @diashasta
			and 	montominimo 	= @montomin
			and 	montomaximo  	= @montomax
			and 	tasaminima 	= @tasamin
			and 	tasamaxima 	= @tasamax

	END
		
		INSERT INTO TASAS_MAXIMAS_CONVENCIONAL
			(codigo_producto,
			codigo_moneda   ,
			diasdesde       ,
			diashasta       ,
			montominimo     ,
			montomaximo	,
			tasaminima      ,
			tasamaxima )     
		   VALUES
			(@codigoprod    ,
			@codigom        ,
			@diasdesde      ,
			@diashasta      ,
			@montomin       ,
			@montomax       ,
			@tasamin        ,		
			@tasamax)        

			

	SET NOCOUNT OFF
	
	SELECT 'OK'
END














GO
