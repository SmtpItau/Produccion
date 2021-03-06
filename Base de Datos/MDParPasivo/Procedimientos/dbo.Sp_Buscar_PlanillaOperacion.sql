USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Buscar_PlanillaOperacion]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create PROCEDURE [dbo].[Sp_Buscar_PlanillaOperacion]
      (
            @CODIGO_PRODUCTO         	VARCHAR(5)
        ,   @MONEDA                  	CHAR(3)
        ,   @VCTO_FISICO             	CHAR(1)
        ,   @TIP_OPE                 	CHAR(1)
        ,   @TIP_CLI                 	NUMERIC(5)
        ,   @COD_COM                 	CHAR(6)
--        ,   @COD_CON                 	CHAR(3)
        ,   @CONDICION               	VARCHAR(10)
	,   @NACIONALIDAD	    	NUMERIC(1) --JSPP 26/11/2004 MODIFICACION EN LOS CODIGOS DE COMERCIO PARA PLANILLAS AUTOMATICAS
	,   @id_sistema			CHAR(3) ='BCC'
      )
AS
BEGIN
SET NOCOUNT ON
SET DATEFORMAT dmy

      SELECT comercio , condicion 
      FROM CODIGO_PLANILLA_AUTOMATICA
      WHERE   	codigo_producto		=   @CODIGO_PRODUCTO
      AND     	tipo_cliente		=   @TIP_CLI
      AND     	tipo_operacion		=   @TIP_OPE
      AND     	codigo_moneda		=   @MONEDA
      AND     	vencimiento_fisico	=   @VCTO_FISICO
      AND 	nacionalidad		=   @NACIONALIDAD 	--JSPP 26/11/2004
      AND       id_sistema		=   @id_sistema	
      
SET NOCOUNT OFF

END


GO
