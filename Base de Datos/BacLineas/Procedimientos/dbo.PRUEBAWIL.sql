USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[PRUEBAWIL]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PRUEBAWIL]
          ( @Nombre CHAR(25)='')
AS
BEGIN
 IF @Nombre ='' BEGIN
    SELECT 'RUT'=STR(clrut) + '-' + cldv, clcodigo,clnombre , STR(clrut),cldv  FROM CLIENTE WHERE cltipcli = 1 Order By clnombre
 END
 ELSE BEGIN
    SELECT 'RUT'=STR(clrut) + '-' + cldv, clcodigo,clnombre , STR(clrut),cldv 
                  FROM CLIENTE 
                   WHERE clnombre like @Nombre -- Order By clnombre
 END
END
--   PRUEBAWIL 'CL'
GO
