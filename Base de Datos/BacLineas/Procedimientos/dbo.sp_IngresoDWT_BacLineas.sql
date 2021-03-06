USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[sp_IngresoDWT_BacLineas]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_IngresoDWT_BacLineas]
(
	@FechaIngreso	 Datetime,
	@Seq			 int ,
	@Registro		 varchar(100),
	@nombreArchivo	 varchar(30)

)
as 
begin


insert into IngresoDWT_BacLineas values (@FechaIngreso, @Seq, @Registro, @nombreArchivo)

if @@ERROR <> 0
begin
	select '-1 Error en insert a Tabla IngresoDWT_BacLineas' as Resultado 
end
else 
begin
	select '1 Ingreso Exitoso' as Resultado 
end

end
GO
