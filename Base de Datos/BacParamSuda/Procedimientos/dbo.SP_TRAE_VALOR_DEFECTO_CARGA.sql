USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAE_VALOR_DEFECTO_CARGA]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_TRAE_VALOR_DEFECTO_CARGA](
    @PRODUCTO        SMALLINT,
    @OPERACION       SMALLINT,
    @MONEDA1         SMALLINT,
    @MONEDA2         SMALLINT,
    @PLATAFORMA      SMALLINT,
    @RUT_CLIENTE     VARCHAR(15)
)
AS
BEGIN
	SELECT b.Default_sModalidad,	--1
	       b.Default_iFormaPagoMN,	--2
	       b.Default_iFormaPagoMX,	--3
	       b.Default_iCodCorresponsal,	--4
	       b.Default_iCodCorresponsal_Desde,	--5
	       b.Default_iCodCorresponsal_Donde,	--6
	       b.Default_iCodCorresponsal_Quien,	--7
	       b.Default_iPL_Corres_Desde,	--8
	       b.Default_iPL_Corres_Donde,	--9
	       b.Default_iPL_Corres_Quien,	--10
	       b.Default_sCodigoComercio,	--11
	       b.Default_sCodigoOMA,	--12
	       b.Default_sCodigoConcepto,	--13
	       b.Default_sCodigoUsuario,	--14
	       b.Default_sCodAreaResponable,	--15
	       b.Default_sCodCartNormativa,	--16
	       b.Default_sCodSubCartNormativa,	--17
	       b.Default_sCodigoLibro,	--18
	       b.Default_iCodidogCartera,	--19
	       b.Default_iCodigoBroker,	--20
	       b.Default_iTipRetiro --21
	FROM   dbo.CargaOperaciones_DefectoValores b
	WHERE  b.idProducto = @PRODUCTO
	       AND b.idOperacion = @OPERACION
	       AND b.idMoneda1 = @MONEDA1
	       AND b.idMoneda2 = @MONEDA2
	       AND b.idPlataforma = @PLATAFORMA
	       AND b.idCliente = @RUT_CLIENTE
END

 

 

 

 

GO
