USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Carga_Plazos_Permanencia_preaprovado]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE PROCEDURE [dbo].[Sp_Carga_Plazos_Permanencia_preaprovado]

                        (

                            @Cartera    NUMERIC(01,00)

                        )

AS
BEGIN

SET NOCOUNT ON

IF EXISTS (SELECT Cartera,Instrumento,plazo_minimo,plazo_maximo FROM TBLimper_Pre_Aprobado WHERE  cartera = @Cartera)
BEGIN
    SELECT 		Cartera,		--1
			Instrumento,		--2
			plazo_minimo, 		--3
			plazo_maximo,		--4
 		        Usuario_Administrativo	,--7
		        Usuario_Supervisor 	, --8
			CONVERT(CHAR(10),Fecha_De_Actualizacion,103),--9
			CONVERT(CHAR(10),Fecha_de_Aprobacion,103),--10
			'Accion' = ISNULL((SELECT Descripcion FROM ESTADO_DE_ACCION WHERE Codigo_Estado_de_Accion  = TBLimper_Pre_Aprobado.Codigo_Estado_de_Accion),''),
			'Estado' = ISNULL((SELECT Descripcion FROM  ESTADO_DE_INFORMACION WHERE Codigo_Estado_de_Informacion  = TBLimper_Pre_Aprobado.Codigo_Estado_de_Informacion), '') 
			
    FROM TBLimper_Pre_Aprobado
    WHERE cartera = @Cartera
    ORDER BY Instrumento   

END
	ELSE BEGIN
		SELECT 'ERROR'
	END  

SET NOCOUNT OFF

END



--Sp_Carga_Plazos_Permanencia_preaprovado 1

--select * from TBLimper_Pre_Aprobado



--SELECT Descripcion,* FROM ESTADO_DE_ACCION
-- Base de Datos --
GO
