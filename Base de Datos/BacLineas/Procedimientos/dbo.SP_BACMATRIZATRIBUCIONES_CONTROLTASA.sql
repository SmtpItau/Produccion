USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_BACMATRIZATRIBUCIONES_CONTROLTASA]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BACMATRIZATRIBUCIONES_CONTROLTASA]
         (
            @iFlag                 CHAR   (01)          ,
            @iSistema              CHAR   (03)		,
            @iCodigo_producto      CHAR   (05)		,   
            @iFormaPago            NUMERIC(03) = 0	,
            @iMoneda               NUMERIC(05) = 0	,
            @iDesde                NUMERIC(09) = 0	,
            @iHasta                NUMERIC(09) = 0	,
            @iTasaMin              FLOAT       = 0      ,
            @iTasaMax              FLOAT       = 0      ,
	    @nInstancia		   NUMERIC(1)  = 0      ,
	    @iPorcentaje	   FLOAT       = 0
         )
AS 
BEGIN
 SET NOCOUNT ON


IF @iFlag = 'I'
BEGIN
	IF @nInstancia = 1
	BEGIN
		DELETE
	   	  FROM LINEA_TASA
          	 WHERE Id_Sistema        = @iSistema
	    	   AND Codigo_Producto   = @iCodigo_producto
	    	   AND codigo        	 = @iFormaPago
	    	   AND mncodmon          = @iMoneda
	END

		INSERT INTO LINEA_TASA 
		SELECT @iSistema
            	,      @iCodigo_producto
            	,      @iFormaPago
            	,      @iMoneda
            	,      @iDesde
            	,      @iHasta
            	,      @iTasaMin
            	,      @iTasaMax
            	,      @iPorcentaje
	 	 SELECT 0,'Grabacion Correcta'
		 RETURN
 END

IF @iFlag = 'B'
 BEGIN
	SELECT Plazo_Desde 
	,      Plazo_Hasta
	,      Porcentaje_Minima
	,      Porcentaje_Maximo
	,      TasaSuper 
	  FROM LINEA_TASA
         WHERE Id_Sistema        = @iSistema
	   AND Codigo_Producto   = @iCodigo_producto
	   AND codigo        	 = @iFormaPago
	   AND mncodmon          = @iMoneda
	ORDER BY Plazo_Desde
	,	 Plazo_Hasta
	RETURN
 END
IF @iFlag = 'E' 
 BEGIN

	 DELETE
	   FROM LINEA_TASA
          WHERE Id_Sistema        = @iSistema
	    AND Codigo_Producto   = @iCodigo_producto
	    AND codigo        	  = @iFormaPago
	    AND mncodmon          = @iMoneda
	 SELECT 0,'Eliminacion Correcta'
	 RETURN
 END

 SET NOCOUNT OFF
END
GO
