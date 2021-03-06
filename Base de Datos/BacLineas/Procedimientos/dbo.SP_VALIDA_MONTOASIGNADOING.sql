USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALIDA_MONTOASIGNADOING]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_VALIDA_MONTOASIGNADOING]
   (   		@rut1      				NUMERIC(10,0)
			,@MontoAsignado      	NUMERIC(20,0)
			,@CodCli				NUMERIC(3)		
   )
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @RUTPADRE		AS NUMERIC (10)
	DECLARE @MONTOPADRE		AS NUMERIC (10)
	DECLARE @SOBREMONTO		AS INTEGER
	DECLARE @iSumMontosHijo FLOAT
	DECLARE @nRutHijo		AS NUMERIC(10)
	SET @SOBREMONTO = 0


IF (SELECT TOP 1 Afecta_Lineas_Hijo FROM CLIENTE_RELACIONADO WHERE CLRUT_PADRE = @RUT1 AND clcodigo_padre = @CodCli OR CLRUT_HIJO = @RUT1 AND clcodigo_HIJO = @CodCli) = 1 
BEGIN
IF EXISTS (SELECT 1 FROM CLIENTE_RELACIONADO WHERE CLRUT_PADRE = @RUT1 AND clcodigo_padre = @CodCli)-- AND Afecta_Lineas_Hijo = 1)
	BEGIN
		-->    Obtiene el monto total ocupado de los hijos relacionados
		SET @MONTOPADRE = @MontoAsignado
		SET @nRutHijo = (SELECT TOP 1 CLRUT_HIJO FROM CLIENTE_RELACIONADO WHERE CLRUT_PADRE = @RUT1 AND clcodigo_padre = @CodCli)
        SET @iSumMontosHijo       = ( SELECT SUM( TotalOcupado )
                                       FROM BacLineas.dbo.CLIENTE_RELACIONADO      rc with(nolock)
                                            INNER JOIN BacLineas.dbo.LINEA_GENERAL lg with(nolock) ON rc.clrut_hijo = lg.rut_cliente and rc.clcodigo_hijo = lg.codigo_cliente
                                      WHERE clrut_hijo = @nRutHijo ) --9610200.0000

END ELSE
	BEGIN 
		-->    Obtiene el monto asignado al Padre
		DECLARE @iMontoGeneralPadre   FLOAT
       SET @iMontoGeneralPadre   = ( SELECT TOP 1 TotalAsignado 
                                      FROM BacLineas.dbo.LINEA_GENERAL lg with(nolock)
                                           INNER JOIN (SELECT TOP 1 clrut_padre as nRutPadre, clcodigo_padre as nCodPadre
                                                         FROM BacLineas.dbo.CLIENTE_RELACIONADO with(nolock)
                                                        WHERE clrut_hijo = @rut1 ) grp ON grp.nRutPadre = lg.rut_cliente
                                                                                         and grp.nCodPadre = lg.Codigo_Cliente ) --100000000.0000

		SET @MONTOPADRE = @iMontoGeneralPadre
        SET @iSumMontosHijo       = ( SELECT SUM( TotalOcupado )
                                       FROM BacLineas.dbo.CLIENTE_RELACIONADO      rc with(nolock)
                                            INNER JOIN BacLineas.dbo.LINEA_GENERAL lg with(nolock) ON rc.clrut_hijo = lg.rut_cliente and rc.clcodigo_hijo = lg.codigo_cliente
                                      WHERE clrut_hijo = @rut1 ) --9610200.0000

		
	END
   SET @SOBREMONTO = 0
   -->    comparacion de ocupado vs el asignado
   IF NOT @MONTOPADRE > @iSumMontosHijo
   BEGIN
      SET @SOBREMONTO = 1
		SELECT -1 , 'La sumatoria del monto ocupado del o los hijos no puede superar a lo asignado al Padre'
      			RETURN
   END
END
END
GO
