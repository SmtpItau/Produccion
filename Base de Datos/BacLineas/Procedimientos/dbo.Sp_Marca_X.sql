USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Marca_X]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






/****** Objeto:  procedimiento  almacenado dbo.Sp_Marca_X    fecha de la secuencia de comandos: 03/04/2001 15:18:08 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_Marca_X    fecha de la secuencia de comandos: 14/02/2001 09:58:29 ******/
CREATE PROCEDURE [dbo].[Sp_Marca_X](@Sistema char(5),
       --@produ   integer = 0) 
       @produ   CHAR(5) = '0') 
AS
BEGIN
     SET NOCOUNT ON
     SELECT mpproducto           ,
            mpcodigo             ,
     mpestado          ,  
            mpsistema            
       FROM PRODUCTO_MONEDA
       WHERE (mpsistema  = @sistema 
   and mpproducto = @produ )   
END






GO
