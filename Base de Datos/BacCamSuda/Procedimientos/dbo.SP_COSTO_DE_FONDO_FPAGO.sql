USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_COSTO_DE_FONDO_FPAGO]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_COSTO_DE_FONDO_FPAGO]
       (
        @nCodigoFPago     NUMERIC(03)=0
       )
AS
BEGIN
   SELECT       codigo, glosa, costo_de_fondo, perfil, codgen, glosa2, cc2756, afectacorr, diasvalor, numcheque, ctacte
          FROM  view_forma_de_pago
          WHERE codigo = @nCodigoFPago OR @nCodigoFPago = 0
END



GO
