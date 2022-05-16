USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CORRESPONSAL_DPX]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CORRESPONSAL_DPX] ( @nrut NUMERIC(10), @CodMone CHAR(10))
as
begin
 select Codigo_Nemo,
  SUBSTRING( Nombre_Corresponsal,1,50) + '       CTA: ' + Cuenta_Corresponsal
 from view_CLIENTE_CORRESPONSAL
 where Rut_Cliente  = @nrut
 AND Codigo_Moneda = @CodMone
End
--  select * from view_CLIENTE_CORRESPONSAL
-- sp_help view_CLIENTE_CORRESPONSAL


GO
