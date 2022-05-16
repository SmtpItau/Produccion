USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CAMBIARPASSWORD]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CAMBIARPASSWORD]
       (
        @cusuario     char(12),
        @cpassword1   char(15),
        @cpassword2   char(15)
       )
as
begin
   update BACUSER
          set password11 = password   ,
              password12 = password11 ,
              password13 = password12 ,
              password14 = password13 ,
              password15 = password14 ,
              password21 = password2  ,
              password22 = password21 ,
              password23 = password22 ,
              password24 = password23 ,
              password25 = password24 , 
        password   = @cpassword1,
              password2  = @cpassword2,
              fecexppas = dateadd(month ,1,fecexppas)
         where usuario = @cusuario
end
-- execute sp_cambiarpassword 'pancho', 'hc`ebgd', 'gmbgdafk'


GO
