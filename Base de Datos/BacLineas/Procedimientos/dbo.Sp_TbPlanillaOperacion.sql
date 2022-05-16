USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_TbPlanillaOperacion]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO







/****** Objeto:  procedimiento  almacenado dbo.Sp_TbPlanillaOperacion    fecha de la secuencia de comandos: 03/04/2001 15:18:12 ******/
create procedure [dbo].[Sp_TbPlanillaOperacion]
  (@comercio char (6),
   @concepto char(3)
  )
as
begin
 set nocount off
 SELECT a.comercio,a.concepto,b.glosa,a.tipo_documento,a.tipo_operacion_cambio 
 FROM CODIGO_PLANILLA_AUTOMATICA a, CODIGO_COMERCIO b 
 WHERE a.comercio = @comercio
        AND   a.concepto = @concepto
     set nocount on
end







GO
