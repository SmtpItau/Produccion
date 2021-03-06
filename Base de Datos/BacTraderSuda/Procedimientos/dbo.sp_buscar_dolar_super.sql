USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[sp_buscar_dolar_super]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC  [dbo].[sp_buscar_dolar_super] (@fecha CHAR(10))
AS
---------- LD1-COR-035 LIMITE ENDEUDAMIENTO

/***********************************************************************
NOMBRE         : dbo.sp_buscar_dolar_super.StoredProcedure.sql
AUTOR          : SONDA (Unidad de Desarrollo)
FECHA CREACION : 09/08/2011
DESCRIPCION    : Migracion a SQL 2008
HISTORICO DE CAMBIOS
FECHA        AUTOR           DESCRIPCION   
----------------------------------------------------------------------


**********************************************************************/

begin
	 set rowcount 1

	 if not exists(SELECT vmvalor ,vmfecha from view_valor_moneda WHERE vmcodigo = 14 AND DATEPART(M,VMFECHA) = DATEPART(M,@FECHA)and DATEPART(yy,VMFECHA) = DATEPART(yy,@FECHA) ) begin
		select 0
	 end else begin
		SELECT vmvalor ,vmfecha from view_valor_moneda WHERE vmcodigo = 14 AND DATEPART(M,VMFECHA) = DATEPART(M,@FECHA) and DATEPART(yy,VMFECHA) = DATEPART(yy,@FECHA)
	end
end	

GO
