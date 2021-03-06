USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_TIPO_OPERACION_SPOT]    Script Date: 16-05-2022 11:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SP_ACT_TIPO_OPERACION_SPOT]
                    (
                         @codigo                   NUMERIC( 1) , -- 1		
			 @Glosa                    CHAR(   25) , -- 2
                         @Afecta_Posicion_Contable CHAR(    1) , -- 3
                         @Afecta_Descalce_Tc       CHAR(    1) , -- 4
                         @Codigo_Producto          CHAR(    5) , -- 5
			 @afecta_contable	   CHAR(    1) , -- 6
			 @afecta_cod_comercio	   CHAR(    1)   -- 7
                     )	
AS
BEGIN

SET DATEFORMAT dmy
SET NOCOUNT ON

	
	IF EXISTS(SELECT 1
		  FROM   PRODUCTO_DESCALCE
		  WHERE  Codigo = @Codigo )
	
	BEGIN	

	   UPDATE PRODUCTO_DESCALCE
	   SET    Glosa                     = @Glosa                   
           ,      Afecta_Posicion_Contable  = @Afecta_Posicion_Contable
           ,      Afecta_Descalce_Tc        = @Afecta_Descalce_Tc 
           ,      Codigo_Producto           = @Codigo_Producto    
	   ,	  afecta_contable	    = @afecta_contable
	   ,	  codigo_comercio	    = @afecta_cod_comercio
           WHERE  Codigo                    = @Codigo 

           SELECT 'MOD'
	
	
	END
        ELSE
        BEGIN
	  	
	   INSERT INTO PRODUCTO_DESCALCE 
                     (
                          Codigo                    , -- 1		
			  Glosa                     , -- 2
                          Afecta_Posicion_Contable  , -- 3
                          Afecta_Descalce_Tc        , -- 4
                          Codigo_Producto           , -- 5 
			  afecta_contable	    , -- 6
			  codigo_comercio	      -- 7
 		     )	
	  VALUES                     (
                         @codigo                    , -- 1		
			 @Glosa                     , -- 2
                         @Afecta_Posicion_Contable  , -- 3
                         @Afecta_Descalce_Tc        , -- 4
                         @Codigo_Producto           , -- 5 
			 @afecta_contable	    , -- 6
			 @afecta_cod_comercio	      -- 7
 		     )
            
           SELECT 'SI' 	

	END   

END

-- SELECT * FROM PRODUCTO_DESCALCE

GO
