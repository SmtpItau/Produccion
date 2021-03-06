USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CLIENTESXGLOSA]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CLIENTESXGLOSA]
   (   @Glosa     CHAR(40) 
   ,   @mercado   CHAR(4)
      )
AS
BEGIN

  SET NOCOUNT ON

 IF @mercado = 'PTAS'
 BEGIN
  SELECT clrut 
        ,cldv 
        ,clcodigo  
   ,     clnombre = LTRIM(RTRIM( clnombre  ))
        ,clgeneric 
        ,cldirecc 
        ,clcomuna 
        ,clregion 
        ,cltipcli 
        ,clfecingr 
        ,clctacte 
        ,clfono 
        ,clfax 
        ,'cltipcli1' = cltipcli 
        ,clcalidadjuridica 
        ,clciudad 
        ,clEntidad 
        ,clMercado 
        ,clGrupo 
        ,clapoderado 
        ,clPais 
        ,clNomb1 
        ,clNomb2 
        ,clApelPa 
        ,clApelMa 
 ,clEjecuti
   FROM BacParamSuda..Cliente
   WHERE CLNOMBRE > @Glosa AND clvigente = 'S' AND cltipcli < 4 
 END

ELSE

   IF @mercado <> 'PTAS' AND @mercado <> ''
 BEGIN
  SELECT clrut 
        ,cldv 
        ,clcodigo  
	,clnombre = LTRIM(RTRIM( clnombre  ))
        ,clgeneric 
        ,cldirecc 
        ,clcomuna 
        ,clregion 
        ,cltipcli 
        ,clfecingr 
        ,clctacte 
        ,clfono 
        ,clfax 
        ,'cltipcli1' = cltipcli 
        ,clcalidadjuridica 
        ,clciudad 
        ,clEntidad 
        ,clMercado 
        ,clGrupo 
        ,clapoderado 
        ,clPais 
        ,clNomb1 
        ,clNomb2 
        ,clApelPa 
        ,clApelMa 
 	,clEjecuti
   FROM BacParamSuda..Cliente
   WHERE CLNOMBRE > @Glosa AND clvigente = 'S' AND cltipcli > 4 

  END

     RETURN
END



GO
