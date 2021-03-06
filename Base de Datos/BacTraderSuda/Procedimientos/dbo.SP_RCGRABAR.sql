USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RCGRABAR]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_RCGRABAR]
                             (@rccodcar1   NUMERIC (10,0) ,
                @rcrut1      NUMERIC (09,0) , 
                              @rcdv1       CHAR    (01)   ,
                              @rcnombre1   CHAR    (50)   ,
                              @rcnumoper1  NUMERIC (10)   ,
                              @rctelefono1 CHAR    (30)   ,
                              @rcfax1      CHAR    (30)   ,
                              @rcdirecc1   CHAR    (50)   )
AS
BEGIN
   set nocount on
     IF EXISTS(SELECT rccodcar FROM VIEW_ENTIDAD MDRC WHERE rcrut = @rcrut1)
     
        UPDATE VIEW_ENTIDAD SET rccodcar  = @rccodcar1   ,
                        rcrut     = @rcrut1      ,
                        rcdv      = @rcdv1       ,
                        rcnombre  = @rcnombre1   ,
                        rcnumoper = @rcnumoper1  ,
                        rctelefono= @rctelefono1 ,
                        rcfax     = @rcfax1      ,
                        rcdirecc  = @rcdirecc1 
               WHERE    rcrut     = @rcrut1
     ELSE        
               INSERT INTO VIEW_ENTIDAD    (   rccodcar,   rcrut,   rcdv,   rcnombre,   rcnumoper,   rctelefono,   rcfax,   rcdirecc)
                           VALUES ( @rccodcar1, @rcrut1, @rcdv1, @rcnombre1, @rcnumoper1, @rctelefono1, @rcfax1, @rcdirecc1)
   select 'OK'
   set nocount off
END

GO
