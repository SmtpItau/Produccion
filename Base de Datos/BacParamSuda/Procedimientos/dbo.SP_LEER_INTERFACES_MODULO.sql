USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_INTERFACES_MODULO]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--[SP_LEER_INTERFACES_MODULO] 'BTR'
CREATE PROCEDURE [dbo].[SP_LEER_INTERFACES_MODULO]
	(	@iModulo	CHAR(3)	)          
AS          
BEGIN          
          
	SET NOCOUNT ON

	DECLARE @iValidacion	SMALLINT
		SET @iValidacion	= ISNULL((SELECT TOP 1 ValConsistencia FROM FORMATO_INTERFACES
		                	    WHERE Sistema = @iModulo AND SUBSTRING(Nombre_interfaz, 1, 2) = 'OP' ), 0)

	declare @Ctrl_Intefaz	int
		set @Ctrl_Intefaz	=	isnull((	select	tbvalor
											from	BacParamSuda.dbo.Tabla_General_detalle
											where	tbcateg = 904
											and		nemo	= @iModulo
										), 1)

    SELECT   Sigla        = Nombre_Interfaz          
    ,        Nombre       = Nombre_largo           
    ,        Id           = Id_interfaz        
    ,        Consistencia = @iValidacion --> ISNULL( ValConsistencia, 0)
    ,		 ctrl		  = @Ctrl_Intefaz
    FROM     FORMATO_INTERFACES fi          
    WHERE    Sistema      = @iModulo          
--	AND Id_interfaz IN (8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23)
--	AND Id_interfaz  IN (100)

		UNION

    SELECT   Sigla        = 'CHEQ'          
    ,        Nombre       = 'VALIDACION DE INTERFACES'          
    ,        Id           = 100          
    ,        Consistencia = 0        
	,		 ctrl		  = @Ctrl_Intefaz

    UNION

    SELECT  Sigla         = 'FDIA'          
    ,       Nombre        = 'FIN DE DÍA'          
    ,       Id            = 101         
    ,       Consistencia  = 0         
    ,		ctrl		  = @Ctrl_Intefaz
    ORDER 
	BY		Id_interfaz          

END
GO
