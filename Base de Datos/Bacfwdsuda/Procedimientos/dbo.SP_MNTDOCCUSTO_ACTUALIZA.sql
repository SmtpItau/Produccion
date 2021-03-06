USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MNTDOCCUSTO_ACTUALIZA]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_MNTDOCCUSTO_ACTUALIZA] ( @CONTENTVIA CHAR (1),
      @CONTEMIPOR CHAR(1),
      @CONTUBICEN CHAR(1),
      @FECHEMI DATETIME,
      @FECHRECEP DATETIME,
      @FECHINGCUS DATETIME,
      @FECHFIRCON DATETIME,
      @FECHRETCUS DATETIME,
      @NUMCONTCLI NUMERIC(9),
      @canumoper  NUMERIC(10))    
as
begin
set nocount on
UPDATE MFCA SET 
                  Contrato_Entrega_Via = @CONTENTVIA,
                  Contrato_Emitido_por = @CONTEMIPOR,
                  Contrato_Ubicado_en  = @CONTUBICEN,
                  FechaEmision = @FECHEMI,
                  FechaRecepcion = @FECHRECEP,
                  FechaIngresocustodia  = @FECHINGCUS,
                  FechaFirmacontrato = @FECHFIRCON,
                  FechaRetirocustodia = @FECHRETCUS,
                  NumeroContratoCliente = @NUMCONTCLI
  WHERE
    canumoper=@canumoper
  
           if @@error<>0
         begin
         select 'error'
    end else
         begin
                select ' modifica'
    end
  set nocount off
END

GO
