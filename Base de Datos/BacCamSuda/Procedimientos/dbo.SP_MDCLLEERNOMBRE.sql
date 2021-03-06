USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MDCLLEERNOMBRE]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[SP_MDCLLEERNOMBRE] 
       (
        @cnombre     char(40)          -- generico del cliente
       )
as
begin
set nocount on
   select       clrut                                ,
                cldv                                 ,
                clcodigo                             ,
                clnombre                             ,
                clgeneric                            ,
                cldirecc                             ,
                clcomuna                             ,
                clregion                             ,
--                cltipocliente                        ,
                convert( char(10), clfecingr, 103 )  ,
                clctacte                             ,               
                clfono                               ,
                clfax                                ,
                cltipcli                              ,
                clcalidadjuridica                    ,             
  clciudad                             ,
                clentidad                            ,
                clmercado                            ,
                clgrupo                              ,
                clapoderado                          ,
                clpais,
                clnomb1,
                clnomb2,
                clapelpa,
                clapelma,
                clnemo,
                clctausd,
                climplic,
                claba,            
                clchips,   
                clswift,
                clopcion
            from     VIEW_CLIENTE
            where    clnombre > @cnombre  order by clnombre
 select 0
   return
set nocount off
end

GO
