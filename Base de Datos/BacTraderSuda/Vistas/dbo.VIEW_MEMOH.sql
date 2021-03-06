USE [BacTraderSuda]
GO
/****** Object:  View [dbo].[VIEW_MEMOH]    Script Date: 16-05-2022 10:13:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  vista dbo.view_MEMOH    fecha de la secuencia de comandos: 05/04/2001 9:20:54 ******/
CREATE VIEW [dbo].[VIEW_MEMOH]
AS
SELECT
moentidad             ,       
motipmer              ,   
monumope              , 
motipope              , 
morutcli              ,
mocodcli              ,
monomcli              ,              
mocodmon              ,
mocodcnv              ,
momonmo               ,            
moticam               ,           
motctra               ,          
motcfin               ,         
moparme               ,        
moparcie              ,       
mopartr               ,      
mopar30               ,     
moparfi               ,    
moprecio              ,   
mopretra              ,  
moprefi               , 
moussme               ,
mouss30               ,
mousstr               ,
moussfi               ,
momonpe               ,
moentre               ,
morecib               ,
movaluta1             ,                   
movaluta2             ,                  
movamos               ,
motlxp1               ,
motlxp2               ,
mooper                ,  
mofech                ,                  
mohora                ,
moterm                ,   
mocodoma              ,
moestatus             ,
moimpreso             ,
mopcierre             ,
morentab              ,
mocencos              ,                          
mounidad              ,                         
mocodejec             ,
mogrpgen              ,
mogrppro              ,
mocorres              ,
moejecuti             ,
mopmeco               , 
mopmeve               ,
mototco               ,         
mototve               ,        
mototcom              ,       
mototvem              ,      
moenvia               ,
moalinea              ,
moaprob               ,
monumche              ,
mocarta               ,
motipcar              ,
monumfut              , 
mofecini   
FROM BACCAMSUDA..MEMOH

GO
