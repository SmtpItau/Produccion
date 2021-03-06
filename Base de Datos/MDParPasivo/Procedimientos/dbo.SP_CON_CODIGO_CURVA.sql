USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_CODIGO_CURVA]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[SP_CON_CODIGO_CURVA](@isistema        CHAR(3),
                                    @iProducto       CHAR(5),
                                    @iInstrumento    NUMERIC(5),
                                    @iMoneda         NUMERIC(5),
                                    @iEmisor         NUMERIC(9) = 0 ,
                                    @iGeneric        CHAR(10)   = '' ,
                                    @cEvento	     CHAR(1)   = '',
                                    @iPlazo          NUMERIC(10)=0,
                                    @iTir             NUMERIC(19,4)=0,
                                    @iMoneda2        NUMERIC(5) = 0,
                                    @cTipo_Operacion CHAR(1) = '') 
AS                                                               
BEGIN                                                            

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	SET NOCOUNT ON
	SET DATEFORMAT dmy

	DECLARE @aux NUMERIC(5)

  IF @isistema = 'BFW' OR @isistema = 'BCC' BEGIN
     SELECT @aux = @imoneda
     SELECT @imoneda = @imoneda2
     SELECT @imoneda2  = @aux 
  END     


   IF LEN(@iGeneric) = 0 BEGIN
       SELECT Codigo_Curva  
       FROM RELACION_CURVA  WITH (NOLOCK)
       WHERE Id_Sistema         = @iSistema
       AND   Codigo_Producto    = @iProducto
       AND  ( Codigo_instrumento = @iInstrumento or @iInstrumento = 0)
       AND   Codigo_moneda1     = @iMoneda
       AND  (Codigo_moneda2     = @iMoneda2 or  @iMoneda2 = 0)
       AND   Rut_emisor         = @iEmisor
       AND   Evento	        = @cEvento
       AND  (CASE WHEN rango_por = 'T' then @iTir else @iplazo END) between plazo_desde and plazo_hasta
       AND  (Tipo_Operacion = @cTipo_Operacion or @ctipo_operacion = '')
 
   END ELSE BEGIN
       SELECT Codigo_Curva  
       FROM RELACION_CURVA   WITH (NOLOCK)
       WHERE Id_Sistema         = @iSistema
       AND   Codigo_Producto    = @iProducto
       AND  ( Codigo_instrumento = @iInstrumento or @iInstrumento = 0)
       AND   Codigo_moneda1     = @iMoneda
       AND  (Codigo_moneda2     = @iMoneda2 or  @iMoneda2 = 0)
       AND   Rut_emisor         = (SELECT EMRUT FROM EMISOR  WITH (NOLOCK) WHERE EMGENERIC=@iGeneric)
       AND   Evento	        = @cEvento
       AND  (CASE WHEN rango_por = 'T' then @iTir else @iplazo END) between plazo_desde and plazo_hasta
       AND  (Tipo_Operacion = @cTipo_Operacion or @ctipo_operacion = '')
 
   END
 
END

GO
