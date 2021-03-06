USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEEFA]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LEEFA] 
    (@EMNOMBRE1 CHAR (30))
AS
BEGIN   
set nocount on
 SELECT  
                codigo  ,
         glosa  ,
                perfil,
                codgen,
                glosa2,
                cc2756,
            afectacorr,   
             diasvalor,              numcheque,
                ctacte
        FROM         VIEW_FORMA_DE_PAGO
      WHERE         glosa  > @EMNOMBRE1
      ORDER BY         glosa
 select 0
   RETURN
set nocount off
END
GO
