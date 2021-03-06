USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_CAMBIO_CARTERA]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_CAMBIO_CARTERA]
(
	@nNumOper		as numeric(10)
,	@nCodCartera	as numeric(2)
,	@sSistema		as VARCHAR(3)
,	@Rut_Origen		AS VARCHAR(155) = ''
,	@Nombre_Origen	AS VARCHAR(155) = ''
,	@Rut_Destino	AS VARCHAR(155) = ''
,	@Nombre_Destino	AS VARCHAR(155) = ''
,	@NOVACION		AS INTEGER	= 0
)
AS
BEGIN
	set nocount on
	IF @NOVACION = 0 
	BEGIN
		IF @sSistema = 'PCS'
		BEGIN
			if EXISTS ( select 1 from BacSwapSuda.dbo.CARTERA where numero_operacion = @nNumOper) 
			BEGIN
				update BacSwapSuda.dbo.CARTERA
				set cartera_inversion = @nCodCartera
				where numero_operacion = @nNumOper
			END ELSE
			BEGIN
				SELECT -1, 'N° Operacion no se encuentra'
				RETURN
			END
		END
		IF @sSistema = 'BFW'
		BEGIN
			if EXISTS (SELECT 1 FROM BacFwdSuda.dbo.MFCA WHERE canumoper = @nNumOper) 
			BEGIN
				update BacFwdSuda.dbo.MFCA
				set cacodcart = @nCodCartera
				where canumoper = @nNumOper
			END ELSE
			BEGIN
				SELECT -1, 'N° Operacion no se encuentra'
				RETURN
			END
		END	
	END
	IF @NOVACION = 1
	BEGIN
	    declare @fechaProceso datetime
		select  @fechaProceso = acfecproc  from bacfwdsuda.dbo.mfac
		INSERT INTO dbo.TBL_MODIFICACIAONES   -- select * from TBL_MODIFICACIAONES where FechaModificacion = '20150623' and foliocontrato = 594720
		SELECT	FechaModificacion	= @fechaProceso -- CONVERT(CHAR(8),GETDATE(),112)  
			,	Modulo				= @sSistema --@nCodCartera 
			,	FolioContrato		= @nNumOper
			,	FolioCotizacion		= @nNumOper 
			,	FolioModificacion	= 1 
			,	Correlativo			= 1
			,	Items				= 'RUT' 
			,	DatosOriginales		= @Rut_Origen 
			,	DatosNuevos			= @Rut_Destino 			
			
		INSERT INTO dbo.TBL_MODIFICACIAONES
		SELECT	FechaModificacion	= @fechaProceso --CONVERT(CHAR(8),GETDATE(),112) 
			,	Modulo				= @sSistema --@nCodCartera 
			,	FolioContrato		= @nNumOper
			,	FolioCotizacion		= @nNumOper 
			,	FolioModificacion	= 1 
			,	Correlativo			= 2
			,	Items				= 'NOMBRE' 
			,	DatosOriginales		= @Nombre_Origen 
			,	DatosNuevos			= @Nombre_Destino 	
			
		INSERT INTO dbo.TBL_MODIFICACIAONES
		SELECT	FechaModificacion	= @fechaProceso --CONVERT(CHAR(8),GETDATE(),112) 
			,	Modulo				= @sSistema --@nCodCartera 
			,	FolioContrato		= @nNumOper
			,	FolioCotizacion		= @nNumOper 
			,	FolioModificacion	= 1 
			,	Correlativo			= 3
			,	Items				= 'NOVACION' 
			,	DatosOriginales		= 'ES NOVACION'
			,	DatosNuevos			= 'ES NOVACION' 			
	END
	
END


/*
SP_CAMBIO_CARTERA 591559, 0, 'BFW', '76123477-3', 'FONDO DE INVERSION PRIVADO RED SOCIAL', '76123478-1', 'FONDO DE INVERSION PRIVADO CCHC-C', 1

*/

GO
