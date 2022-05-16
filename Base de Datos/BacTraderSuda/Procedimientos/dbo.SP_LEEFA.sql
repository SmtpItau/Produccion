USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEEFA]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LEEFA]
         (@emnombre1 char (30))
as
begin   
 select  codigo  ,
         glosa  ,
                perfil,
                codgen,
                glosa2,
                cc2756,
            afectacorr,   
             diasvalor,
             numcheque,
                ctacte
        from
               VIEW_FORMA_DE_PAGO
      where
         glosa  > @emnombre1
      order by
         glosa
   
return
end  


GO
