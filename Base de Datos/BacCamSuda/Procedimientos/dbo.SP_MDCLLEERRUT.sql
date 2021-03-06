USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MDCLLEERRUT]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_MDCLLEERRUT](
				@nrutcli     NUMERIC(9,0),   
				@ndigito     CHAR   (  1),
				@ncodcli     NUMERIC(9,0)
				)
AS 
BEGIN
set nocount on
   SELECT       clrut                                ,
                cldv                                 ,
                clcodigo                             ,
                clnombre                             ,
                clgeneric                            ,
                cldirecc                             ,   
  		clcomuna                             ,
                clregion                             ,
                cltipomx                             ,
                convert( char(10), clfecingr, 103 )  ,
                clctacte                             ,
                clfono                               ,
                clfax                                ,
                cltipcli                             ,
                clcalidadjuridica                    ,
                clciudad                             ,
                clentidad                            ,
                clmercado                            ,
                clgrupo                              ,
                clapoderado                          ,
         	clpais         ,
                clnomb1                              ,
                clnomb2                              ,
                clapelpa                             ,
                clapelma                             ,
                clnemo                               ,
                clctausd                             ,
                climplic                             ,
                claba                                ,            
                clchips                              ,       
                clswift                              ,
                clopcion                             ,
  		clrelacion                           ,
  		clcatego                             ,
  		clsector                             ,
  		clclsbif        ,
  		clactivida                           ,
  		cltipemp                             ,
  		relbco                               ,
  		poder                                ,
  		firma                                ,
  		relcia                               ,
  		relcor                               ,
  		infosoc                              ,
  		art85                                ,
  		dec85                                ,
                rut_grupo                            ,
         	clcodfox                             ,
  		cod_inst                             ,
  		clcodban        ,
        	clcrf                                , 
                clerf                                , 
  		convert(char(10),clvctolineas,103)   ,      
                oficinas                             , 
                clclaries                            ,  
                codigo_Otc                           , 
                Bloqueado        ,
  		clcosto         ,
  		Clejecuti,
                cldvcliexterno 
          FROM  VIEW_CLIENTE    
          WHERE clrut     = @nrutcli
          and  (cldv      = @ndigito  or  @ndigito = 0)
          and   clcodigo  = @ncodcli
SET NOCOUNT OFF
END
GO
