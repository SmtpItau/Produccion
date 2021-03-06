USE [BacParamSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[fxCliente]    Script Date: 13-05-2022 10:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [dbo].[fxCliente]( @nRutcli INT, @iCodigo SMALLINT, @sOrigen VARCHAR(4)) RETURNS VARCHAR(50)
AS 
BEGIN
	
	DECLARE @sCliente VARCHAR(50)
	
		SET	@sCliente ='N/D'
		 
		IF @sOrigen ='CDB' OR @sOrigen ='CCBB'  
		BEGIN
				IF EXISTS (SELECT 1 FROM LNKBACBDC72.bdc72.dbo.persona WHERE per_id = @nrutcli)
				BEGIN
					SELECT @sCliente = per_raz_social FROM LNKBACBDC72.bdc72.dbo.persona WHERE per_id = @nrutcli  
				END
				ELSE
				BEGIN -- Tabla Replica de la CCBB
					SELECT @sCliente = per_raz_social FROM dbo.persona WHERE per_id = @nrutcli  
				END
		END
		
		IF @sOrigen ='GPI' OR @sOrigen ='AGV'  
		BEGIN
				SELECT @sCliente = case when tipo_entidad='N' THEN nombres+' '+ paterno+ ' '+materno ELSE  razon_social end FROM gpimas.dbo.cliente WHERE  CONVERT(NUMERIC(9),SUBSTRING(RUT_CLIENTE,1,LEN(LTRIM(RTRIM(rut_cliente)))-2)) = @nRutcli
		END		

		IF @sOrigen ='FFMM'
		BEGIN
			
				SELECT @sCliente = Nombre
				FROM 		 
					(SELECT distinct cli_rut AS Rut , cli_razon_social  as Nombre FROM bacinver.dbo.inv_clientes 
					UNION
					SELECT rut_participe, case tipo_persona when 1 then nombres+' '+apellido_paterno+' '+apellido_materno else razon_social end FROM fmparticipes.dbo.fmp_participes 
					) AS Tabla
			 
				WHERE rut = @nRutcli
		END		

		IF @sOrigen ='BCC' or @sOrigen ='BTR' OR @sOrigen ='BFW' OR @sOrigen ='PCS' OR @sOrigen ='BEX' OR @sOrigen ='OPT' OR @sOrigen ='BANCO' 
		BEGIN
				SELECT @sCliente = clnombre FROM BACPARAMSUDA.DBO.CLIENTE WHERE clRut = @nRutcli AND Clcodigo=@iCodigo
		END		
		
		IF @sOrigen = 'ALMTO' OR @sOrigen = 'TFDO' 	
		BEGIN
				SELECT @sCliente = sCNBRazonSocial FROM dbo.SADP_ClientesNoBanco WHERE iRutCliente = @nRutCli AND iCodCliente = @iCodigo
		END

		IF @sOrigen ='DVP' 
		BEGIN
				SELECT TOP 1 @sCliente = NombreCliente FROM sadp_archivoCSVRegistra WHERE iOPE_RutCliente = @nRutcli
		END	

		RETURN 	@sCliente
END
GO
