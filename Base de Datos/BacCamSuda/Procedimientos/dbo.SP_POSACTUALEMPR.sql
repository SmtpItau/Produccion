USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_POSACTUALEMPR]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_POSACTUALEMPR]
-- ( @Moneda    CHAR(3))
--   @Negocio   NUMERIC(3) = 0) -- Consolidado segun MENEG
AS
BEGIN
 DECLARE @totalpos NUMERIC(12,2)
 DECLARE @Resul_Div NUMERIC(12,2)
 SELECT @Resul_Div = (SELECT (cp_totco+cp_totve) FROM meac)
 SET NOCOUNT ON
--     IF @Moneda='USD'
 IF @Resul_Div > 0
    BEGIN
       SELECT cp_pmecoci,
              cp_pmeveci,
              ((cp_totco*cp_pmecoci)+(cp_totve*cp_pmeveci))/(cp_totco+cp_totve),
              cp_totco,
              cp_totve,
              cp_totco + cp_totve,
              cp_totco - cp_totve,
              cp_utico,
              cp_utive,
              cp_utive + cp_utico,
              accoscomp,
              cp_utili,
              accosvent,
              acultempr,
              acultmonempr,
              acultpreempr
         FROM MEAC
    END
 ELSE
    BEGIN
       SELECT cp_pmecoci,
              cp_pmeveci,
              ((cp_totco*cp_pmecoci)+(cp_totve*cp_pmeveci))/1,
              cp_totco,
              cp_totve,
              cp_totco + cp_totve,
              cp_totco - cp_totve,
              cp_utico,
              cp_utive,
              cp_utive + cp_utico,
              accoscomp,
              cp_utili,
              accosvent,
              acultempr,
              acultmonempr,
              acultpreempr
         FROM MEAC
    END
     
 SET NOCOUNT OFF
END


GO
