USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACTUALIZA_THRESHOLD_MOVIMIENTOS]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--BACPARAMSUDA.dbo.SP_ACTUALIZA_THRESHOLD_MOVIMIENTOS 'PCS', 2, 8822, 'N'

CREATE PROCEDURE [dbo].[SP_ACTUALIZA_THRESHOLD_MOVIMIENTOS]
   (   @Sistema           CHAR(3)
   ,   @CodProducto	  NUMERIC(5)
   ,   @Numero_Operacion  NUMERIC(9)
   ,   @NuevoEstado	  CHAR(1)
   )
AS
BEGIN

   SET NOCOUNT ON

   	--> Para determinar si la operación fue generada en Chile o en NY --
	DECLARE @EsOperacionNY as varchar(2)
	set @EsOperacionNY = 'No'
	IF exists (select 1 from BacSwapNY..cartera where numero_operacion = @Numero_Operacion)
				set @EsOperacionNY = 'Si'

	IF exists (select 1 from BacFWDNY..cartera where canumoper = @Numero_Operacion)
				set @EsOperacionNY = 'Si'

	IF @EsOperacionNY = 'No'
		begin	

			   IF @Sistema = 'PCS'
			   BEGIN
					  UPDATE BacSwapSuda.dbo.MOVDIARIO
					  SET    Threshold        = @NuevoEstado
					  WHERE  numero_operacion = @Numero_Operacion

					  UPDATE BacSwapSuda.dbo.CARTERA
					  SET    Threshold        = @NuevoEstado
					  WHERE  numero_operacion = @Numero_Operacion
				END

			   IF @Sistema = 'BFW'
			   BEGIN
				  UPDATE BacFwdSuda.dbo.MFMO
				  SET    Threshold = @NuevoEstado
				  WHERE  monumoper = @Numero_Operacion

				  UPDATE BacFwdSuda.dbo.MFCA
				  SET    Threshold = @NuevoEstado
				  WHERE  canumoper = @Numero_Operacion

				  UPDATE BacFwdSuda.dbo.MFCA
				  SET    Threshold     = 'N'
				  FROM   BacFwdSuda.dbo.MFMO mov
				  WHERE  canumoper     = mov.monumoper
				  AND    mov.Threshold = ''

				  UPDATE BacFwdSuda.dbo.MFMO
				  SET    Threshold     = 'N'
				  WHERE  Threshold     = ''
			   END
	END


	IF @EsOperacionNY = 'Si'
		begin	

			   IF @Sistema = 'PCS'
			   BEGIN
					  UPDATE BacSwapNY.dbo.MOVDIARIO
					  SET    Threshold        = @NuevoEstado
					  WHERE  numero_operacion = @Numero_Operacion
					   
					  UPDATE BacSwapNY.dbo.CARTERA
					  SET    Threshold        = @NuevoEstado
					  WHERE  numero_operacion = @Numero_Operacion
				END

			   IF @Sistema = 'BFW'
			   BEGIN
				  UPDATE BacFWDNY.dbo.MFMO
				  SET    Threshold = @NuevoEstado
				  WHERE  monumoper = @Numero_Operacion

				  UPDATE BacFWDNY.dbo.MFCA
				  SET    Threshold = @NuevoEstado
				  WHERE  canumoper = @Numero_Operacion

				  UPDATE BacFWDNY.dbo.MFCA
				  SET    Threshold     = 'N'
				  FROM   BacFwdSuda.dbo.MFMO mov
				  WHERE  canumoper     = mov.monumoper
				  AND    mov.Threshold = ''

				  UPDATE BacFWDNY.dbo.MFMO
				  SET    Threshold     = 'N'
				  WHERE  Threshold     = ''
			   END
	END


   SELECT 0, 'OK'

   RETURN
END

GO
