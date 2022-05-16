USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[Pruebawil]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Pruebawil]
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
--   Pruebawil 'CL'
GO
