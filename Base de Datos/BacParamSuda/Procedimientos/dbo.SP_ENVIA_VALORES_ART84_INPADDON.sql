USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ENVIA_VALORES_ART84_INPADDON]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_ENVIA_VALORES_ART84_INPADDON]
(   
	@ID_TICKET          	INT
,   @RUT_CLIENTE        	DECIMAL(10,0)
,   @CODIGO_CLIENTE     	INT
,	@MONTO              	DECIMAL(18,0)
,   @PLAZO              	INT
,   @SISTEMA            	VARCHAR(6)
,   @COD_MONEDA         	VARCHAR(4)
,	@CLASIFICACION_MONEDA	VARCHAR(10)
,	@TIPO_DE_CAMBIO_MON		NUMERIC(21,4)
,	@TIPO_DE_CAMBIO_USD		NUMERIC(21,4)
,   @CODIGOPRODUCTO     	VARCHAR(20)
,	@RIESGO_NORMATIVO		INT
,	@CANASTA1				NUMERIC(21,4)
,	@CANASTA2				NUMERIC(21,4)
,	@MONTO_ADDON			NUMERIC(21,4)
,	@FECHADEPROCESO			DATETIME
,   @MTM                	DECIMAL(18,0)
,	@MONTO_AFECTO			DECIMAL(18,0)
)


AS
BEGIN

SET NOCOUNT ON


DECLARE @MONTO_SALIDA DECIMAL(18,0)



	/*-----------------------------------------------------------------*/ 
    /*-----------------------------------------------------------------*/
	/* REGISTRO POR CALCULO DE ADDON                                   */
	/*-----------------------------------------------------------------*/
	/*-----------------------------------------------------------------*/
	 INSERT INTO BacParamSuda.dbo.TBL_ART84_INPADDON
	  SELECT
	  @ID_TICKET
	 ,@RUT_CLIENTE         
	 ,@CODIGO_CLIENTE       
	 ,@MONTO                        
	 ,@PLAZO               
     ,@SISTEMA             
	 ,@COD_MONEDA           
	 ,ISNULL(@CLASIFICACION_MONEDA,'')          
	 ,ISNULL(@TIPO_DE_CAMBIO_MON,0)  
     ,ISNULL(@TIPO_DE_CAMBIO_USD,0)  
	 ,@CODIGOPRODUCTO       
	 ,ISNULL(@RIESGO_NORMATIVO,0)      
	 ,ISNULL(@CANASTA1,0)
	 ,ISNULL(@CANASTA2,0)           
     ,ISNULL(@MONTO_ADDON,0)
	 ,@FECHADEPROCESO
	 ,@MTM 
	 ,@MONTO_AFECTO


	/*-----------------------------------------------------------------*/ 
    /*-----------------------------------------------------------------*/
	/* SALIDA DE DATOS                                                 */
	/*-----------------------------------------------------------------*/
	/*-----------------------------------------------------------------*/
	 SELECT @MONTO_SALIDA AS MONTO_ADDON
	       ,@MONTO_AFECTO AS MONTO_AFECTO



  SET NOCOUNT OFF
END

GO
