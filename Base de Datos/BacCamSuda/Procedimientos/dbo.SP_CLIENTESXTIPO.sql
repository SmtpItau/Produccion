USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CLIENTESXTIPO]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_CLIENTESXTIPO] 
        ( @TIPO INTEGER )
AS
BEGIN
SET NOCOUNT ON
    IF @TIPO = 1    
 SELECT clrut 
             , cldv 
             , clcodigo 
             , clnombre 
             , clgeneric 
             , cldirecc 
             , clcomuna 
             , clregion 
             , cltipcli 
             , clfecingr 
             , clctacte 
             , clfono 
             , clfax 
             , cltipcli 
             , clcalidadjuridica 
             , clciudad 
             , clentidad 
             , clmercado 
             , clgrupo 
             , clapoderado 
             , clpais 
             , clnomb1
             , clnomb2
             , clapelpa
             , clapelma 
          FROM VIEW_CLIENTE
  WHERE clopcion = 'J'
           AND (cltipcli = @TIPO or @tipo = 0)
 
      ORDER BY clnombre
     ELSE
 SELECT clrut 
            , cldv 
            , clcodigo 
            , clnombre 
            , clgeneric 
            , cldirecc 
            , clcomuna 
            , clregion 
            , cltipcli 
            , clfecingr 
            , clctacte 
            , clfono 
            , clfax 
            , cltipcli 
            , clcalidadjuridica 
            , clciudad 
            , clentidad 
            , clmercado 
            , clgrupo 
            , clapoderado 
            , clpais 
            , clnomb1 
            , clnomb2 
            , clapelpa 
            , clapelma 
          FROM VIEW_CLIENTE
         
         WHERE clopcion = 'N' OR clopcion = 'J'  ---@tipo = 0 or @tipo = cltipcli  (modificado)
           AND (cltipcli = @TIPO or @tipo = 0)
      ORDER BY clnombre
SET NOCOUNT OFF
END



GO
