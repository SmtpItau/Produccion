USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CLIENTESXRUT]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CLIENTESXRUT]( @Rut VARCHAR(10) )
AS
BEGIN
  SET ROWCOUNT 50
  SELECT clrut 
        ,cldv 
        ,clcodigo  
        ,clnombre 
        ,clgeneric 
        ,cldirecc 
        ,clcomuna 
        ,clregion 
        ,cltipcli 
        ,clfecingr 
        ,clctacte 
        ,clfono 
        ,clfax 
        ,cltipcli 
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
   FROM VIEW_CLIENTE 
   WHERE RIGHT( '           ' + CONVERT( VARCHAR(10), clrut ), 9 ) >= @Rut
   ORDER BY clrut
     SET ROWCOUNT 0 
     RETURN
END
-- EXECUTE sp_ClientesxRUT ' 8'
-- SELECT RIGHT( '           ' + CONVERT( VARCHAR(10), clrut ), 9 ) FROM VIEW_CLIENTE



GO
