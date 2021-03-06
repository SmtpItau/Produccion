USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_RELACION_CURVA]    Script Date: 16-05-2022 11:09:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROC [dbo].[SP_ACT_RELACION_CURVA](@iSistema            CHAR(3),
                                      @iCodigo_Producto    CHAR(5),
                                      @iTipo_Operacion     CHAR(1),
                                      @iCodigo_Instrumento NUMERIC(5),
                                      @iCodigo_Moneda1     NUMERIC(3),
                                      @iCodigo_Moneda2     NUMERIC(3),
                                      @iRut_Emisor         NUMERIC(9),
                                      @iCodigo_Emisor      NUMERIC(5),  
 				      @iCodigo_Curva       CHAR(15),
                                      @iPlazo_desde        NUMERIC(10,4),
                                      @iPlazo_Hasta        NUMERIC(10,4),
				      @cEvento		   CHAR(01)  ,
				      @cDefecto		   CHAR(01)  ,
                                      @nRango_Por          CHAR(01) = 'P',
                                      @cArea               CHAR(05) = ' ') 	 
AS
BEGIN



        SET NOCOUNT ON
        SET DATEFORMAT dmy
                
        IF NOT EXISTS(SELECT id_sistema 
                  FROM RELACION_CURVA 
                  WHERE  Id_Sistema      = @iSistema
                  AND    Codigo_Producto = @iCodigo_Producto
                  AND    Tipo_Operacion  = @iTipo_Operacion
                  AND    Codigo_Instrumento = @iCodigo_Instrumento
                  AND    Codigo_Moneda1     = @iCodigo_Moneda1
                  AND    Codigo_Moneda2     = @iCodigo_Moneda2
                  AND    Rut_Emisor         = @iRut_Emisor
                  AND    Codigo_Emisor      = @iCodigo_Emisor
                  AND    Plazo_desde        = @iplazo_desde  
                  AND    Area               = @carea  
                  AND    Evento	   = @cEvento )
        BEGIN
           
             INSERT INTO RELACION_CURVA
             VALUES(@iSistema,
                    @iCodigo_Producto,
                    @iTipo_Operacion,
                    @iCodigo_Instrumento,             
                    @iCodigo_Moneda1,
                    @iCodigo_Moneda2,
                    @iRut_Emisor,
                    @iCodigo_Emisor,
                    @iCodigo_Curva,
                    @iPlazo_desde,
                    @iPlazo_Hasta,
		    @cEvento,
		    @cDefecto,
                    @nRango_por,
                    @cArea   )                    
             
             SELECT 'INSERT'   

        END ELSE BEGIN
             UPDATE RELACION_CURVA  
             SET   Codigo_Curva    = @iCodigo_Curva,
                   plazo_hasta     = @iplazo_hasta,	
		   Defecto	   = @cDefecto,
                   Rango_Por       = @nRango_Por
             WHERE Id_Sistema      = @iSistema
             AND   Codigo_Producto = @iCodigo_Producto
             AND   Tipo_Operacion  = @iTipo_Operacion
             AND   Codigo_Instrumento = @iCodigo_Instrumento
             AND   Codigo_Moneda1     = @iCodigo_Moneda1
             AND   Codigo_Moneda2     = @iCodigo_Moneda2                
             AND   Rut_Emisor         = @iRut_Emisor     
             AND   Codigo_Emisor      = @iCodigo_Emisor
             AND   Plazo_desde        = @iplazo_desde

             SELECT 'UPDATE'

        END



END






GO
