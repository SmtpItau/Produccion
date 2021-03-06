USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_LeerProductos_Forward]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[Sp_LeerProductos_Forward] 
	( @sistema  char(3))

AS 

BEGIN
SET NOCOUNT ON

declare @producto table (id_sistema char(3), descripcion varchar(100),codigo_producto varchar(10))

insert into @producto 
select 'BFW',DESCRIPCION, IDDATOITAU FROM 
bacparamsuda.dbo.tblconversionitaucorp
WHERE IDPARAMETRO=666

INSERT INTO @producto 
SELECT ID_SISTEMA, DESCRIPCION, CODIGO_PRODUCTO FROM PRODUCTO WHERE ID_SISTEMA<>'BFW'



	IF @sistema <> '0' 

	BEGIN
		SELECT 
		codigo_producto		,
		descripcion		
		FROM @PRODUCTO
		WHERE   id_sistema = @sistema

	END ELSE BEGIN 
		SELECT  codigo_producto		,
			descripcion		
		FROM @PRODUCTO 
		WHERE   id_sistema = 'BCC' OR 
			id_sistema = 'BFW' OR 
			id_sistema = 'PCS' 
		ORDER BY id_sistema 

	END

SET NOCOUNT OFF
END




-- Base de Datos -- 
GO
