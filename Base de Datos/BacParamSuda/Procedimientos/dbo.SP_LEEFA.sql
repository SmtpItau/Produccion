USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEEFA]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LEEFA] (@emnombre1 CHAR (30))
AS
BEGIN   
 SELECT  codigo  ,
         glosa  ,
                perfil,
                codgen,
                glosa2,
                cc2756,
            afectacorr,   
             diasvalor,
             numcheque,
                ctacte
        FROM
         FORMA_DE_PAGO
      WHERE
         glosa  > @emnombre1
      ORDER BY
         glosa
   RETURN
END  

GO
