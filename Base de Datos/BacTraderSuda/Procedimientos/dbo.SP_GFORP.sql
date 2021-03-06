USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GFORP]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_GFORP]
                         (@codigo     numeric(2) ,
                          @glosa      char(30)   ,                        
                          @perfil     char(9)    ,                        
                          @codgen     numeric(3) ,                        
                          @glosa2     char(8)    ,                        
                          @cc2756     char(1)    ,                        
                          @afectacorr char(1)    ,                        
                          @diasvalor  numeric(3) ,                        
                          @numcheque  char(1)    ,                        
                          @ctacte     char(1)    )
as
begin
   set nocount on                         
  
   if exists (select codigo from VIEW_FORMA_DE_PAGO where codigo = @codigo )
            update VIEW_FORMA_DE_PAGO 
           set    codigo=  @codigo,
                  glosa =  @glosa,                        
                  perfil=  @perfil,                        
                  codgen=  @codgen,                        
                  glosa2=  @glosa2,                        
                  cc2756=  @cc2756,                        
              afectacorr=  @afectacorr,                        
              diasvalor =  @diasvalor,                        
              numcheque =  @numcheque,                        
                ctacte  =  @ctacte     
           where codigo = @codigo
   else
         insert VIEW_FORMA_DE_PAGO 
                  ( codigo,
                     glosa,                        
                    perfil,                        
                    codgen,                        
                    glosa2,                        
                    cc2756,                        
                afectacorr,                        
                 diasvalor,                        
                 numcheque,                        
                    ctacte  )    
        values ( @codigo,
                 @glosa,                        
                 @perfil,                        
                 @codgen,                        
                 @glosa2,                        
                 @cc2756,                        
             @afectacorr,                        
              @diasvalor,                        
              @numcheque,                        
                 @ctacte            )
if @@error <> 0 begin
   SELECT 'NO'
   set nocount off
   return
end
set nocount off
SELECT 'SI'
end

GO
