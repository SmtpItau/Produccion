USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VIEW_CLIENTELEERNOMBRE]    Script Date: 16-05-2022 12:48:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/****** objeto:  procedimiento  almacenado dbo.sp_VIEW_CLIENTEbuscapais    fecha de la secuencia de comandos: 05/04/2001 13:13:44 ******/
CREATE procedure [dbo].[SP_VIEW_CLIENTELEERNOMBRE]
       ( @cnombre     char(40))          -- generico del cliente
as
begin
   declare @nombre varchar(255)
   select @nombre = '''%'' + rtrim(ltrim(@cnombre)) + ''%'''
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
--sp_VIEW_CLIENTEleernombre 'de'
--select * from VIEW_CLIENTE where clnombre like '%de%'



GO
