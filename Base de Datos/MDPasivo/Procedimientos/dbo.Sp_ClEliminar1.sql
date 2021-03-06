USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_ClEliminar1]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ClEliminar1] (
                                  @clrut1   NUMERIC(9,0) ,
				  @CLCODIGO numeric(9,0)
                                 )
AS
  BEGIN

	SET DATEFORMAT DMY
	SET NOCOUNT ON

--	IF  NOT EXISTS(SELECT morutcli,mocodcli from VIEW_MOVIMIENTO_TRADER 	          WHERE morutcli = @clrut1 AND mocodcli = @clcodigo)
--	AND NOT EXISTS(SELECT morutcli,mocodcli from VIEW_MOVIMIENTO_INVERSION_EXTERIOR   WHERE morutcli = @clrut1 AND mocodcli = @clcodigo)
--	AND NOT EXISTS(SELECT codcli,codigo from VIEW_CARTERA_HISTORICA_TRADER		  WHERE rutcli = @clrut1 AND codcli = @clcodigo)
--	AND NOT EXISTS(SELECT morutcli,mocodcli from VIEW_MOVIMIENTO_CAMBIO		  WHERE morutcli = @clrut1 AND mocodcli = @clcodigo)
--	AND NOT EXISTS(SELECT Rut_Cliente,Codigo_Cliente from LINEA_TRANSACCION		  WHERE Rut_Cliente = @clrut1 AND Codigo_Cliente = @clcodigo)
--	AND NOT EXISTS(SELECT mocodcli,mocodigo	from VIEW_MOVIMIENTO_FORWARD		  WHERE mocodcli = @clrut1 AND mocodigo = @clcodigo)
--	AND NOT EXISTS(SELECT cacodcli,cacodigo	from VIEW_CARTERA_FORWARD_HISTORICA	  WHERE cacodcli = @clrut1 AND cacodigo = @clcodigo)
--	AND NOT EXISTS(SELECT rut_cliente,codigo_cliente from VIEW_MOVIMIENTO_SWAP	  WHERE rut_cliente = @clrut1 AND codigo_cliente = @clcodigo)
--	AND NOT EXISTS(SELECT rut_cliente,codigo_cliente from VIEW_CARTERA_SWAP_HISTORICA WHERE rut_cliente = @clrut1 AND codigo_cliente = @clcodigo)
--	BEGIN

	       DELETE CLIENTE_OPERADOR WHERE oprutcli = @clrut1 and opcodcli = @clcodigo

	       DELETE SINACOFI WHERE clrut = @clrut1 and clcodigo = @clcodigo
		
	       DELETE CLIENTE_APODERADO where aprutcli = @clrut1 and apcodcli = @clcodigo
--
--	       DELETE CORRESPONSAL where rut_cliente = @clrut1 and codigo_cliente = @clcodigo
--	
--	       DELETE  LINEA_ENDEUDAMIENTO_BANCO where rut_cliente = @clrut1 and codigo_cliente = @clcodigo
--
--	       DELETE  LINEA_SISTEMA where rut_cliente = @clrut1 and codigo_cliente = @clcodigo
--
--	       DELETE  LINEA_POR_PLAZO where rut_cliente = @clrut1 and codigo_cliente = @clcodigo
--
--	       DELETE  LINEA_AFILIADO where RutCasaMatriz = @clrut1 and CodigoCasaMatriz = @clcodigo
--
--	       DELETE LINEA_GENERAL where rut_cliente = @clrut1 and codigo_cliente = @clcodigo

	       DELETE  FROM CLIENTE WHERE clrut = @clrut1 and clcodigo = @clcodigo	


--	END ELSE
--	BEGIN
--		SELECT 2,'Cliente no se puede Eliminar, Esta Relacionado'
--	END

  END
GO
