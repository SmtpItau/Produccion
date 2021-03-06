USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULHIJOS]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_ConsulHijos    fecha de la secuencia de comandos: 03/04/2001 15:18:00 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_ConsulHijos    fecha de la secuencia de comandos: 14/02/2001 09:58:24 ******/
CREATE PROCEDURE [dbo].[SP_CONSULHIJOS] 
                                (@rutpadre NUMERIC(10),
     @codigo   NUMERIC( 3) )
AS
BEGIN     
 SELECT  clrut_hijo    ,
  clcodigo_hijo ,
  clporcentaje  ,
  (SELECT clnombre  FROM CLIENTE WHERE clrut = clrut_hijo)
 
        FROM
         CLIENTE_RELACIONADO 
      WHERE
         clrut_padre    = @rutpadre AND
                clcodigo_padre = @codigo
  
      
 ORDER BY clrut_hijo
   
END  
GO
