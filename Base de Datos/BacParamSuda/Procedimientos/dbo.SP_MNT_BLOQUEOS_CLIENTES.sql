USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MNT_BLOQUEOS_CLIENTES]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_MNT_BLOQUEOS_CLIENTES]
	(
		 @bTipoCliente	NUMERIC(5,0) = 0	--- Por defecto, Todos
		,@bCliente		NUMERIC(9,0) = 0
		,@bCodigo		INTEGER = 0
		,@modoOperacion	CHAR(1) = 'L'		--- Por defecto, lectura
		,@bTod			CHAR(1) = ''
		,@bFwd			CHAR(1) = ''
		,@bSwp			CHAR(1) = ''
		,@bOpc			CHAR(1) = ''
		,@bSpt			CHAR(1) = ''
		,@bPac			CHAR(1) = ''
		,@bMot			NUMERIC(5,0)=0
	)	
AS
BEGIN
	SET NOCOUNT ON
	IF @modoOperacion = 'L'
	BEGIN
		IF @bCliente = 0
		BEGIN
			--- Todos los Clientes del tipo @bTipoCliente
			CREATE TABLE #tmpBloqueosCltes(
				   clrut		NUMERIC(9,0)
			,      cldv			CHAR(1)
			,      clcodigo		NUMERIC(9,0)
			,      clnombre		CHAR(70)
			,      clgeneric	CHAR(5)
			,      cldirecc		CHAR(40)
			,      clcomuna		NUMERIC(8,0)
			,      clregion		NUMERIC(5,0)
			,      clcompint	NUMERIC(3,0)
			,      cltipcli		NUMERIC(5,0)
			,      clfecingr	DATETIME
			,      clctacte		CHAR(15)
			,      clfono		CHAR(20)
			,      clfax		CHAR(20)
			,      mxcontab		NUMERIC(3,0)
			,      clpais		NUMERIC(5,0)
			,      clciudad		NUMERIC(8,0)
			,      clswift		CHAR(11)
			,	   blqTodos		CHAR(1) NULL DEFAULT 'N'
			,	   blqForward	CHAR(1) NULL DEFAULT 'N'	
			,	   blqSwaps		CHAR(1) NULL DEFAULT 'N'
			,	   blqOpciones	CHAR(1) NULL DEFAULT 'N'
			,	   blqSpot		CHAR(1) NULL DEFAULT 'N'
			,	   blqPactos	CHAR(1) NULL DEFAULT 'N'	
			,	   codMotivo	NUMERIC(5,0) NULL DEFAULT -1
			,	   nomMotivo	VARCHAR(70) NULL DEFAULT ' '	
			)	--- todos los campos de salida de SP_CLIENTESPORTIPO @bTipoCliente,'',0 más los campos de TBL_BLOQUEOS_CLIENTES
			
			--- Tomar primero los que están en TBL_BLOQUEOS_CLIENTES
				INSERT INTO #tmpBloqueosCltes(
				   clrut
			,      cldv
			,      clcodigo
			,      clnombre
			,      clgeneric
			,      cldirecc
			,      clcomuna
			,      clregion
			,      clcompint
			,      cltipcli
			,      clfecingr
			,      clctacte
			,      clfono
			,      clfax
			,      mxcontab
			,      clpais
			,      clciudad
			,      clswift
			)
				EXECUTE SP_CLIENTESPORTIPO @bTipoCliente,'',0

				---Actualizar el temporal con los datos existentes en TBL_BLOQUEOS_CLIENTES
				UPDATE #tmpBloqueosCltes
				SET #tmpBloqueosCltes.blqTodos  = b.blqTodos
				, #tmpBloqueosCltes.blqForward  = b.blqForward
				, #tmpBloqueosCltes.blqSwaps	= b.blqSwaps
				, #tmpBloqueosCltes.blqOpciones	= b.blqOpciones
				, #tmpBloqueosCltes.blqSpot		= b.blqSpot
				, #tmpBloqueosCltes.blqPactos	= b.blqPactos
				, #tmpBloqueosCltes.codMotivo	= b.codMotivo
				, #tmpBloqueosCltes.nomMotivo	= mb.descMotivo
				FROM BacParamsuda.dbo.TBL_BLOQUEOS_CLIENTES b
				INNER JOIN BacParamsuda.dbo.TBL_MOTIVOS_BLOQUEOCLIENTES mb ON mb.codMotivo = b.codMotivo
				WHERE	b.rutCliente = #tmpBloqueosCltes.Clrut
				AND		b.codCliente = #tmpBloqueosCltes.Clcodigo

				SELECT
				Clrut
				,Clcodigo
				,Clnombre
				,blqTodos
				,blqForward
				,blqSwaps
				,blqOpciones
				,blqSpot
				,blqPactos
				,codMotivo
				,nomMotivo
				FROM #tmpBloqueosCltes
				DROP TABLE #tmpBloqueosCltes
		END
		ELSE
		BEGIN
			IF EXISTS(SELECT rutCliente FROM BacParamsuda.dbo.TBL_BLOQUEOS_CLIENTES
					WHERE rutCliente = @bCliente AND codCliente = @bCodigo)
				SELECT 
				 rutCliente
				,codCliente
				,cl.Clnombre
				,blqTodos
				,blqForward
				,blqSwaps
				,blqOpciones
				,blqSpot
				,blqPactos
				,bc.codMotivo
				,mb.descMotivo
				FROM BacParamsuda.dbo.TBL_BLOQUEOS_CLIENTES bc
				INNER JOIN BacParamsuda.dbo.CLIENTE cl ON rutCliente = cl.Clrut AND codCliente = cl.Clcodigo
				INNER JOIN BacParamsuda.dbo.TBL_MOTIVOS_BLOQUEOCLIENTES mb  ON mb.codMotivo = bc.codMotivo
				WHERE rutCliente = @bCliente
				AND codCliente = @bCodigo
			ELSE
				SELECT 
				 Clrut
				,Clcodigo
				,Clnombre
				,'N' AS 'blqTodos'
				,'N' AS 'blqForward'
				,'N' AS 'blqSwaps'
				,'N' AS 'blqOpciones'
				,'N' AS 'blqSpot'
				,'N' AS 'blqPactos'
				,-1  AS 'codMotivo'
				,''  AS 'nomMotivo'
				FROM BacParamsuda.dbo.CLIENTE
				WHERE Clrut = @bCliente
				AND Clcodigo = @bCodigo

		END
	END	--- @modoOperacion = 'L'
	IF @modoOperacion = 'E'		---Eliminar de la tabla de bloqueos, Cliente no bloqueado
		--- Si existe en la tabla lo borro, sino no hago nada.
		IF EXISTS(SELECT rutCliente FROM BacParamsuda.dbo.TBL_BLOQUEOS_CLIENTES 
				WHERE rutCliente = @bCliente AND codCliente = @bCodigo)
			DELETE FROM BacParamsuda.dbo.TBL_BLOQUEOS_CLIENTES
			WHERE rutCliente = @bCliente AND codCliente = @bCodigo

	IF @modoOperacion = 'G'		---Grabar (Insertar o Modificar)
	BEGIN
		IF EXISTS(SELECT rutCliente FROM BacParamsuda.dbo.TBL_BLOQUEOS_CLIENTES 
				WHERE rutCliente = @bCliente AND codCliente = @bCodigo)
		--- Actualizar
			UPDATE BacParamsuda.dbo.TBL_BLOQUEOS_CLIENTES
			SET rutCliente	= @bCliente
			,	codCliente	= @bCodigo
			,	blqTodos	= @bTod
			,	blqForward	= @bFwd
			,	blqSwaps	= @bSwp
			,	blqOpciones	= @bOpc
			,	blqSpot		= @bSpt
			,	blqPactos	= @bPac
			,	codMotivo	= @bMot
			WHERE rutCliente = @bCliente AND codCliente = @bCodigo
		ELSE	--- Insertar
			INSERT INTO BacParamsuda.dbo.TBL_BLOQUEOS_CLIENTES
			VALUES(@bCliente
				,@bCodigo
				,@bTod
				,@bFwd
				,@bSwp
				,@bOpc
				,@bSpt
				,@bPac
				,@bMot)
	END
	SET NOCOUNT OFF
END
GO
