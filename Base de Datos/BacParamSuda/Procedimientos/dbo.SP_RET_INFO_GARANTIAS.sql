USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RET_INFO_GARANTIAS]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_RET_INFO_GARANTIAS]
	(
		@TipoGar CHAR(1),
		@Folio NUMERIC(10)
	)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @hayTblGtia INTEGER

	SELECT  @hayTblGtia = 0

	--- Validar que existan las tablas de Garantías

	IF EXISTS(SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[tbl_mov_garantia_detalle]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
		SELECT @hayTblGtia = @hayTblGtia + 1

	IF EXISTS(SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[tbl_mov_garantia]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
		SELECT @hayTblGtia = @hayTblGtia + 1

	IF EXISTS(SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[tbl_Garantias_Otorgadas_Detalle]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
		SELECT @hayTblGtia = @hayTblGtia + 1

	IF EXISTS(SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[tbl_Garantias_Otorgadas]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
		SELECT @hayTblGtia = @hayTblGtia + 1

	IF @hayTblGtia = 4
	BEGIN
		CREATE TABLE #tmpGtiasAsoc(
			TipoGtia	CHAR(1),
			NumeroGtia	NUMERIC(18),
			Rut_Cliente	NUMERIC(9),
			Cod_Cliente	NUMERIC(5),
			NomCliente	VARCHAR(50),
			Fecha		DATETIME,
			FechaVigencia	DATETIME,
			ValorPresente	NUMERIC(18),
			AsocOper	CHAR(1)	
			)
		IF @TipoGar = 'C'
		BEGIN
			INSERT INTO #tmpGtiasAsoc(
			TipoGtia,
			NumeroGtia,
			Rut_Cliente,
			Cod_Cliente,
			NomCliente,
			Fecha,
			FechaVigencia,
			ValorPresente,
			AsocOper)

			SELECT
			'C',
			enc.NumeroOperacion,
			RutCliente,
			CodCliente,
			cl.clnombre,
			Fecha,
			FechaVigencia,
			tdet.sumValorPresente,
			'N'
			FROM BacParamsuda.dbo.tbl_mov_garantia enc
			INNER JOIN BacParamsuda.dbo.CLIENTE cl
			ON cl.clRut = RutCliente AND cl.clcodigo = CodCliente
			INNER JOIN (SELECT det.NumeroOperacion,
				    SUM(det.ValorPresente) AS sumValorPresente
				    FROM BacParamSuda.dbo.tbl_mov_garantia_detalle det
				    WHERE det.NumeroOperacion = @Folio
				    GROUP BY det.NumeroOperacion ) tdet	
			ON tdet.NumeroOperacion = @Folio
			WHERE enc.NumeroOperacion = @Folio

			UPDATE #tmpGtiasAsoc
			SET AsocOper = 'S'
			WHERE EXISTS(SELECT NumeroGarantia FROM BacParamSuda.dbo.tbl_gar_AsociacionGtia
						WHERE NumeroGarantia = @Folio 
						AND Rut_Cliente = RutCliente 
						AND Cod_Cliente = CodCliente)
		END
		ELSE
		BEGIN
			INSERT INTO #tmpGtiasAsoc(
			TipoGtia,
			NumeroGtia,
			Rut_Cliente,
			Cod_Cliente,
			NomCliente,
			Fecha,
			FechaVigencia,
			ValorPresente,
			AsocOper)

			SELECT 
			'O',
			go.Folio,
			RutCliente,
			CodCliente,
			cl.clnombre,
			Fecha,
			FechaVigencia,
			tdet.sumValorPresente,
			'N'
			FROM Bacparamsuda.dbo.tbl_Garantias_Otorgadas go

			INNER JOIN BacParamsuda.dbo.CLIENTE cl
			ON cl.clRut = RutCliente AND cl.clcodigo = CodCliente
			INNER JOIN (SELECT det.Folio,
				    SUM(det.ValorPresente) AS sumValorPresente
				    FROM BacParamSuda.dbo.tbl_Garantias_Otorgadas_detalle det
				    WHERE det.Folio = @Folio
				    GROUP BY det.Folio ) tdet	
			ON tdet.Folio = @Folio
			WHERE go.Folio = @Folio

			--- Ver si existe la tabla que relaciona Ventas Cortas con Garantías
			IF EXISTS(SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[tbl_relacion_VentaCorta_Garantias]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
			BEGIN
				--- Ver si la Garantía está asociada a una Venta Corta
				UPDATE #tmpGtiasAsoc
				SET AsocOper = 'S'
				FROM BacParamsuda.dbo.tbl_relacion_VentaCorta_Garantias vg
				WHERE NumeroGtia = vg.FolioGtia
				AND Rut_Cliente = vg.RutCliente
				AND Cod_Cliente = vg.CodCliente
			END
		END
	END

	SELECT * FROM #tmpGtiasAsoc

	SET NOCOUNT OFF
END
GO
