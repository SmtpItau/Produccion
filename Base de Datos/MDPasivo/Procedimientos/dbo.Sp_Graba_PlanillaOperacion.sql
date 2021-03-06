USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Graba_PlanillaOperacion]    Script Date: 16-05-2022 11:18:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_Graba_PlanillaOperacion]
      (
            @CODIGO_PRODUCTO		VARCHAR(5)
        ,   @MONEDA                  	CHAR(3)
        ,   @VCTO_FISICO             	CHAR(1)
        ,   @TIP_OPE                 	CHAR(1)
        ,   @TIP_CLI                 	NUMERIC(5)
        ,   @COD_COM                 	CHAR(6)
--      ,   @COD_CON                 	CHAR(3)
        ,   @CONDICION               	VARCHAR(10)
	,   @NACIONALIDAD	    	NUMERIC(1) --JSPP 26/11/2004 MODIFICACION EN LOS CODIGOS DE COMERCIO PARA PLANILLAS AUTOMATICAS
	,   @id_sistema			CHAR(3) ='BCC'
      )
AS
BEGIN
SET NOCOUNT ON
SET DATEFORMAT dmy

     IF NOT EXISTS ( SELECT 1 FROM CODIGO_PLANILLA_AUTOMATICA
                              WHERE   codigo_producto         =   @CODIGO_PRODUCTO
                              AND     tipo_cliente            =   @TIP_CLI
                              AND     tipo_operacion          =   @TIP_OPE
                              AND     codigo_moneda           =   @MONEDA
                              AND     vencimiento_fisico      =   @VCTO_FISICO
                              AND     nacionalidad	      =   @NACIONALIDAD
			      AND     id_sistema	      =   @id_sistema 	--JSPP 26/11/2004
                  )
     BEGIN

             INSERT INTO CODIGO_PLANILLA_AUTOMATICA
                  (   codigo_producto 
                  ,   codigo_moneda
                  ,   vencimiento_fisico
                  ,   tipo_operacion
                  ,   tipo_cliente
                  ,   comercio
--                  ,   concepto
                  ,   condicion
		  ,   id_sistema	
		  ,   nacionalidad 					--JSPP 26/11/2004
                  )
             VALUES
                  (   @CODIGO_PRODUCTO
                  ,   @MONEDA
                  ,   @VCTO_FISICO
                  ,   @TIP_OPE
                  ,   @TIP_CLI
                  ,   @COD_COM
--                  ,   @COD_CON
                  ,   @CONDICION
		  ,   @id_sistema		
		  ,   @NACIONALIDAD 							--JSPP 26/11/2004
                  )

             IF @@error <> 0 
             BEGIN
                  SELECT -1, '¡ No se puede Agregar esta Condición ... !'
                  RETURN
             END ELSE
             BEGIN
                  SELECT 0, '¡ Grabación Exitosa ... !'
                  RETURN 
             END

     END ELSE
     BEGIN
     

             UPDATE CODIGO_PLANILLA_AUTOMATICA   
             SET --   	codigo_moneda           =   @MONEDA
---            ,      	vencimiento_fisico      =   @VCTO_FISICO
                      	comercio                =   @COD_COM
--             ,      	concepto                =   @COD_CON
             ,        	condicion               =   @CONDICION
	     ,        	nacionalidad	        =   @NACIONALIDAD 			--JSPP 26/11/2004
             WHERE  	codigo_producto         =   @CODIGO_PRODUCTO
             AND    	tipo_cliente            =   @TIP_CLI
             AND    	tipo_operacion          =   @TIP_OPE
             AND    	codigo_moneda           =   @MONEDA
             AND    	vencimiento_fisico      =   @VCTO_FISICO
	     AND    	nacionalidad       	=   @NACIONALIDAD 			--JSPP 26/11/2004
	     AND        id_sistema		=   @id_sistema	

             IF @@error <> 0 
             BEGIN
                  SELECT -1, ' ¡ No se puede Actualizar esta Condición ... !'
                  RETURN
             END ELSE
             BEGIN
                  SELECT 0, '¡ Actualización Exitosa ... !'
                  RETURN 
             END
     END

SET NOCOUNT OFF

END





GO
