USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_MDCLLeerRut]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






CREATE PROCEDURE [dbo].[Sp_MDCLLeerRut](	@nrutcli     NUMERIC(9,0),   
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
		clcosto         		     ,
		Clejecuti                            ,
		mxcontab 			     ,
	        clrutcliexterno			     ,
		cldvcliexterno			     ,
		convert( char(10), fecha_condiciones, 103 )		

	
          FROM  CLIENTE    WHERE clrut     = @nrutcli
                         and  (cldv     = @ndigito  or  @ndigito = 0)
                         and  clcodigo  = @ncodcli
SET NOCOUNT OFF
END 












GO
