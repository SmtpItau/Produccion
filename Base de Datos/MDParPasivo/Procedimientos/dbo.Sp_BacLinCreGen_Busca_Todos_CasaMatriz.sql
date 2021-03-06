USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_BacLinCreGen_Busca_Todos_CasaMatriz]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_BacLinCreGen_Busca_Todos_CasaMatriz] 

AS
BEGIN

   DECLARE @nombre CHAR(70)	

   SET TRANSACTION ISOLATION LEVEL READ COMMITTED
   SET NOCOUNT ON
   SET DATEFORMAT dmy

   IF EXISTS (SELECT TOP 1 1 FROM LINEA_GENERAL WITH (NOLOCK) )
   BEGIN

      SET @nombre = ' ' --(SELECT clnombre FROM CLIENTE WHERE clrut = @rut_cliente)	
      
      SELECT  '@nombre'           = ( SELECT clnombre FROM CLIENTE WITH (NOLOCK) where clrut = L.rut_cliente AND clcodigo = L.codigo_cliente )
	,     rut_cliente
	,     codigo_cliente
	,     fechaasignacion
	,     fechavencimiento
	,     fechafincontrato
	,     bloqueado
	,     totalasignado
	,     totalocupado
	,     totaldisponible
	,     totalexceso
	,     totaltraspaso
	,     totalrecibido
	,     rutcasamatriz
	,     codigocasamatriz
        ,     'nombre'            = ( SELECT clnombre FROM CLIENTE WITH (NOLOCK) where clrut = L.rut_cliente AND clcodigo = L.codigo_cliente )
      FROM    LINEA_GENERAL L WITH (NOLOCK)
      ORDER BY
              nombre

   END ELSE 
   BEGIN
		SELECT  
			 'nombre'		= ' '
			,'rut_cliente'		= 0
			,'codigo_cliente'	= 0
			,'fechaasignacion'	= ' '
			,'fechavencimiento'	= ' '
			,'fechafincontrato'	= ' '
			,'bloqueado'		= ' '
			,'totalasignado'	= 0
			,'totalocupado'		= 0
			,'totaldisponible'	= 0
			,'totalexceso'		= 0
			,'totaltraspaso'	= 0
			,'totalrecibido'	= 0
			,'rutcasamatriz'	= 0
			,'codigocasamatriz'	= 0


	END

END





GO
