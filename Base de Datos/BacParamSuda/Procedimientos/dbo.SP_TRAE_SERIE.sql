USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAE_SERIE]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_TRAE_SERIE](@xSerie CHAR(12))
AS
BEGIN
set nocount on
SELECT  secodigo    ,--1
 semascara    ,--2
 seserie     ,--3
 setera     ,--4
 semonemi    ,--5
 sebasemi    ,--6
 serutemi    ,--7
 CONVERT(CHAR(10),sefecemi,103) ,--8
 CONVERT(CHAR(10),sefecven,103) ,--9
 seplazo     ,--10
 setasemi    ,--11
 secupones    ,--12
 setipvcup    ,--13
 sepervcup    ,--14
 senumamort    ,--15
 sedecs     ,--16
 sediavcup    ,--17
 seffijos     ,--18
 sebascup    ,--19
 secorte                 , -- 20
 setipamort                  , --21
             setotalemitido                                             ,  --22
 tipo_letra        ,  --23          
 primer_vencimiento      --24
 FROM SERIE WHERE seserie = @xSerie
set nocount off
END 
GO
