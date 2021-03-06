USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_PASSWORD]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LEER_PASSWORD]
            ( @usuario  char(15))  -- usuario  ) 
as
begin
        select usuario  ,
               nombre   ,
               password ,
               password2,
               fechaexp ,
               idconect ,
               codoper  ,
               tipoper  ,
               idbloqueo,
               fecexppas,
              ultmodpass,
              password11,
              password12,
              password13,
              password14,
              password15,
              password21,
              password22,
              password23,
              password24,
              password25      
          from  bacuser
          where usuario = @usuario
end


GO
