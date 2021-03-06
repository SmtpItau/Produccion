USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MDCLLEERNOMBRE]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_MDCLLEERNOMBRE]
       ( @cnombre     char(40))          -- generico del cliente
as
begin
   declare @nombre varchar(255)
   select @nombre = '%' + rtrim(ltrim(@cnombre)) + '%'
   select       clrut                                ,
                cldv                                 , 
                clcodigo                             ,
                clnombre                             ,
                clgeneric                            ,
                cldirecc                             ,
                clcomuna                             ,
                clregion                             ,
--                cltipocliente                        ,
                cltipcli                        ,
                convert( char(10), clfecingr, 103 )  ,
                clctacte                             ,               
                clfono                               ,
                clfax                                ,
--                cltipocliente                        ,
                cltipcli                        ,
                clcalidadjuridica                    ,
  clciudad                             ,
                clentidad                            ,
                clmercado                            ,
                clgrupo                              ,
                clapoderado                          ,
                clpais         ,
                clnomb1,
                clnomb2,
                clapelpa,
                clapelma,
                clnemo,
                clctausd,
                climplic,
                claba,        
    
                clchips,
   
                clswift
          from   VIEW_CLIENTE   
--        where    clnombre like @nombre order by clnombre
         where    clnombre > @cnombre  order by clnombre
end
--sp_mdclleernombre 'de'
--select * from mdcl where clnombre like '%de%'


GO
