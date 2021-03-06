USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_OVERNIGHT_GRABA]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_OVERNIGHT_GRABA]
            (
               @MOENTIDAD            numeric(9)   ,--ENTIDAD
               @MOTIPMER             CHAR(4)      ,--TIPO MERCADO
               @MOTIPOPE             CHAR(1)      ,--TIPO OPERACION
               @MORUTCLI             NUMERIC(10)  ,--RUT CLIENTE
               @MOCODCLI             NUMERIC(10)  ,--CODIGO CLIENTE
               @MONOMCLI             CHAR(35)     ,--NOMBRE CLIENTE
               @MOMONMO              NUMERIC(19,4),--MONTO MONEDA ORIGEN
               @MOTICAM              NUMERIC(19,4),--OBSERVADO
               @MOTCTRA              NUMERIC(19,4),--TASA
               @MOUSS30              NUMERIC(19,3),--MONTO FINAL
               @MOMONPE              NUMERIC(19,3),--MONTO EN PESOS   SELECT * FROM MEMOH
               @MOENTRE              NUMERIC(3)   ,--ENTRAGAMOS
               @MORECIB              NUMERIC(3)   ,--RECIBIMS
               @MOVALUTA1            DATETIME     ,--VALUTA ENTREGAMOS
               @MOVALUTA2            DATETIME     ,--VALUTA RECIBIMOS
               @MOVAMOS              NUMERIC(1)   ,--RETIRO DE DOCUMENTOS      
               @MOOPER               CHAR(10)     ,--OPERADOR USUARIO
               @MOFECH               DATETIME     ,--FECHA INGRESO OPERACION
               @MOHORA               CHAR(8)      ,--HORA 
               @MOTERM               CHAR(12)     ,--TERMINAL
               @CASA_MATRIZ          NUMERIC(3)   , --PAIS
               @CONTABILIZA          CHAR(1)      ,
               @SISTEMA              CHAR(5)      ,
               @DIAS                 NUMERIC(9)   ,
               @COD_OMA              NUMERIC(5)   ,
               @CLIENTE				 INT=0
            )
AS
BEGIN
SET NOCOUNT ON
   BEGIN TRANSACTION
   DECLARE @CODIGO_AREA        VARCHAR(5)
   DECLARE @CODIGO_COMERCIO    CHAR(6)
   DECLARE @CODIGO_CONCEPTO    CHAR(3)
   DECLARE @MOCODMON           CHAR(3)      
   DECLARE @MOCODCNV           CHAR(3)      
   DECLARE @OBSERV             NUMERIC(19,4)   
   DECLARE @NUMOPE             CHAR(4)
   DECLARE @PARIDADES        FLOAT
   
   SELECT @PARIDADES = ( SELECT VMVALOR
      FROM  VIEW_VALOR_MONEDA
                               , MEAC
     WHERE ( VMCODIGO = 999  OR VMCODIGO = 998 )
       AND ( VMFECHA  = ACFECPRO OR VMFECHA = '')  )
   SELECT  @OBSERV = ( SELECT acobser FROM MEAC )
   SELECT  @MOHORA  = CONVERT( CHAR(8), GETDATE() , 108)   
   DECLARE @MONOTUSD   NUMERIC(19,4)
   DECLARE @MONTOCLP   NUMERIC(19,4)
   SELECT  @MONOTUSD =  ( @MOMONMO  * @MOTICAM )
   SELECT  @MONTOCLP =  ( @MONOTUSD * @MOTICAM )
   Set @MOCODMON  =  'USD' /*( SELECT mnnemo FROM VIEW_VALOR_DEFECTO 
                                          , VIEW_MONEDA 
                                      WHERE id_sistema     = @SISTEMA
                                      AND codigo_producto  = @MOTIPMER 
                                      AND codigo_moneda    = mncodmon )*/
   SELECT @MOCODCNV = 'USD' -- @MOCODMON

   IF NOT EXISTS(SELECT 1 FROM BacParamSuda.dbo.CargaOperaciones_DefectoValores
                 WHERE idPlataforma			= @MOTIPMER 
				 AND Default_sCodigoOMA	= @COD_OMA 
				 AND idCliente			= @CLIENTE)
   BEGIN
	   SELECT @CODIGO_AREA = isnull(( SELECT idProducto FROM VIEW_VALOR_DEFECTO_NEW 
												 WHERE idPlataforma			= @MOTIPMER 
													AND Default_sCodigoOMA	= @COD_OMA 
													AND idCliente			= 0),0 )--SE AGREGO CODIGO OMA PARA DISTINGIR EL codigo_area
   END

   ELSE
   BEGIN
	   SELECT @CODIGO_AREA = isnull(( SELECT idProducto FROM VIEW_VALOR_DEFECTO_NEW 
												 WHERE idPlataforma			= @MOTIPMER 
													AND Default_sCodigoOMA	= @COD_OMA 
													AND idCliente			= @CLIENTE),0 )--SE AGREGO CODIGO OMA PARA DISTINGIR EL codigo_area
   END
   	
   IF NOT EXISTS(SELECT 1 FROM BacParamSuda.dbo.CargaOperaciones_DefectoValores
                 WHERE idPlataforma		= @MOTIPMER 
				 AND Default_sCodigoOMA	= @COD_OMA 
				 AND idOperacion		= 1
				 AND idCliente			= @CLIENTE)
   BEGIN
	   SELECT @CODIGO_COMERCIO  = isnull(( SELECT Default_sCodigoComercio FROM VIEW_VALOR_DEFECTO_NEW 
																  WHERE idPlataforma		= @MOTIPMER 
																	AND Default_sCodigoOMA	= @COD_OMA 
																	AND idOperacion			= 1
																	AND idCliente			= 0),0)  --SE AGREGO CODIGO OMA PARA DISTINGIR EL codigo_area                      )
   END

   ELSE
   BEGIN
	   SELECT @CODIGO_COMERCIO  = isnull(( SELECT Default_sCodigoComercio FROM VIEW_VALOR_DEFECTO_NEW 
																  WHERE idPlataforma		= @MOTIPMER 
																	AND Default_sCodigoOMA	= @COD_OMA 
																	AND idOperacion			= 1
																	AND idCliente			= @CLIENTE),0)  --SE AGREGO CODIGO OMA PARA DISTINGIR EL codigo_area                      )

   END	

   IF NOT EXISTS(SELECT 1 FROM BacParamSuda.dbo.CargaOperaciones_DefectoValores
				 WHERE idPlataforma		= @MOTIPMER 
				 AND Default_sCodigoOMA	= @COD_OMA
				 AND idOperacion			= 1
				 AND idCliente			= @CLIENTE)
   BEGIN		
	   SELECT @CODIGO_CONCEPTO  = isnull(( SELECT Default_sCodigoConcepto  FROM VIEW_VALOR_DEFECTO_NEW
																   WHERE idPlataforma		= @MOTIPMER 
																	AND Default_sCodigoOMA	= @COD_OMA
																	AND idOperacion			= 1
																	AND idCliente			= 0),0)--SE AGREGO CODIGO OMA PARA DISTINGIR EL codigo_area)
   END

   ELSE
   BEGIN
	   SELECT @CODIGO_CONCEPTO  = isnull(( SELECT Default_sCodigoConcepto  FROM VIEW_VALOR_DEFECTO_NEW
																   WHERE idPlataforma		= @MOTIPMER 
																	AND Default_sCodigoOMA	= @COD_OMA
																	AND idOperacion			= 1
																	AND idCliente			= @CLIENTE),0)--SE AGREGO CODIGO OMA PARA DISTINGIR EL codigo_area)
	END
                 EXECUTE Sp_Gmovto
                         0
                        ,@MOTIPMER
                        ,@MOTIPOPE
                        ,@MORUTCLI
                        ,@MOCODCLI
                        ,@MONOMCLI
                        ,@MOCODMON
                        ,@MOCODCNV
                        ,@MOMONMO
                        ,@MOTICAM
                        ,@MOTCTRA 
                        ,@PARIDADES
                        ,@PARIDADES
                        ,@MONOTUSD 
                        ,@MOUSS30
                        ,@MONTOCLP
                        ,@MOENTRE
                        ,@MOENTRE
                        ,@MOOPER
                        ,@MOTERM 
                        ,@MOHORA
                        ,@MOFECH 
                        ,@COD_OMA
                        ,''
                        ,0
                        ,@MOVALUTA1
                        ,@MOVALUTA2
                        ,0
                        ,0
						,1
                        ,@OBSERV
                        ,@MOTICAM
                        ,1
						,@SISTEMA
						,@CONTABILIZA
						,''
						,''
						,''
						,''
						,0
						,0
						,0
                        ,0  
                        ,0
                        ,''
                        ,''
                        ,@CODIGO_AREA
                        ,@CODIGO_COMERCIO
                        ,@CODIGO_CONCEPTO
                        ,@CASA_MATRIZ
                        ,@MOUSS30
                        ,@DIAS
                        ,0
                     
 IF @@ERROR <> 0      
            ROLLBACK TRANSACTION
 ELSE
            COMMIT TRANSACTION
   
    SET NOCOUNT OFF
       SELECT @NUMOPE = ( SELECT accorope FROM MEAC )
    RETURN
END 
 
 
 
 
GO
