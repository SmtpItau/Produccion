USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_COSTO_VALUTA]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_COSTO_VALUTA]
AS
BEGIN
 SELECT glosa
       ,costo_de_fondo
       ,codigo 
   FROM view_moneda_forma_de_pago,
        view_forma_de_pago
  WHERE mfcodmon = 13 AND
        mfcodfor = codigo 
END  



GO
