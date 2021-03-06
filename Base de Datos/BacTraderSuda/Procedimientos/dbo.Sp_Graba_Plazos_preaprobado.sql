USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Graba_Plazos_preaprobado]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_Graba_Plazos_preaprobado]
                        (
                             @Cartera            NUMERIC(01,00),
                             @Instrumento        CHAR(10),
                             @Plazo_minimo       NUMERIC(06),
                             @Plazo_maximo       NUMERIC(06),
			     /* mmp  14/08/2009*/
			     @Usuario_Administrativo CHAR(20)   ,
		       	     @Usuario_Supervisor     CHAR(20)   ,
			     @Fecha_de_actualizacion DATETIME   ,  
		       	     @Fecha_de_aprobacion    DATETIME   ,   
		       	     @Codigo_Estado_de_Informacion INT 	,
			     @Codigo_Estado_de_Accion INT 
			)

AS
BEGIN
	
SET NOCOUNT ON

IF @Cartera <> 0 AND @Instrumento <> ''
BEGIN
    IF EXISTS (SELECT * FROM TBLimper_Pre_aprobado WHERE cartera = @Cartera AND instrumento = @Instrumento)
        BEGIN
        UPDATE TBLimper_Pre_aprobado
        SET cartera 			= @cartera ,
	    instrumento 		= @Instrumento,
	    Plazo_minimo 		= @Plazo_minimo,
            Plazo_maximo 		= @Plazo_maximo,
	    Usuario_Administrativo 	= @Usuario_Administrativo,
	    Usuario_Supervisor     	= @Usuario_Supervisor,
	    Fecha_de_actualizacion 	= @Fecha_de_actualizacion, 
	    Fecha_de_aprobacion    	= @Fecha_de_aprobacion,    
	    Codigo_Estado_de_Informacion = @Codigo_Estado_de_Informacion ,
	    Codigo_Estado_de_Accion 	= @Codigo_Estado_de_Accion
        WHERE cartera = @cartera AND instrumento = @Instrumento
    END
    ELSE
    BEGIN
        INSERT TBLimper_Pre_aprobado (Cartera, Instrumento, Plazo_minimo,Plazo_maximo,Usuario_Administrativo,Usuario_Supervisor,Fecha_de_actualizacion,Fecha_de_aprobacion,Codigo_Estado_de_Informacion,Codigo_Estado_de_Accion)
        VALUES          (@Cartera,@Instrumento,@Plazo_minimo,@Plazo_maximo,@Usuario_Administrativo,@Usuario_Supervisor,@Fecha_de_actualizacion,@Fecha_de_aprobacion,@Codigo_Estado_de_Informacion,@Codigo_Estado_de_Accion)
    END

END
--ELSE
--BEGIN

/*Actualiza plazo Residual MDAC*/


--    UPDATE VIEW_MDAC
--    SET acplazoafs = @Plazo_Residual

--END

SET NOCOUNT OFF

END

-- select * from TBLimper_Pre_aprobado

--
-- Base de Datos --
GO
