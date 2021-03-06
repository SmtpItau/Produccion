USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_DEFECTO_CLIENTE_CONTRATO_DERIVADOS]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_ACT_DEFECTO_CLIENTE_CONTRATO_DERIVADOS]
	(	@RUT_CLIENTE	NUMERIC(9)
	,	@CODIGO_CLIENTE	INTEGER ) 
AS BEGIN

        SET NOCOUNT ON
        DECLARE @PCS_ERR INT 
              , @BFW_ERR INT

        SET @BFW_ERR = 0
        SET @BFW_ERR = 0 

        IF NOT EXISTS (SELECT 1 FROM TBL_CLIENTE_CONTRATO_DERIVADOS WHERE Cod_Sistema ='PCS' AND  Rut_Cliente = @RUT_CLIENTE AND Codigo_Cliente = @CODIGO_CLIENTE)        
        BEGIN   


           INSERT INTO TBL_CLIENTE_CONTRATO_DERIVADOS(  Cod_Sistema
                                                       , Rut_Cliente
                                                       , Codigo_Cliente
                                                       , Cod_Dcto_Princ
                                                       , Codigo)
            SELECT  Sistema
            ,       @RUT_CLIENTE
            ,       @CODIGO_CLIENTE
            ,       Codigo  
	    ,	    Codigo
            FROM	TBL_DCTOS_CONTRATOS_DERIVADOS 
            WHERE   sistema	= 'PCS'
            AND     Default_SWAP	= 'S'
  
            INSERT INTO TBL_CLIENTE_CONTRATO_DERIVADOS(  Cod_Sistema
                                                       , Rut_Cliente
                                                       , Codigo_Cliente
                                                       , Cod_Dcto_Princ
                                                       , Codigo)
            SELECT  SISTEMA 
            ,       @RUT_CLIENTE
            ,       @CODIGO_CLIENTE
            ,       TIPO_CONTRATO  
	    ,	    CODIGO_CLAUSULA 
	    FROM    TBL_CLAUSULAS 
	    WHERE   SISTEMA = 'PCS'
	    AND	POR_DEFECTO = 'S'
	    AND	ACTIVA	    = 'S'
            AND	TIPO_CONTRATO IN (SELECT Codigo 
				  FROM	TBL_DCTOS_CONTRATOS_DERIVADOS 
				  WHERE	Sistema = 'PCS'
                                  AND	Default_SWAP = 'S')   

            SET @BFW_ERR = @@ERROR      
      END


      IF NOT EXISTS (SELECT 1 FROM TBL_CLIENTE_CONTRATO_DERIVADOS WHERE Cod_Sistema ='BFW' AND  Rut_Cliente = @RUT_CLIENTE AND Codigo_Cliente = @CODIGO_CLIENTE)        
        BEGIN

            INSERT INTO TBL_CLIENTE_CONTRATO_DERIVADOS(  Cod_Sistema
                                                       , Rut_Cliente
                                                       , Codigo_Cliente
                                                       , Cod_Dcto_Princ
                                                       , Codigo) 
            SELECT  sistema 
            ,       @RUT_CLIENTE
            ,       @CODIGO_CLIENTE
            ,       Codigo  
	    ,	    Codigo
            FROM    TBL_DCTOS_CONTRATOS_DERIVADOS 
            WHERE   sistema		= 'BFW'
            AND     Default_Forward	= 'S'
        

            INSERT INTO TBL_CLIENTE_CONTRATO_DERIVADOS(  Cod_Sistema
                                                       , Rut_Cliente
                                                       , Codigo_Cliente
                                                       , Cod_Dcto_Princ
                                                       , Codigo)        
	    SELECT  SISTEMA 
            ,       @RUT_CLIENTE
            ,       @CODIGO_CLIENTE
       	    ,	    TIPO_CONTRATO  
	    ,	    CODIGO_CLAUSULA 
	    FROM    TBL_CLAUSULAS 
	    WHERE   SISTEMA = 'BFW'
	    AND	    ACTIVA  = 'S'
	    AND	POR_DEFECTO = 'S'
	    AND	TIPO_CONTRATO IN (SELECT Codigo 
				  FROM	TBL_DCTOS_CONTRATOS_DERIVADOS 
				  WHERE	sistema	= 'BFW'
                                  AND     Default_Forward	= 'S')

            SET @PCS_ERR = @@ERROR
       END

       IF @BFW_ERR <> 0 AND  @PCS_ERR <> 0
       BEGIN
            -- COMMIT TRANSACTION
            SELECT '0', 'CONTRATOS EXITOSAMENTE CARGADOS POR DEFECTO AL CLIENTE'           
       END 
       ELSE
       BEGIN
            --ROLLBACK TRANSACTION
            SELECT '1', 'NO ES POSIBLE ASIGNAR CONTRATOS POR DEFECTO AL CLIENTE' 
       END       
       SET NOCOUNT OFF
END
GO
