USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_CODIGOS_COMERCIO]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_LEER_CODIGOS_COMERCIO] (
                                            @Comercio  CHAR(6),
                                            @Concepto  CHAR(3),
					    @NewCodigo CHAR(5)
                                           )
AS
BEGIN

	DECLARE  @oma NUMERIC(03)
		,@td  NUMERIC(03)

        
        SET NOCOUNT ON
	IF LEN(@comercio) = 3 BEGIN
           SELECT @oma = CONVERT(NUMERIC(03),RTRIM(@Comercio)) 
           SELECT @td  = CONVERT(NUMERIC(03),RTRIM(@Concepto))
         
		SELECT 	'fecha' = CONVERT(CHAR(8),fecha,112), 
			comercio      , 
			concepto      , 
			glosa         , 
			tipo_documento, 
			codigo_OMA    ,
			estadistica   ,
			ventanas      ,
			pais_remesa   ,
			rut_bcch      ,
       		         codigo_relacion
		FROM 	Codigo_Comercio
		WHERE 	(@oma  = codigo_OMA) 	AND
			(@td   = tipo_documento)

        END
        ELSE BEGIN
        
		SELECT 	'fecha' = CONVERT(CHAR(8),fecha,112), 
			comercio      , 
			concepto      , 
			glosa         , 
			tipo_documento, 
			codigo_OMA    ,
			estadistica   ,
			ventanas      ,
			pais_remesa   ,
			rut_bcch      ,
       	        	 codigo_relacion
		FROM 	Codigo_Comercio
		WHERE 	(@Comercio  = '' OR @Comercio  = comercio ) 	AND
			(@Concepto  = '' OR @Concepto  = concepto )	AND
			(@NewCodigo = '' OR @NewCodigo = codigo_relacion ) 
	END
END
-- SP_HELP CODIGO_COMERCIO 
GO
