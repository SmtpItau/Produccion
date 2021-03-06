USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONTROLA_DEVENGOS]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CONTROLA_DEVENGOS]
AS 
BEGIN

   SET NOCOUNT ON     
   
CREATE TABLE #Temp
          (
          Modulo        CHAR (03)      ,                        -- 1
          Devengo       CHAR (01)      ,                        -- 2                   
          NombreModulo  CHAR (30)      
          )

      

/*    SELECT acsw_dvprop 
            ,acsw_dvci 
            ,acsw_dvvi 
            ,acsw_dvib 
      FROM  MDAC
*/
            
      INSERT INTO #Temp     
      SELECT 'BEX'
            ,CASE WHEN acsw_dv =1 OR  acsw_fd =1  THEN '1' ELSE '0' END 
            ,(SELECT nombre_sistema  FROM  VIEW_SISTEMA_CNT WHERE  id_sistema ='BEX')
      FROM  BacBonosExtSuda..text_arc_ctl_dri
      
      INSERT INTO #Temp     
      SELECT 'BFW'
            ,acsw_devenfwd     
            ,(SELECT nombre_sistema  FROM  VIEW_SISTEMA_CNT WHERE  id_sistema ='BFW')
      FROM  BacFwdSuda..mfac
   

      INSERT INTO #Temp     
      SELECT 'PCS'
            ,devengo     
            ,(SELECT nombre_sistema  FROM  VIEW_SISTEMA_CNT WHERE  id_sistema ='PCS')
      FROM  BacSwapSuda..SwapGeneral


      SELECT *  FROM #Temp     

   SET NOCOUNT OFF


END




GO
