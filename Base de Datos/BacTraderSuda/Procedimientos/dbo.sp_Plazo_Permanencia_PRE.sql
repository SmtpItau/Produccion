USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[sp_Plazo_Permanencia_PRE]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_Plazo_Permanencia_PRE]
	(@Cartera        NUMERIC(01,00)
)
AS
BEGIN
	SET NOCOUNT ON

IF EXISTS (SELECT Cartera FROM TBLimper_PRE_APROBADO WHERE CARTERA = @Cartera ) BEGIN
		SELECT 'CARTERA' = CASE WHEN CarterA = 1 THEN 'NEGOCIACION' ELSE 'DISPONIBLE PARA LA VENTA' END,

	Instrumento, 	
Plazo_minimo,
	Plazo_maximo			,
 	Usuario_Administrativo		, 	
Usuario_Supervisor 		, 
	Fecha_De_Actualizacion		,
	Fecha_de_Aprobacion		,
	Codigo_Estado_de_Informacion	,
	Codigo_Estado_de_Accion 	,
       'HORA'   = CONVERT(CHAR(8),getdate(),108),	
'Accion' = ISNULL((SELECT Descripcion FROM ESTADO_DE_ACCION WHERE ESTADO_DE_ACCION.Codigo_Estado_de_Accion  = TBLimper_PRE_APROBADO.Codigo_Estado_de_Accion),''),
	'Estado' = ISNULL((SELECT Descripcion FROM  ESTADO_DE_INFORMACION WHERE ESTADO_DE_INFORMACION.Codigo_Estado_de_Informacion  = TBLimper_PRE_APROBADO.Codigo_Estado_de_Informacion),''), 
	
	/*'MONEDA' = (Case WHEN tipo_moneda	= 'N' then 'NACIONAL'
	ELSE 'EXTRANJERA'  END ),			--12*/	
	ACNOMPROP ,
	RUT_EMPRESA =  Replace(substring(CONVERT(CHAR(13),CONVERT(MONEY,acrutprop),1),1,10),',','.')+ '-'+acdigprop 

FROM TBLimper_PRE_APROBADO ,VIEW_MDAC
WHERE Cartera = @Cartera

END
ELSE BEGIN
SELECT 'ERROR'
END
SET NOCOUNT OFF
END

-- Base de Datos --
GO
