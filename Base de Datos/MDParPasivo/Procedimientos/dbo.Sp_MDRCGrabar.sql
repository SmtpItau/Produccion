USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_MDRCGrabar]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_MDRCGrabar]
       (

        @Id_Sistema  CHAR(3)        	,
        @nCartera    CHAR(3)        	,
        @cnombre     CHAR(40) 	    	,
	@xcodpro     CHAR(05) = '0'	,
        @ClasifQH    CHAR(1) = ''	,
	@GrupoCartera CHAR (50) 
       )
AS 
BEGIN
DECLARE @CodCarte char (5)
SET NOCOUNT ON
SET DATEFORMAT dmy
SET @CodCarte = (select top 1 Codigo_Grupo_Cartera from TIPO_GRUPO_CARTERA WHERE Descripcion = @GrupoCartera)
   IF EXISTS(
              SELECT       Descripcion
                     FROM  TIPO_CARTERA
                     WHERE Id_Sistema 	       = @Id_Sistema     AND
			   Codigo_Cartera      = @nCartera       AND
                           Codigo_Producto     = @xcodpro        
            ) BEGIN
      UPDATE       TIPO_CARTERA
             SET   Descripcion         = @cnombre,
                   Clasificacion_QH    = @ClasifQH,
		   Codigo_Grupo_Cartera = @CodCarte
             WHERE Id_Sistema          = @Id_Sistema   AND
		   Codigo_Cartera      = @nCartera     AND
                   Codigo_Producto     = @xcodpro        
    END ELSE BEGIN
      INSERT INTO TIPO_CARTERA (
                          Id_Sistema  	    	,
                          Codigo_Producto   	,
                          Codigo_cartera    	,	 
                          Descripcion 	    	,
                          Clasificacion_QH	,
			  Codigo_Grupo_Cartera
                         )
             VALUES      ( 
                          @Id_Sistema,  -- Forward
                          @xcodpro   	,
                          @nCartera  	,
                          @cnombre   	,
                          @ClasifQH	,
			  @CodCarte
                         )
   END
SET NOCOUNT OFF
SELECT 0
END

GO
